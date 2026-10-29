import 'dart:io';

import 'package:cesc01/core/helper/app_loading.dart';
import 'package:cesc01/core/network/base/interceptor/net_status.dart';
import 'package:cesc01/core/network/bean/battery_data_entity.dart';
import 'package:cesc01/core/network/bean/battery_detail_entity.dart';
import 'package:cesc01/core/network/bean/battery_list_entity.dart';
import 'package:cesc01/core/network/bean/options_entity.dart';
import 'package:cesc01/core/network/bean/site_item_entity.dart';
import 'package:cesc01/core/network/bean/site_over_view_data_entity.dart';
import 'package:cesc01/core/network/bean/stack_and_cluster_entity.dart';
import 'package:cesc01/core/network/bean/version_data_entity.dart';
import 'package:cesc01/core/network/http.dart';
import 'package:cesc01/core/network/path.dart';
import 'package:cesc01/core/network/result/result.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

///Site
abstract class SiteAPI {
  ///单站概览
  static Future<ApiResult<SiteOverViewDataEntity>> getOverView({
    required String? siteId,
  }) async {
    try {
      if (siteId != null) {
        var result = await Http.instance.get(
          ApiPath.getSiteOverview(siteId: siteId ?? ""),
        );
        if (result["code"] == HttpStatus.ok) {
          SiteOverViewDataEntity value = SiteOverViewDataEntity.fromJson(
            result["data"],
          );
          return ApiSuccess(value);
        } else {
          return ApiError(errorState: ErrorState.error, msg: result["message"]);
        }
      } else {
        return ApiError(
          errorState: ErrorState.paramError,
          msg: "Parameter Error",
        );
      }
    } catch (error) {
      return ApiError(errorState: ErrorState.exception, msg: error.toString());
    }
  }

  ///电池包列表
  static Future<(bool, List<BatteryListList>)> postBatteryList({
    required int pageNum,
    String? siteId,
    String? keyword,
    String? runtimeStatus,
  }) async {
    try {
      Map<String, dynamic> map = {};
      map['pageNum'] = pageNum;
      map['pageSize'] = 10;
      if (siteId != null) {
        map['siteId'] = siteId;
      }
      if (keyword != null) {
        map['keyword'] = keyword;
      }
      if (runtimeStatus != null) {
        map['runtimeStatus'] = runtimeStatus;
      }
      var result = await Http.instance.post(ApiPath.postBatteryList, data: map);
      if (result["code"] == HttpStatus.ok) {
        List<BatteryListList> value = await compute(
          (List<dynamic> jsonList) =>
              jsonList.map((e) => BatteryListList.fromJson(e)).toList(),
          (result["data"]['list'] as List),
        );
        return (true, value);
      } else {
        //AppLoading.toast(result["message"]);
        return (false, <BatteryListList>[]);
      }
    } catch (error) {
      //AppLoading.toast(error.toString());
      return (false, <BatteryListList>[]);
    }
  }

  ///电池包详情
  static Future<ApiResult<BatteryDetailEntity>> getBatteryDetail({
    required String clusterId,
  }) async {
    try {
      var result = await Http.instance.get(
        ApiPath.getBatteryDetail(clusterId: clusterId),
      );
      if (result["code"] == NetStatus.ok) {
        BatteryDetailEntity value = BatteryDetailEntity.fromJson(
          result["data"],
        );
        return ApiSuccess(value);
      } else {
        //AppLoading.toast(result["message"]);
        return ApiError(errorState: ErrorState.error, msg: result["message"]);
      }
    } catch (error) {
      return ApiError(errorState: ErrorState.exception, msg: error.toString());
    }
  }

  ///查询站点下拉选项
  static Future<(bool, List<SiteItemEntity>)> getSiteList() async {
    try {
      var result = await Http.instance.get(ApiPath.getSites);
      if (result["code"] == NetStatus.ok) {
        List<SiteItemEntity> value = await compute(
          (List<dynamic> jsonList) =>
              jsonList.map((e) => SiteItemEntity.fromJson(e)).toList(),
          (result["data"] as List),
        );
        return (true, value);
      } else {
        AppLoading.toast(result["message"]);
        return (false, <SiteItemEntity>[]);
      }
    } catch (error) {
      debugPrint("===>>> ${error}");
      AppLoading.toast(LKey.loadFailedText.tr);
      return (false, <SiteItemEntity>[]);
    }
  }

  ///获取指定固件版本详情
  static Future<ApiResult<VersionDataEntity>> getVersionInfo({
    required String stackId,
  }) async {
    try {
      var result = await Http.instance.get(
        ApiPath.getVersionInfo(stackId: stackId),
      );
      if (result["code"] == NetStatus.ok) {
        VersionDataEntity value = VersionDataEntity.fromJson(result["data"]);
        return ApiSuccess(value);
      } else {
        return ApiError(errorState: ErrorState.error, msg: result["message"]);
      }
    } catch (error) {
      return ApiError(errorState: ErrorState.exception, msg: error.toString());
    }
  }

  ///电池数据页
  static Future<(bool, BatteryDataEntity?)> getBatteryData({
    required String stackId,
    String? clusterId,
  }) async {
    try {
      Map<String, dynamic> map = {};
      if (clusterId != null) {
        map['clusterId'] = clusterId;
      }
      var result = await Http.instance.get(
        ApiPath.getBatteryData(stackId: stackId),
        query: map,
      );
      if (result["code"] == HttpStatus.ok) {
        BatteryDataEntity value = BatteryDataEntity.fromJson(result["data"]);
        return (true, value);
      } else {
        return (false, null);
      }
    } catch (error) {
      return (false, null);
    }
  }

  ///获取堆和簇数据
  static Future<StackAndClusterEntity?> getStackAndCluster({
    required String stackId,
    String? clusterId,
  }) async {
    try {
      Map<String, dynamic> map = {};
      if (clusterId != null) {
        map['clusterId'] = clusterId;
      }
      var result = await Http.instance.get(
        ApiPath.getStackAndCluster(stackId: stackId),
        query: map,
      );
      if (result["code"] == NetStatus.ok) {
        StackAndClusterEntity value = StackAndClusterEntity.fromJson(
          result["data"],
        );
        return value;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  ///获取堆和簇 options
  static Future<OptionsEntity?> getOptions({required String? siteId}) async {
    try {
      if (siteId == null) {
        return null;
      }

      var result = await Http.instance.get(
        ApiPath.getStackAndClusterOptions(siteId: siteId),
      );
      if (result["code"] == NetStatus.ok) {
        OptionsEntity value = OptionsEntity.fromJson(result["data"]);
        return value;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
