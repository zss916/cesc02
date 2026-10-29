import 'package:cesc01/core/network/base/interceptor/net_status.dart';
import 'package:cesc01/core/network/bean/alarm_detail_entity.dart';
import 'package:cesc01/core/network/bean/alarm_summary_entity.dart';
import 'package:cesc01/core/network/bean/stack_alarm_detail_entity.dart';
import 'package:cesc01/core/network/bean/stack_item_entity.dart';
import 'package:cesc01/core/network/http.dart';
import 'package:cesc01/core/network/path.dart';
import 'package:cesc01/core/network/result/result.dart';
import 'package:flutter/foundation.dart';

///Alarm
abstract class AlarmAPI {
  ///告警列表
  static Future<ApiResult<List<AlarmDetailEntity>>> postList({
    required int pageNum,
    required String? siteId,
    required int? alarmLevel,
    required String? status,
    required String? stackSn,
  }) async {
    try {
      Map<String, dynamic> map = {};
      map['pageNum'] = pageNum;
      map['pageSize'] = 10;
      if (siteId != null) {
        map['siteId'] = siteId;
      }
      if (stackSn != null) {
        map['stackSn'] = stackSn;
      }
      if (alarmLevel != null) {
        map['alarmLevel'] = alarmLevel;
      }
      if (status != null) {
        map['status'] = status;
      }
      var result = await Http.instance.post(ApiPath.postAlarmList, data: map);
      if (result["code"] == NetStatus.ok) {
        List<AlarmDetailEntity> value = await compute(
          (List<dynamic> jsonList) =>
              jsonList.map((e) => AlarmDetailEntity.fromJson(e)).toList(),
          (result["data"]['list'] as List),
        );
        return ApiSuccess(value);
      } else {
        return ApiError(errorState: ErrorState.error, msg: result["message"]);
      }
    } catch (error) {
      return ApiError(errorState: ErrorState.exception, msg: error.toString());
    }
  }

  ///获取告警数据
  static Future<AlarmSummaryEntity?> getAlarmsSummary({
    required String? siteId,
    required String? stackSn,
    required int? alarmLevel,
    required String? status,
  }) async {
    try {
      Map<String, dynamic> map = {};
      if (siteId != null) {
        map['siteId'] = siteId;
      }
      if (stackSn != null) {
        map['stackSn'] = stackSn;
      }
      if (alarmLevel != null) {
        map['alarmLevel'] = alarmLevel;
      }
      if (status != null) {
        map['status'] = status;
      }
      var result = await Http.instance.get(
        ApiPath.getAlarmsSummary,
        query: map,
      );
      if (result["code"] == NetStatus.ok) {
        AlarmSummaryEntity value = AlarmSummaryEntity.fromJson(result["data"]);
        return value;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  ///获取告警详情
  static Future<ApiResult<AlarmDetailEntity>> getAlarmDetail({
    required String alarmId,
  }) async {
    try {
      var result = await Http.instance.get(
        ApiPath.getAlarmDetail(alarmId: alarmId),
      );
      if (result["code"] == NetStatus.ok) {
        AlarmDetailEntity value = AlarmDetailEntity.fromJson(result["data"]);
        return ApiSuccess(value);
      } else {
        return ApiError(errorState: ErrorState.error, msg: result["message"]);
      }
    } catch (error) {
      return ApiError(errorState: ErrorState.exception, msg: error.toString());
    }
  }

  ///获取Stack告警详情
  static Future<ApiResult<StackAlarmDetailEntity>> getStackAlarmDetail({
    required String? siteId,
    required String? stackSn,
    required String? status,
  }) async {
    try {
      Map<String, dynamic> map = {};
      if (siteId != null) {
        map['siteId'] = siteId;
      }

      map['stackSn'] = stackSn;

      if (status != null) {
        map['status'] = status;
      }
      var result = await Http.instance.get(
        ApiPath.getStackAlarmDetail,
        query: map,
      );
      if (result["code"] == NetStatus.ok) {
        StackAlarmDetailEntity value = StackAlarmDetailEntity.fromJson(
          result["data"],
        );
        return ApiSuccess(value);
      } else {
        return ApiError(errorState: ErrorState.error, msg: result["message"]);
      }
    } catch (error) {
      return ApiError(errorState: ErrorState.exception, msg: error.toString());
    }
  }

  ///获取电池堆
  static Future<(bool, List<StackItemEntity>)> getBatteryStack({
    required String siteId,
  }) async {
    try {
      var result = await Http.instance.get(
        ApiPath.getBatteryStack(siteId: siteId),
      );
      if (result["code"] == NetStatus.ok) {
        List<StackItemEntity> value = await compute(
          (List<dynamic> jsonList) =>
              jsonList.map((e) => StackItemEntity.fromJson(e)).toList(),
          (result["data"] as List),
        );
        return (true, value);
      } else {
        return (false, <StackItemEntity>[]);
      }
    } catch (error) {
      return (false, <StackItemEntity>[]);
    }
  }
}
