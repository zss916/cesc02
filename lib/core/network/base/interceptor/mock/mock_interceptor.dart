import 'package:cesc01/core/network/base/interceptor/mock/mock_data.dart';
import 'package:cesc01/core/network/path.dart';
import 'package:dio/dio.dart';

class MockInterceptor extends InterceptorsWrapper {
  MockInterceptor();

  /// 从请求中安全读取参数（支持 POST body / query）
  T? _getParam<T>(RequestOptions options, String key) {
    // POST body: options.data 可能是 Map 或 String(JSON)
    if (options.method == "POST" || options.method == "PUT") {
      final data = options.data;
      if (data is Map) {
        final value = data[key];
        if (value != null) return value as T;
      }
    }
    // GET query: options.queryParameters
    final queryValue = options.queryParameters[key];
    if (queryValue != null) return queryValue as T;
    return null;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String host = options.uri.origin;
    dynamic response;
    if (host == ApiPath.mockUrl) {
      switch (options.uri.path) {
        case ApiPath.postLogin:
          response = toBaseResult(data: loginResult);
          break;
        case ApiPath.getUserInfo:
          response = toBaseResult(data: authResult);
          break;
        case ApiPath.postLogout:
          response = toBaseResult(data: null);
          break;
        case ApiPath.getDashboard:
          response = toBaseResult(data: homeResult);
          break;
        case ApiPath.postRealTimeList:
          response = _handleRealTimeList(options);
          break;
        case ApiPath.postAlarmList:
          response = _handleAlarmList(options);
          break;
        case ApiPath.getSites:
          response = toBaseResult(data: siteList);
          break;
        case ApiPath.postBatteryList:
          response = toBaseResult(data: toBaseListPage(data: batteryList));
          break;
        case ApiPath.createAndBindingSite:
          response = toBaseResult(data: createAndBindSite);
          break;
      }

      if (options.uri.path.startsWith(ApiPath.getAlarmDetail(alarmId: "")) &&
          options.uri.path != ApiPath.postAlarmList &&
          options.uri.path != ApiPath.getStackAlarmDetail &&
          options.uri.path != ApiPath.getAlarmsSummary) {
        String id = options.uri.path.split('/').last;
        switch (id) {
          case "1":
            response = toBaseResult(data: alarmDetail1);
            break;
          case "2":
            response = toBaseResult(data: alarmDetail2);
            break;
          case "3":
            response = toBaseResult(data: alarmDetail3);
            break;
        }
      } else if (options.uri.path.contains("/house-power/platform/v1/sites/") &&
          options.uri.path.endsWith("/overview")) {
        // GET /sites/{siteId}/overview → 按 siteId 返回对应站点数据
        // 排除 /sites/options（getSites 接口）
        if (options.uri.path != ApiPath.getSites) {
          final siteId = options.uri.path
              .replaceAll("/house-power/platform/v1/sites/", "")
              .replaceAll("/overview", "");
          response = _handleSiteOverview(siteId);
        }
      } else if (options.uri.path.contains("/house-power/platform/v1/sites/") &&
          options.uri.path.endsWith("/options") &&
          options.uri.path != ApiPath.getSites) {
        // GET /sites/{siteId}/options → 返回堆簇下拉选项
        // 排除 /sites/options（getSites 接口，返回 List 不是 Map）
        response = toBaseResult(data: stackAndClusterOptions);
      } else if (options.uri.path.startsWith(
            "/house-power/platform/v1/battery-stacks/",
          ) &&
          options.uri.path.endsWith("/data")) {
        // GET /battery-stacks/{stackId}/data → 返回堆簇详情
        response = _handleStackAndCluster(options);
      } else if (options.uri.path.contains(
            "/house-power/platform/v1/battery-clusters/",
          ) &&
          options.uri.path.endsWith("/detail")) {
        response = toBaseResult(data: batteryCell);
      } else if (options.uri.path.contains("/house-power/platform/v1/sites/") &&
          options.method == "PUT") {
        ///todo
      } else if (options.uri.path.contains('/house-power/platform/v1/sites/') &&
          options.uri.path.endsWith('/bind-batteries')) {
        response = toBaseResult(data: createAndBindSite);
      } else if (options.uri.path == ApiPath.getStackAlarmDetail) {
        response = toBaseResult(data: stackAlarmDetail);
      } else if (options.uri.path == ApiPath.getAlarmsSummary) {
        response = _handleAlarmsSummary(options);
      } else if (options.uri.path == ApiPath.getNotifications) {
        response = toBaseResult(data: notifications);
      } else if (options.uri.path.contains(ApiPath.getBatteryStack(siteId: ""))) {
        response = toBaseResult(data: batteryStackList);
      }

      return handler.resolve(
        Response(
          requestOptions: options,
          data: response,
          statusCode: 200,
          statusMessage: "Mock Data",
        ),
      );
    }

    return handler.next(options);
  }

  /// 实时运行列表 —— 按 commStatus 过滤
  /// commStatus 来自 POST body，取值：ONLINE / ALARM / DELAYED / OFFLINE
  /// null 表示「全部」
  dynamic _handleRealTimeList(RequestOptions options) {
    final commStatus = _getParam<String>(options, "commStatus");
    final keyword = _getParam<String>(options, "keyword");

    final page = realTimeResult["page"] as Map<String, dynamic>;
    final allListRaw = page["list"] as List;
    final List<Map<String, dynamic>> allList =
        allListRaw.map((e) => Map<String, dynamic>.from(e as Map)).toList();

    List<Map<String, dynamic>> filtered = allList;

    // 按 commStatus 筛选
    if (commStatus != null && commStatus.isNotEmpty) {
      filtered = filtered
          .where((item) => item["commStatus"] == commStatus)
          .toList();
    }

    // 按 keyword 搜索（siteName）
    if (keyword != null && keyword.isNotEmpty) {
      filtered = filtered.where((item) {
        final name = item["siteName"]?.toString().toLowerCase() ?? "";
        final kw = keyword.toLowerCase();
        return name.contains(kw);
      }).toList();
    }

    // 构造返回结构：保持原 page 包装，只替换 list
    return toBaseResult(data: {
      "summary": realTimeResult["summary"],
      "page": {
        "total": filtered.length,
        "totalPage": 1,
        "pageNum": 1,
        "pageSize": 10,
        "hasNext": false,
        "list": filtered,
      },
    });
  }

  /// 告警列表 —— 按 status / alarmLevel 过滤
  /// status 来自 POST body，取值：ACTIVE / RECOVERED
  /// alarmLevel 来自 POST body，取值：1/2/3/4
  dynamic _handleAlarmList(RequestOptions options) {
    final status = _getParam<String>(options, "status");
    final alarmLevel = _getParam<int>(options, "alarmLevel");
    final siteId = _getParam<String>(options, "siteId");
    final stackSn = _getParam<String>(options, "stackSn");

    final allListRaw = alarmResult["list"] as List;
    final List<Map<String, dynamic>> allList =
        allListRaw.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    List<Map<String, dynamic>> filtered = allList;

    if (status != null && status.isNotEmpty) {
      // AlarmDetailEntity 本身没有 status 字段，用簇里的 status 判断
      // 简化：ACTIVE 表示至少一个簇 ACTIVE；RECOVERED 表示全部簇 RECOVERED
      if (status.toUpperCase() == "ACTIVE") {
        filtered = filtered.where((item) {
          final clusters = item["clusters"] as List?;
          return clusters != null &&
              clusters.any((c) => c["status"] == "ACTIVE");
        }).toList();
      } else if (status.toUpperCase() == "RECOVERED") {
        filtered = filtered.where((item) {
          final clusters = item["clusters"] as List?;
          return clusters != null &&
              clusters.isNotEmpty &&
              clusters.every((c) => c["status"] == "RECOVERED");
        }).toList();
      }
    }

    if (alarmLevel != null) {
      filtered = filtered
          .where((item) => item["alarmLevel"] == alarmLevel)
          .toList();
    }

    if (siteId != null && siteId.isNotEmpty) {
      filtered = filtered.where((item) => item["siteId"] == siteId).toList();
    }

    if (stackSn != null && stackSn.isNotEmpty) {
      filtered = filtered.where((item) => item["stackSn"] == stackSn).toList();
    }

    return toBaseResult(data: {
      "list": filtered,
    });
  }

  /// 告警汇总 —— 按 query 参数动态计算
  /// GET /alarms/summary?siteId=...&stackSn=...&alarmLevel=...&status=...
  dynamic _handleAlarmsSummary(RequestOptions options) {
    final alarmLevel = _getParam<int>(options, "alarmLevel");
    final siteId = _getParam<String>(options, "siteId");
    final stackSn = _getParam<String>(options, "stackSn");

    final allListRaw = alarmResult["list"] as List;
    final List<Map<String, dynamic>> allList =
        allListRaw.map((e) => Map<String, dynamic>.from(e as Map)).toList();

    List<Map<String, dynamic>> filtered = allList;

    if (alarmLevel != null) {
      filtered = filtered
          .where((item) => (item["alarmLevel"] as int?) == alarmLevel)
          .toList();
    }

    if (siteId != null && siteId.isNotEmpty) {
      filtered = filtered.where((item) => item["siteId"] == siteId).toList();
    }

    if (stackSn != null && stackSn.isNotEmpty) {
      filtered = filtered.where((item) => item["stackSn"] == stackSn).toList();
    }

    // 动态计算汇总值
    final alarmClusterCount = filtered.fold<int>(
        0, (sum, item) => sum + ((item["alarmClusterCount"] as int?) ?? 0));

    // siteCount / stackCount 去重
    final siteIds = filtered.map((e) => e["siteId"]).toSet();
    final stackSns = filtered.map((e) => e["stackSn"]).toSet();

    return toBaseResult(data: {
      "siteCount": siteIds.length,
      "stackCount": stackSns.length,
      "alarmClusterCount": alarmClusterCount,
    });
  }

  /// 站点 Overview —— 按 siteId 返回对应站点数据
  /// GET /sites/{siteId}/overview
  dynamic _handleSiteOverview(String siteId) {
    // 从 siteList 里找匹配站点，构造 singleSiteDetail 结构
    final allListRaw = siteList as List;
    final List<Map<String, dynamic>> allList =
        allListRaw.map((e) => Map<String, dynamic>.from(e as Map)).toList();

    final matchedSite = allList.firstWhere(
      (s) => s["siteId"] == siteId,
      orElse: () => allList.isNotEmpty ? allList.first : <String, dynamic>{},
    );

    final stacksRaw = matchedSite["stacks"] as List? ?? [];
    final List<Map<String, dynamic>> stacks = stacksRaw
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();

    // 把 StackItemEntity 转换成 SiteOverViewDataStacks 结构
    final overviewStacks = stacks.map((s) {
      return {
        "stackId": s["stackId"]?.toString() ?? "",
        "stackName": s["stackName"] ?? "-",
        "stackSn": s["stackSn"] ?? "-",
        "firmwareVersion": s["firmwareVersion"] ?? "--",
        "sysMode": s["sysMode"],
        "clusterCount": s["clusterCount"],
        "packCount": (s["clusterCount"] ?? 0) * 11,
        "commStatus": s["commStatus"] ?? "-",
        "runStatus": s["runStatus"],
        "alarmClusterCount": s["commStatus"] == "ALARM" ? 1 : 0,
        "soc": (s["commStatus"] == "ALARM" ? "72%" : "65%"),
        "soh": "99%",
        "totalVoltage": "408.2 V",
        "totalCurrent": "9.4 A",
        "maxTemperature": "28.3 °C",
        "maxVoltageDiff": "36 mV",
        "lastDataTime": "2026-10-28 14:36:17",
      };
    }).toList();

    // 计算统计
    final onlineCount = overviewStacks.where((s) => s["commStatus"] == "ONLINE").length;
    final alarmCount = overviewStacks.where((s) => s["commStatus"] == "ALARM").length;
    final delayedCount = overviewStacks.where((s) => s["commStatus"] == "DELAYED").length;
    final offlineCount = overviewStacks.where((s) => s["commStatus"] == "OFFLINE").length;
    final alarmClusters = overviewStacks.fold<int>(0, (sum, s) => sum + ((s["alarmClusterCount"] as int?) ?? 0));

    return toBaseResult(data: {
      "siteId": matchedSite["siteId"]?.toString().replaceFirst("site-", ""),
      "siteName": matchedSite["name"] ?? matchedSite["siteCode"] ?? "-",
      "countryRegion": "西班牙 · 加泰罗尼亚",
      "address": "Carrer de Balmes 123, 08007 Barcelona",
      "commStatus": matchedSite["stacks"] == null || (matchedSite["stacks"] as List).isEmpty
          ? "ONLINE"
          : overviewStacks.first["commStatus"],
      "runStatus": "CHARGING",
      "totalStackCount": overviewStacks.length,
      "onlineStackCount": onlineCount,
      "totalClusterCount": overviewStacks.fold<int>(0, (sum, s) => sum + ((s["clusterCount"] as int?) ?? 0)),
      "totalSubPackCount": overviewStacks.fold<int>(0, (sum, s) => sum + ((s["packCount"] as int?) ?? 0)),
      "alarmClusterCount": alarmClusters,
      "alarmStackCount": alarmCount,
      "stackStatusDistribution": {
        "online": onlineCount,
        "alarm": alarmCount,
        "delayed": delayedCount,
        "offline": offlineCount,
      },
      "stacks": overviewStacks,
    });
  }

  /// 堆簇详情 —— 按 stackId 返回对应数据
  /// GET /battery-stacks/{stackId}/data?clusterId=xxx
  dynamic _handleStackAndCluster(RequestOptions options) {
    final stackIdStr = options.uri.path
        .replaceAll(ApiPath.getStackAndCluster(stackId: ""), "")
        .split("/")
        .first;

    // 如果是 101 或 HIFLY-20260610-001，返回完整 stackAndCluster
    if (stackIdStr == "101" || stackIdStr == "HIFLY-20260610-001") {
      return toBaseResult(data: stackAndCluster);
    }

    // 其他 stackId 也返回同一份数据（简化）
    return toBaseResult(data: stackAndCluster);
  }
}
