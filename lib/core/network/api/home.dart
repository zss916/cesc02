import 'package:cesc01/core/helper/app_loading.dart';
import 'package:cesc01/core/helper/device_status.dart';
import 'package:cesc01/core/network/base/interceptor/net_status.dart';
import 'package:cesc01/core/network/bean/alarm_detail_entity.dart';
import 'package:cesc01/core/network/bean/dashboard_entity.dart';
import 'package:cesc01/core/network/http.dart';
import 'package:cesc01/core/network/path.dart';
import 'package:flutter/foundation.dart';

///Home
abstract class HomeAPI {
  ///获取首页信息
  static Future<(bool, DashboardEntity)> getDashboard() async {
    try {
      var result = await Http.instance.get(ApiPath.getDashboard);
      if (result["code"] == NetStatus.ok) {
        DashboardEntity value = DashboardEntity.fromJson(result["data"]);
        return (true, value);
      } else {
        AppLoading.toast(result["message"]);
        return (false, DashboardEntity());
      }
    } catch (e) {
      return (false, DashboardEntity());
    }
  }

  ///告警列表
  static Future<List<AlarmDetailEntity>> postAlarmList() async {
    try {
      Map<String, dynamic> map = {};
      map['pageNum'] = 1;
      map['pageSize'] = 30;
      map['status'] = AlarmStatus.active.value;
      map['alarmLevel'] = AlarmLevel.serious.value;
      var result = await Http.instance.post(ApiPath.postAlarmList, data: map);
      if (result["code"] == NetStatus.ok) {
        List<AlarmDetailEntity> value = await compute(
          (List<dynamic> jsonList) =>
              jsonList.map((e) => AlarmDetailEntity.fromJson(e)).toList(),
          (result['data']['list'] as List),
        );
        return value;
      } else {
        // AppLoading.toast(result["message"]);
        return [];
      }
    } catch (error) {
      return [];
    }
  }
}
