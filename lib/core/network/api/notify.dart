import 'package:cesc01/core/network/base/interceptor/net_status.dart';
import 'package:cesc01/core/network/bean/notify_item_entity.dart';
import 'package:cesc01/core/network/http.dart';
import 'package:cesc01/core/network/path.dart';
import 'package:cesc01/core/network/result/result.dart';
import 'package:flutter/foundation.dart';

///Notify
abstract class NotifyAPI {
  static Future<ApiResult<List<NotifyItemEntity>>> getNotifications() async {
    try {
      Map<String, dynamic> map = {};
      map['limit'] = 20;
      var result = await Http.instance.get(
        ApiPath.getNotifications,
        query: map,
      );
      if (result["code"] == NetStatus.ok) {
        List<NotifyItemEntity> value = await compute(
          (List<dynamic> jsonList) =>
              jsonList.map((e) => NotifyItemEntity.fromJson(e)).toList(),
          (result["data"]['items'] as List),
        );
        return ApiSuccess(value);
      } else {
        return ApiError(errorState: ErrorState.error, msg: result["message"]);
      }
    } catch (e) {
      return ApiError(errorState: ErrorState.exception, msg: e.toString());
    }
  }
}
