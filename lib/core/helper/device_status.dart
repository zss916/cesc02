import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

///运行状态（充电，放电，待机）
enum DeviceRunStatus { online, standby, offline, alarm, delayed }

///通行状态（在线,离线，延迟，告警）
enum DeviceTrafficStatus { online, standby, offline, alarm, delayed }

extension DeviceExtension on DeviceRunStatus {
  String get value {
    switch (this) {
      ///正常在线
      case DeviceRunStatus.online:
        return "ONLINE";

      ///待机
      case DeviceRunStatus.standby:
        return "STANDBY";

      ///设备离线。
      case DeviceRunStatus.offline:
        return "OFFLINE";

      ///设备处于严重告警状态
      case DeviceRunStatus.alarm:
        return "ALARM";

      ///数据上报延迟
      case DeviceRunStatus.delayed:
        return "DELAYED";
    }
  }
}

/// online 包含（充电，放电，待机）
extension DeviceSattusExtension on String {
  Color get colorValue {
    switch (this) {
      case "ONLINE":
        return Color(0xFF22C55E);
      case "OFFLINE":
        return Color(0xFFEF4444);
      //return Color(0xFF6B7280);
      case "WARNING":
      case "ALARM":
      case "DELAYED":
        return Color(0xFFEF8F32);
      default:
        return Colors.transparent;
    }
  }

  ///通信
  String get title {
    switch (this) {
      case "ONLINE":
        return LKey.online.tr;
      case "OFFLINE":
        return LKey.offline.tr;
      case "ALARM":
        return LKey.alarm.tr;
      case "DELAYED":
        return LKey.delayed.tr;
      default:
        return "-";
    }
  }

  String get levelTitle {
    switch (this) {
      case "CLUSTER":
        return "簇级";
      case "STACK":
        return "堆级";
      default:
        return '';
    }
  }

  String get permissionTitle {
    switch (this) {
      case "ALLOW_ALL":
        return "可充 / 可放";
      case "FORBID_CHARGE":
        return "禁充";
      case "FORBID_DISCHARGE":
        return "禁放";
      case "FORBID_ALL":
        return "禁充 / 禁放";
      default:
        return '';
    }
  }

  ///运行
  String get runningTitle {
    switch (this) {
      case "FAULT_PROTECTION":
        return "故障保护";
      case "CHARGING":
        return LKey.charge.tr;
      case "DISCHARGING":
        return LKey.discharge.tr;
      case "STANDBY":
        return LKey.standby.tr;
      case "SLEEP":
        return LKey.sleep.tr;
      case "WAITING_FOR_ADDRESS":
        return LKey.waitingAddress.tr;
      case "SELF_CHECK":
        return LKey.selfCheck.tr;
      default:
        return "--";
    }
  }

  String get statusTitle {
    switch (this) {
      case "ACTIVE":
        return LKey.ongoing.tr;
      case "RECOVERED":
        return LKey.restored.tr;
      case "NONE":
        return "无";
      default:
        return '';
    }
  }

  Color get statusColor {
    switch (this) {
      case "ACTIVE":
        return Color(0xFFE02020);
      case "RECOVERED":
        return Color(0xFF22C55E);
      default:
        return Colors.transparent;
    }
  }
}

///告警状态
enum AlarmStatus { active, recovered }

extension AlarmExtension on AlarmStatus {
  String get value {
    switch (this) {
      case AlarmStatus.active:
        return "ACTIVE";
      case AlarmStatus.recovered:
        return "RECOVERED";
    }
  }
}

///告警等级
enum AlarmLevel { serious, important, general }

extension AlarmLevelExtension on AlarmLevel {
  int get value {
    switch (this) {
      case AlarmLevel.serious:
        return 1;
      case AlarmLevel.important:
        return 2;
      case AlarmLevel.general:
        return 3;
    }
  }
}

extension AlarmLevelUIExtension on int {
  Color get colorValue {
    switch (this) {
      case 1:
        return Color(0xFFE75252);
      case 2:
        return Color(0xFFEF8F32);
      case 3:
        return Color(0xFF5B6B85);
      default:
        return Colors.transparent;
    }
  }

  String get title {
    switch (this) {
      case 1:
        return LKey.serious.tr;
      case 2:
        return LKey.important.tr;
      case 3:
        return LKey.general.tr;
      case -2:
        return "无";
      default:
        return "--";
    }
  }

  String get heaterTitle {
    switch (this) {
      case 0:
        return '关闭';
      case 1:
        return '加热中';
      default:
        return "--";
    }
  }
}

///人员类型编码：INTERNAL_OPS 内部运维、INSTALLER 安装工程师
extension PersonnelTypeExtension on String? {
  String get type {
    switch (this) {
      case "INTERNAL_OPS":
        return LKey.internalOperation.tr;
      case "INSTALLER":
        return LKey.installationEngineer.tr;
      default:
        return "--";
    }
  }
}

///1 低压，2 高压
extension ModeExtension on int {
  String get modeTitle {
    switch (this) {
      case 1:
        return LKey.lowVoltage.tr;
      case 2:
        return LKey.highVoltage.tr;
      default:
        return "--";
    }
  }
}

///站点运行状态
extension RealTimeStatusExtension on int {
  String? get filterStatus {
    switch (this) {
      case 1:
        return "ONLINE";
      case 2:
        return "ALARM";
      case 3:
        return "DELAYED";
      case 4:
        return "OFFLINE";
      default:
        return null;
    }
  }
}

///消息等级
enum MessageLevel { severe, important, upgrade }

extension MessageLevelExtension on MessageLevel {
  String get value {
    switch (this) {
      case MessageLevel.severe:
        return "SEVERE";

      case MessageLevel.important:
        return "IMPORTANT";

      case MessageLevel.upgrade:
        return "UPGRADE";
    }
  }
}
