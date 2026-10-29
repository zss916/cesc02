import 'dart:async';

import 'package:flutter/services.dart';

import 'smart_ble_link_models.dart';

export 'smart_ble_link_models.dart';

class SmartBleLink {
  SmartBleLink._();

  static const MethodChannel _method = MethodChannel('smart_ble_link/method');
  static const EventChannel _events = EventChannel('smart_ble_link/events');

  static Stream<SmartLinkEvent>? _eventStream;

  static Stream<SmartLinkEvent> get events {
    return _eventStream ??= _events.receiveBroadcastStream().map(
      (dynamic data) =>
          SmartLinkEvent.fromMap(Map<String, dynamic>.from(data as Map)),
    );
  }

  static Future<bool> isBluetoothEnabled() async {
    return await _method.invokeMethod<bool>('isBluetoothEnabled') ?? false;
  }

  static Future<bool> isBleSupported() async {
    return await _method.invokeMethod<bool>('isBleSupported') ?? false;
  }

  static Future<void> requestEnableBluetooth() async {
    await _method.invokeMethod<void>('requestEnableBluetooth');
  }

  static Future<bool> requestPermissions() async {
    return await _method.invokeMethod<bool>('requestPermissions') ?? false;
  }

  static Future<String?> getConnectedSsid() async {
    return await _method.invokeMethod<String>('getConnectedSsid');
  }

  static Future<void> startLinking({
    required String ssid,
    required String password,
    String bleName = 'AZ',
    String? userData,
    bool dynamicPassword = false,
    int timeoutSeconds = 60,
    bool bleNameStrictMatching = true,
  }) async {
    await _method.invokeMethod<void>('startLinking', <String, dynamic>{
      'ssid': ssid,
      'password': password,
      'bleName': bleName,
      'userData': userData ?? '',
      'dynamicPassword': dynamicPassword,
      'timeoutSeconds': timeoutSeconds,
      'bleNameStrictMatching': bleNameStrictMatching,
    });
  }

  static Future<void> stopLinking() async {
    await _method.invokeMethod<void>('stopLinking');
  }
}
