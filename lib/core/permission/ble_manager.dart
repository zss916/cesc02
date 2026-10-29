import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:cesc01/core/log/log_util.dart';
import 'package:cesc01/feature/provision/dialog/ios_location_service_dialog.dart';
import 'package:cesc01/feature/provision/dialog/ios_system_ble_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class BLEManager {
  static final BLEManager _instance = BLEManager._internal();
  static BLEManager get instance => BLEManager();
  factory BLEManager() => _instance;
  BLEManager._internal();

  Duration timeoutDuration = Duration(seconds: 30);

  ///关键字
  String keyword = "";

  ///设备是否支持蓝牙
  Future<bool> isSupportedBLE() => FlutterBluePlus.isSupported;

  ///手机系统蓝牙
  Future<bool> getSystemBLEState() async {
    if (Platform.isIOS) {
      BluetoothAdapterState adapterState =
          await FlutterBluePlus.adapterState.first;
      debugPrint("checkSystemBluetooth : ${adapterState.toString()}");
      return (adapterState == BluetoothAdapterState.on ||
          adapterState == BluetoothAdapterState.unknown);
    } else {
      ///android
      BluetoothAdapterState adapterState =
          await FlutterBluePlus.adapterState.first;
      return (adapterState == BluetoothAdapterState.on);
    }
  }

  StreamSubscription<BluetoothAdapterState>? subscription;

  ///监听手机系统蓝牙
  Future onSystemBLEStateStream({required Function(bool) onState}) async {
    subscription = FlutterBluePlus.adapterState.listen((
      BluetoothAdapterState state,
    ) {
      switch (state) {
        case BluetoothAdapterState.on:
          debugPrint("onBLEState => Bluetooth is on");
          onState.call(true);
          break;
        case BluetoothAdapterState.off:
          debugPrint("onBLEState => Bluetooth is off");
          onState.call(false);
          break;
        case BluetoothAdapterState.unknown:
          debugPrint("onBLEState => State could not be determined");
          onState.call(false);
          break;
        case BluetoothAdapterState.unavailable:
          debugPrint("onBLEState => Bluetooth unavailable");
          break;
        case BluetoothAdapterState.unauthorized:
          debugPrint("onBLEState => Bluetooth unauthorized");
          break;
        case BluetoothAdapterState.turningOn:
          debugPrint("onBLEState => Bluetooth turningOn");
          break;
        case BluetoothAdapterState.turningOff:
          debugPrint("onBLEState => Bluetooth turningOff");
          break;
      }
    });
  }

  ///取消监听
  Future<void> cancelSystemBLEStateStream() async {
    await subscription?.cancel();
  }

  ///启用蓝牙
  Future<void> enableBLE() async {
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    } else {
      ///IOS,不支持直接跳到系统蓝牙设置页面
      showBluetoothOffDialog();
    }
  }

  ///App设置页面
  void toOpenAppSetting() {
    try {
      ///解决ios 端，开关APP蓝牙权限的crash
      openAppSettings();
    } catch (e) {
      debugPrint("openAppSetting:$e");
    }
  }

  ///打开系统定位设置页面(需要引导弹窗)
  void openLocationSettings() {
    if (Platform.isAndroid) {
      ///only android
      AppSettings.openAppSettings(type: AppSettingsType.location);

      /// AppSettings.openAppSettingsPanel( AppSettingsPanelType.internetConnectivity);
    } else {
      showLocationServiceDialog();
    }
  }

  ///*****************************************************************************

  late StreamSubscription<void> scanStateSubscription;

  ///监听扫描状态
  void onScanStateListen({required Function onStopScan}) {
    LogUtil.print("FBP", "onScanStateListen");
    scanStateSubscription = FlutterBluePlus.isScanning.listen((isScanning) {
      if (!isScanning) {
        debugPrint('蓝牙扫描已结束（可能是超时或主动停止）');
        onStopScan.call();
      }
    });
  }

  ///取消扫描状态监听
  Future<void> cancelScanStateListen() async {
    if (FlutterBluePlus.isScanningNow) {
      await FlutterBluePlus.stopScan();
    }
    scanStateSubscription.cancel();
    LogUtil.print("FBP", "cancelScanState");
  }

  ///*********************************************************************************

  ///扫描
  Future<void> toScan() async {
    discoveredDevices.clear();
    if (FlutterBluePlus.isScanningNow) {
      await FlutterBluePlus.stopScan();
      await FlutterBluePlus.startScan(timeout: timeoutDuration);
      LogUtil.print("FBP", "stopAndToScan:$keyword");
    } else {
      await FlutterBluePlus.startScan(timeout: timeoutDuration);
      LogUtil.print("FBP", "toScan:$keyword");
    }
  }

  ///结束扫描
  Future<void> stopScan() async {
    LogUtil.print("FBP", "stopScan");
    //discoveredDevices.clear();
    await FlutterBluePlus.stopScan();
  }

  late StreamSubscription<List<ScanResult>> scanResultsSubscription;
  final Set<String> discoveredDevices = {};

  ///监听扫描结果
  void onScanResults({required Function(Map<String, dynamic>) onDeviceFound}) {
    discoveredDevices.clear();
    LogUtil.print("FBP", "onScanResults");
    scanResultsSubscription = FlutterBluePlus.scanResults.listen((
      List<ScanResult> results,
    ) {
      for (ScanResult result in results) {
        final snName = result.device.platformName;
        //result.device.readRssi();
        if ((snName.toLowerCase()).contains(keyword.toLowerCase()) &&
            snName.isNotEmpty) {
          final deviceId = result.device.remoteId.str;

          /// 已发现过，跳过
          if (!discoveredDevices.add(deviceId)) {
            continue;
          } else {
            Map<String, dynamic> map = {snName: result.device.isConnected};
            LogUtil.print(
              "FBP",
              "result===>> $snName，${result.device.isConnected}",
            );
            onDeviceFound.call(map);
          }
        }
      }
    }, onError: (e) => {LogUtil.print("FBP", "onError:$e")});
  }

  ///取消扫描结果
  Future<void> cancelScanResults() async {
    discoveredDevices.clear();
    if (FlutterBluePlus.isScanningNow) {
      await FlutterBluePlus.stopScan();
    }
    scanResultsSubscription.cancel();
    LogUtil.print("FBP", "cancelScanResults");
  }
}
