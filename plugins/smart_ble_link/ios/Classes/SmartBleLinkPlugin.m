#import "SmartBleLinkPlugin.h"
#import "JYTools.h"
#import "UDPManage.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@interface SmartBleLinkPlugin () <FlutterStreamHandler, BleDelegate, udpDelegate,
    CBCentralManagerDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) FlutterEventChannel *eventChannel;
@property (nonatomic, copy) FlutterEventSink eventSink;
@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSTimer *udpTimer;
@property (nonatomic, strong) NSTimer *timeoutTimer;
@property (nonatomic, assign) BOOL finished;
@property (nonatomic, copy) NSString *userData;

@end

@implementation SmartBleLinkPlugin

static SmartBleLinkPlugin *_sharedPlugin = nil;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    _sharedPlugin = [[SmartBleLinkPlugin alloc] init];
    _sharedPlugin.eventChannel =
        [FlutterEventChannel eventChannelWithName:@"smart_ble_link/events"
                                  binaryMessenger:registrar.messenger];
    [_sharedPlugin.eventChannel setStreamHandler:_sharedPlugin];

    FlutterMethodChannel *methodChannel =
        [FlutterMethodChannel methodChannelWithName:@"smart_ble_link/method"
                                    binaryMessenger:registrar.messenger];
    [methodChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        [_sharedPlugin handleMethodCall:call result:result];
    }];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([call.method isEqualToString:@"startLinking"]) {
        [self handleStartLinking:call.arguments result:result];
    } else if ([call.method isEqualToString:@"stopLinking"]) {
        [self stopEverything];
        self.finished = YES;
        result(nil);
    } else if ([call.method isEqualToString:@"isBluetoothEnabled"]) {
        result(@([self bluetoothEnabled]));
    } else if ([call.method isEqualToString:@"isBleSupported"]) {
        result(@YES);
    } else if ([call.method isEqualToString:@"requestEnableBluetooth"]) {
        result(FlutterMethodNotImplemented);
    } else if ([call.method isEqualToString:@"requestPermissions"]) {
        [self ensureManagers];
        [self.locationManager requestWhenInUseAuthorization];
        result(@YES);
    } else if ([call.method isEqualToString:@"getConnectedSsid"]) {
        result([self currentSSID]);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)handleStartLinking:(NSDictionary *)args result:(FlutterResult)result {
    [self ensureManagers];

    NSString *ssid = args[@"ssid"];
    NSString *password = args[@"password"];
    NSString *bleName = args[@"bleName"];
    self.userData = args[@"userData"] ?: @"";
    BOOL dynamicPassword = [args[@"dynamicPassword"] boolValue];
    NSInteger timeoutSeconds = [args[@"timeoutSeconds"] integerValue];
    if (timeoutSeconds <= 0) {
        timeoutSeconds = 60;
    }

    if (![ssid isKindOfClass:[NSString class]]) {
        ssid = nil;
    }
    if (ssid.length == 0) {
        ssid = [self currentSSID];
    }
    if (ssid.length == 0) {
        result([FlutterError errorWithCode:@"INVALID_ARGUMENT"
                                   message:@"ssid is empty and cannot be detected"
                                   details:nil]);
        return;
    }

    [JYTools setSSID:ssid];
    [JYTools setPassword:[password isKindOfClass:[NSString class]] ? password : @""];
    [JYTools setBLEName:bleName.length > 0 ? bleName : @"AZ"];
    [JYTools setUserData:self.userData];
    [JYTools setDynamic:dynamicPassword];

    self.finished = NO;
    [UDPManage shareUDPManage].UDPDelegate = self;
    [JYTools shareInstance].discoverDelegate = self;
    [[JYTools shareInstance] scanDevice];

    [self.udpTimer invalidate];
    self.udpTimer = [NSTimer timerWithTimeInterval:1.0
                                            target:self
                                          selector:@selector(udpBroadcast)
                                          userInfo:nil
                                           repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.udpTimer forMode:NSDefaultRunLoopMode];

    [self.timeoutTimer invalidate];
    self.timeoutTimer = [NSTimer timerWithTimeInterval:timeoutSeconds
                                                target:self
                                              selector:@selector(linkTimeout)
                                              userInfo:nil
                                               repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:self.timeoutTimer forMode:NSDefaultRunLoopMode];

    result(nil);
}

- (void)ensureManagers {
    if (!self.centralManager) {
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
}

- (BOOL)bluetoothEnabled {
    return self.centralManager.state == CBManagerStatePoweredOn;
}

- (NSString *)currentSSID {
    NSArray *interfaces = CFBridgingRelease(CNCopySupportedInterfaces());
    for (NSString *interfaceName in interfaces) {
        NSDictionary *info =
            CFBridgingRelease(CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName));
        NSString *ssid = info[(__bridge NSString *)kCNNetworkInfoKeySSID];
        if ([ssid isKindOfClass:[NSString class]] && ssid.length > 0) {
            return ssid;
        }
    }
    return nil;
}

- (void)udpBroadcast {
    [[UDPManage shareUDPManage] broadcast];
}

- (void)linkTimeout {
    if (self.finished) {
        return;
    }
    self.finished = YES;
    [self stopEverything];
    [self emit:@{@"event": @"timeout"}];
    [self emit:@{@"event": @"finished"}];
}

- (void)stopEverything {
    [self.udpTimer invalidate];
    self.udpTimer = nil;
    [self.timeoutTimer invalidate];
    self.timeoutTimer = nil;
    [[JYTools shareInstance] stopScan];
    [[JYTools shareInstance] unConnectDevice];
}

- (void)emit:(NSDictionary *)event {
    if (self.eventSink) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.eventSink(event);
        });
    }
}

- (void)emitLinkedWithIp:(NSString *)ip mac:(NSString *)mac {
    if (self.finished) {
        return;
    }
    self.finished = YES;
    [self stopEverything];

    NSString *moduleId = mac ?: @"";
    if (mac.length > 0) {
        NSArray *parts = [mac componentsSeparatedByString:@"##"];
        if (parts.count > 0) {
            mac = parts[0];
        }
        if (parts.count > 1) {
            moduleId = parts[1];
        }
    }

    [self emit:@{@"event": @"linked", @"ip": ip ?: @"", @"mac": mac ?: @"",
                 @"id": moduleId}];
    [self emit:@{@"event": @"finished"}];
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    BOOL enabled = (central.state == CBManagerStatePoweredOn);
    [self emit:@{@"event": @"bluetooth",
                 @"enabled": @(enabled)}];
}

#pragma mark - BleDelegate

- (void)BLEDidDiscoverDeviceWithMAC:(CBPeripheral *)peripheral {
    [[JYTools shareInstance] stopScan];
    [[JYTools shareInstance] connectDevice:peripheral];
}

- (void)BLEDidGetDeviceMac:(NSString *)mac {
    [[JYTools shareInstance] setUserDataAndContinue:self.userData ?: @""];
}

- (void)BLEIsSuccesee:(NSString *)str {
    [self emit:@{@"event": @"message", @"text": str ?: @""}];
}

- (void)BLEDidFinishedWithResult:(BOOL)result andPara:(NSMutableArray *)para {
    if (result) {
        [self emitLinkedWithIp:(para.count > 0 ? [NSString stringWithFormat:@"%@", para[0]] : @"")
                           mac:(para.count > 1 ? [NSString stringWithFormat:@"%@", para[1]] : @"")];
    } else {
        if (self.finished) {
            return;
        }
        self.finished = YES;
        [self stopEverything];
        [self emit:@{@"event": @"error", @"code": @"CONFIG_BLE_FAILED",
                     @"message": (para.count > 0
                         ? [NSString stringWithFormat:@"%@", para[0]] : @"")}];
        [self emit:@{@"event": @"finished"}];
    }
}

#pragma mark - udpDelegate

- (void)isUDPSuccess:(NSMutableArray *)arr {
    [self emitLinkedWithIp:(arr.count > 0 ? [NSString stringWithFormat:@"%@", arr[0]] : @"")
                       mac:(arr.count > 1 ? [NSString stringWithFormat:@"%@", arr[1]] : @"")];
}

- (void)dataIsSuccess:(NSString *)str {
}

#pragma mark - FlutterStreamHandler

- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events {
    self.eventSink = events;
    if (self.centralManager) {
        [self emit:@{@"event": @"bluetooth", @"enabled": @([self bluetoothEnabled])}];
    }
    return nil;
}

- (void)onCancelWithArguments:(id)arguments {
    self.eventSink = nil;
}

@end
