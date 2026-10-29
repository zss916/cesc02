import 'package:cesc01/core/helper/app_loading.dart';
import 'package:cesc01/core/network/base/interceptor/net_status.dart';
import 'package:cesc01/core/network/bean/site_entity.dart';
import 'package:cesc01/core/network/http.dart';
import 'package:cesc01/core/network/path.dart';

///Provision
abstract class ProvisionAPI {
  ///创建站点并绑定
  static Future<(bool, SiteEntity?)> createAndBindingSite({
    required String name,
    required String countryRegion,
    required String timezone,
    String? detailAddress,
    List<String>? stackSns,
  }) async {
    try {
      Map<String, dynamic> map = {};
      map['name'] = name;
      map['countryRegion'] = countryRegion;
      map['timezone'] = timezone;
      if (detailAddress != null) {
        map['detailAddress'] = detailAddress;
      }
      if (stackSns != null) {
        map['stackSns'] = stackSns;
      }
      var result = await Http.instance.post(
        ApiPath.createAndBindingSite,
        data: map,
      );
      if (result["code"] == NetStatus.ok) {
        SiteEntity value = SiteEntity.fromJson(result['data']);
        return await Future.value((true, value));
      } else {
        AppLoading.toast(result["message"]);
        return await Future.value((false, null));
      }
    } catch (error) {
      return await Future.value((true, null));
    }
  }

  ///站点绑定电池
  static Future<bool> postBindSite({
    required String siteId,
    required List<String> stackSns,
  }) async {
    try {
      Map<String, dynamic> map = {};
      map['stackSns'] = stackSns;
      map['append'] = true;
      var result = await Http.instance.put(
        ApiPath.postBindSite(siteId: siteId),
        data: map,
      );
      if (result["code"] == NetStatus.ok) {
        return true;
      } else {
        AppLoading.toast(result["message"]);
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
