// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:get/get_connect/http/src/status/http_status.dart';
// import 'package:get/get_utils/src/extensions/internacionalization.dart';
//
// class AuthInterceptor extends Interceptor {
//   final Dio Function() dioGetter;
//   AuthInterceptor({required this.dioGetter});
//
//   /// 当前正在刷新 Token 的 Future
//   Completer<void>? _refreshCompleter;
//
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     options.headers["Accept-Timezone"] = TimezoneHeader.getTimezone();
//     options.headers["Accept-Language"] = LocaleHeader.getLocal();
//     options.headers["Authorization"] = AuthorizationHeader.getAuthorization();
//     if (options.path.contains(ApiPath.refreshToken)) {
//       options.headers['Refresh-token'] = AuthorizationHeader.getRefreshToken();
//     }
//     handler.next(options);
//   }
//
//   @override
//   Future<void> onResponse(
//     Response response,
//     ResponseInterceptorHandler handler,
//   ) async {
//     if (response.statusCode == HttpStatus.ok) {
//       Map<String, dynamic> map = response.data as Map<String, dynamic>;
//       // debugPrint("map:${map}");
//       if (map["code"] == 99999 || map["code"] == 401) {
//         //登录接口
//         if (response.realUri.path.contains(ApiPath.postLogin)) {
//           super.onResponse(response, handler);
//         } else {
//           // Refresh Token 接口本身出现 401
//           // 不能再次刷新
//           if (response.requestOptions.path.contains(ApiPath.refreshToken)) {
//             //debugPrint("==>已经请求过");
//             //handler.next(err);
//             reLogin(msg: TKey.reloginTip.tr);
//             return;
//           }
//
//           // 已经重试过一次
//           // 防止无限循环
//           final alreadyRetry =
//               response.requestOptions.extra["retryKey"] == true;
//
//           if (alreadyRetry) {
//             //handler.next(err);
//             return;
//           }
//
//           // 标记已经重试
//           response.requestOptions.extra["retryKey"] = true;
//
//           try {
//             await _refreshTokenIfNeeded();
//             final retryResponse = await _retry(response.requestOptions);
//             handler.resolve(retryResponse);
//           } catch (e) {
//             handler.reject(
//               DioException(
//                 message: "${map["message"]}",
//                 requestOptions: response.requestOptions,
//                 response: response,
//                 type: DioExceptionType.badResponse,
//                 error: "$e",
//               ),
//             );
//             //debugPrint("==>登录已经过期，请重新登录");
//             reLogin(msg: TKey.reloginTip.tr);
//             return;
//           }
//         }
//       } else {
//         super.onResponse(response, handler);
//       }
//     }
//   }
//
//   Future<Response> _retry(RequestOptions requestOptions) async {
//     requestOptions.headers['Authorization'] =
//         AuthorizationHeader.getAuthorization();
//     return await dioGetter().fetch(requestOptions);
//   }
//
//   Future<void> _refreshTokenIfNeeded() async {
//     // 已经有请求在刷新 Token
//     if (_refreshCompleter != null) {
//       return _refreshCompleter!.future;
//     }
//
//     // 创建刷新锁
//     final completer = Completer<void>();
//     _refreshCompleter = completer;
//
//     try {
//       TokenEntity? value = await AdminAPI.refreshToken();
//       if (value != null) {
//         User.setTokenHead(tokenHead: value.tokenHeadValue);
//         User.setToken(token: value.tokenValue);
//         User.setRefreshToken(refreshToken: value.refreshToken ?? "");
//         completer.complete();
//       } else {
//         // debugPrint("==> 登录已经过期");
//         await reLogin(msg: TKey.reloginTip.tr);
//         completer.completeError(TKey.reloginTip.tr);
//         _refreshCompleter = null;
//       }
//     } catch (e, stackTrace) {
//       completer.completeError(e, stackTrace);
//       rethrow;
//     } finally {
//       _refreshCompleter = null;
//     }
//   }
//
//   ///重新登录
//   Future<void> reLogin({String? msg}) async {
//     AppLoading.toast(msg ?? "");
//     Future.wait([
//       User.to.removeToken(),
//       User.to.removeRefreshToken(),
//     ]).whenComplete(() {
//       PageTools.offAllNamedSplash();
//     });
//   }
// }
