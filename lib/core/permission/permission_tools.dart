import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionTools {
  ///判断是否开启定位服务(Android only)
  static Future<bool> checkLocationService() async {
    return await Permission.locationWhenInUse.serviceStatus.isEnabled;
  }

  ///是否获取定位
  static Future<bool> isGrantedLocation() async {
    return await Permission.location.status.isGranted;
  }

  ///判断是否开启蓝牙开关
  static Future<bool> checkSystemBluetooth() async {
    if (Platform.isIOS) {
      BluetoothAdapterState adapterState =
          await FlutterBluePlus.adapterState.first;
      //debugPrint("checkSystemBluetooth : ${adapterState.toString()}");
      return (adapterState == BluetoothAdapterState.on ||
          adapterState == BluetoothAdapterState.unknown);
    } else {
      ///android
      BluetoothAdapterState adapterState =
          await FlutterBluePlus.adapterState.first;
      return (adapterState == BluetoothAdapterState.on);
    }
  }

  static Future<bool> isGrantedBluetoothScan() async {
    if (Platform.isIOS) {
      return requestBluePermission();
    } else {
      ///android 11.0.0以上需要获取BluetoothScan权限
      return await Permission.bluetoothScan.status.isGranted;
    }
  }

  ///获取APP蓝牙权限
  static Future<bool> requestBluePermission() async {
    //获取当前的权限
    var status = await Permission.bluetooth.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.bluetooth.request();
      debugPrint("status: $status");
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  ///开启蓝牙所有需要权限
  static Future<bool> openBlueAllPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.bluetoothScan,
      Permission.location,
    ].request();

    bool isAllGranted = statuses.values.where((e) => !e.isGranted).isEmpty;
    return isAllGranted;
  }

  ///确认所有权限
  static Future<bool> checkBLEAllPermission() async {
    bool isCheckLocationService = await PermissionTools.checkLocationService();
    bool isCheckSystemBluetooth = await PermissionTools.isGrantedLocation();
    bool isLocationGranted = await PermissionTools.checkSystemBluetooth();
    bool isBluetoothScan = await PermissionTools.isGrantedBluetoothScan();
    debugPrint("权限全部获取");
    return isCheckLocationService &&
        isCheckSystemBluetooth &&
        isLocationGranted &&
        isBluetoothScan;
  }
}
