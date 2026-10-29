import 'dart:async';

import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:smart_ble_link/smart_ble_link.dart';

class SmartBleLinkTools {
  static final SmartBleLinkTools _instance = SmartBleLinkTools._internal();
  static SmartBleLinkTools get instance => SmartBleLinkTools();
  factory SmartBleLinkTools() => _instance;
  SmartBleLinkTools._internal();

  final List<String> _logs = <String>[];
  StreamSubscription<SmartLinkEvent>? _subscription;

  ///超时
  int timeoutDuration = 50;

  ///连接配网
  Future<void> startLinking({
    required String ssid,
    required String password,
    required String bleName,
    Function? onError,
  }) async {
    _appendLog('开始配网 ssid=$ssid bleName=$bleName');
    try {
      await SmartBleLink.startLinking(
        ssid: ssid,
        password: password,
        bleName: bleName,
        timeoutSeconds: timeoutDuration,
      );
    } on PlatformException catch (e) {
      _appendLog('启动失败: ${e.code} ${e.message ?? ''}');
      onError?.call();
    }
  }

  ///获取ssid ()
  Future<String?> getSsid() => SmartBleLink.getConnectedSsid();

  ///开启ble
  Future<bool> isBleEnabled() => SmartBleLink.isBluetoothEnabled();

  ///事件监听
  void onEventListen({
    Function(String?)? onSSIDEvent,
    Function()? onLinkedEvent,
    Function()? onTimeOutEvent,
    Function(String)? onErrorEvent,
    Function()? onFinishEvent,
    Function(String)? onMessageEvent,
  }) {
    _subscription = SmartBleLink.events.listen(
      (e) {
        _onEvent(
          e,
          onErrorEvent: onErrorEvent,
          onLinkedEvent: onLinkedEvent,
          onFinishEvent: onFinishEvent,
          onSSIDEvent: onSSIDEvent,
          onMessageEvent: onMessageEvent,
          onTimeOutEvent: onTimeOutEvent,
        );
      },
      onError: (Object e) {
        _appendLog('stream error: $e');
      },
    );
  }

  void _onEvent(
    SmartLinkEvent event, {
    Function(String?)? onSSIDEvent,
    Function()? onLinkedEvent,
    Function()? onTimeOutEvent,
    Function(String)? onErrorEvent,
    Function()? onFinishEvent,
    Function(String)? onMessageEvent,
  }) {
    if (event.isBluetooth) {
      bool btEnabled = event.enabled ?? false;
      debugPrint('_btEnabled =>$btEnabled');
    }
    if (event.isWifi &&
        (event.connected ?? false) &&
        (event.ssid?.isNotEmpty ?? false)) {
      onSSIDEvent?.call(event.ssid);
    }
    // _appendLog("event:${event.toString()}");
    if (event.isProgress) {
      _appendLog('进度: ${event.progress}');
    } else if (event.isMessage) {
      onMessageEvent?.call("${event.text}");
      _appendLog('消息: ${event.text}');
    } else if (event.isLinked) {
      onLinkedEvent?.call();
      _appendLog('配网成功! mac=${event.mac} ip=${event.ip} id=${event.id}');
    } else if (event.isTimeout) {
      onTimeOutEvent?.call();
      _appendLog('配网超时');
    } else if (event.isError) {
      onErrorEvent?.call(event.errorCode.message);
      //onErrorEvent?.call('${event.errorCode} ${event.errorMessage ?? ''}');
      _appendLog(
        '错误: errorCode:${event.errorCode},errorMessage:${event.errorMessage ?? ''}',
      );
    } else if (event.isFinished) {
      onFinishEvent?.call();
      _appendLog('流程结束');
    }
  }

  ///取消事件
  void cancelEvent() {
    _logs.clear();
    if (_subscription != null) {
      _subscription?.cancel();
    }
  }

  Future<void> stopLinking() async {
    await SmartBleLink.stopLinking();
    _appendLog('已手动停止');
  }

  void _appendLog(String text) {
    _logs.insert(
      0,
      '${DateTime.now().toIso8601String().substring(11, 19)} $text',
    );
    /*if (_logs.length > 100) {
      _logs.removeLast();
    }*/

    debugPrint(
      "_appendLog => ${DateTime.now().toIso8601String().substring(11, 19)} $text",
    );
  }

  ///获取权限
  Future<bool> requestPermissions() async {
    final bool granted = await SmartBleLink.requestPermissions();
    _appendLog(granted ? '权限已授予' : '权限被拒绝');
    return Future.value(granted);
  }
}

/// error
extension LinkingErrorExtension on String? {
  String get message {
    switch (this) {
      case 'ERROR':
        return LKey.internalError.tr;

      case 'CANCEL':
        return LKey.bleCancel.tr;

      case 'BLUETOOTH_DISABLED':
        return LKey.bleDisabled.tr;

      case 'NO_VALID_WIFI_CONNECTION':
        return LKey.noValidWifiConnect.tr;

      case 'BLE_NOT_FOUND':
        return LKey.bleDeviceNotFound.tr;

      case 'CONNECT_BLE_FAILED':
        return LKey.failedToConnectBle.tr;

      case 'CONFIG_BLE_FAILED':
        return LKey.failedToConfigureBle.tr;

      case 'FIND_DEVICE_FAILED':
        return LKey.notLinkedDeviceFound.tr;

      case 'FIND_DEVICE_FAILED_AP_PASSWORD_ERROR':
        return LKey.incorrectWifiPassword.tr;

      case 'FIND_DEVICE_FAILED_AP_NOT_EXIST':
        return LKey.wifiNotExist.tr;

      default:
        return LKey.unknow.tr;
    }
  }
}
