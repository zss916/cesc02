import 'package:cesc01/core/network/base/interceptor/net_status.dart';
import 'package:cesc01/core/network/bean/realtime_entity.dart';
import 'package:cesc01/core/network/http.dart';
import 'package:cesc01/core/network/path.dart';
import 'package:cesc01/core/network/result/result.dart';
import 'package:flutter/foundation.dart';

///实时
abstract class RealTimeAPI {
  ///列表
  static Future<ApiResult<List<RealtimePageList>>> postList({
    required int pageNum,
    String? keyword,
    String? commStatus,
  }) async {
    try {
      Map<String, dynamic> map = {};
      map['pageNum'] = pageNum;
      map['pageSize'] = 10;
      if (keyword != null) {
        map['keyword'] = keyword;
      }
      if (commStatus != null) {
        map['commStatus'] = commStatus;
      }
      var result = await Http.instance.post(
        ApiPath.postRealTimeList,
        data: map,
      );
      if (result["code"] == NetStatus.ok) {
        //RealtimeEntity.fromJson(result["data"]);
        List<RealtimePageList> value = await compute(
          (List<dynamic> jsonList) =>
              jsonList.map((e) => RealtimePageList.fromJson(e)).toList(),
          (result["data"]['page']['list'] as List),
        );
        return ApiSuccess(value);
      } else {
        return ApiError(errorState: ErrorState.error, msg: result["message"]);
      }
    } catch (error) {
      return ApiError(errorState: ErrorState.exception, msg: error.toString());
    }
  }
}
