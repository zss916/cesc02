import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

///only Android
class WifiService {
  /// 请求位置权限以访问 Wi-Fi 信息
  static Future<bool> requestWiFiPermission() async {
    var status = await Permission.locationWhenInUse.request();
    debugPrint('Permission status: $status');
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  /// 获取当前连接的 Wi-Fi SSID
  static Future<String?> getWifiSSID() async {
    var permissionGranted = await requestWiFiPermission();
    debugPrint('Permission granted: $permissionGranted');
    if (permissionGranted) {
      final NetworkInfo info = NetworkInfo();
      String? ssid;
      try {
        ssid = await info.getWifiName(); // Attempt to get Wi-Fi SSID
      } catch (e) {
        debugPrint('Failed to get Wi-Fi SSID: $e');
      }
      // 去除首尾空格
      if (ssid != null) {
        String trimmed = ssid.trim();
        // 去除首尾双引号
        if (trimmed.startsWith('"') && trimmed.endsWith('"')) {
          ssid = trimmed.substring(1, trimmed.length - 1);
        }
      }

      return ssid;
    } else {
      return null;
    }
  }
}
