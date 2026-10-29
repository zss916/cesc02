# CESC01 移动端 — 技术实现文档

> 版本：v1.0.0+1 · Flutter SDK ^3.13.2 · Dart 3.x

---

## 目录

- [1. 项目概述](#1-项目概述)
- [2. 技术栈](#2-技术栈)
- [3. 工程结构](#3-工程结构)
- [4. 启动流程](#4-启动流程)
- [5. 架构分层](#5-架构分层)
  - [5.1 状态契约](#51-状态契约)
  - [5.2 GetX 路由与鉴权](#52-getx-路由与鉴权)
  - [5.3 网络层](#53-网络层)
  - [5.4 实体与序列化](#54-实体与序列化)
  - [5.5 拦截器链](#55-拦截器链)
- [6. 业务模块](#6-业务模块)
- [7. 关键实现范式](#7-关键实现范式)
- [8. Mock 体系](#8-mock-体系)
- [9. BLE 配网子系统](#9-ble-配网子系统)
- [10. 国际化](#10-国际化)
- [11. 构建与调试](#11-构建与调试)
- [12. 已知限制](#12-已知限制)

---

## 1. 项目概述

CESC01 是面向户用储能系统（Hiflying PowerNest 系列）的移动端运维应用，核心能力：

| 能力 | 说明 |
|---|---|
| 站点管理 | 多站点下拉切换，站点概览数据（堆数、簇数、告警数、状态分布） |
| 实时运行 | 站点运行状态卡片列表，通信状态筛选（在线/告警/延迟/离线） |
| 堆簇详情 | Stack/Cluster 双 Tab 切换，指标网格、运行保护、电量、趋势图、极值、诊断、系统信息 |
| 告警中心 | 实时告警 / 历史告警，按等级（严重/重要/一般）、状态、站点、堆筛选，告警簇分组展开 |
| 告警详情 | 堆级告警摘要，多簇多 Pack 多单体告警明细 |
| 消息通知 | 告警推送 + 固件升级推送双类型 |
| 设备配网 | BLE 扫描 → 连接 → WiFi 下发 → 建站/绑定，双平台原生插件支持 |
| 个人中心 | 用户信息、授权站点、机构、语言切换、关于页 |

---

## 2. 技术栈

| 分类 | 依赖 | 版本 | 用途 |
|---|---|---|---|
| 框架 | `flutter` | SDK | Material 3 UI |
| 状态/路由 | `get` | 4.7.3 | GetXController + GetMaterialApp + Get.toNamed |
| 网络 | `dio` | 5.10.0 | 拦截器链、CancelToken、动态超时 |
| UI | `flutter_screenutil` | 5.9.3 | 375×812 设计稿自适应 |
| 存储 | `shared_preferences` + `flutter_secure_storage` | 2.5.6 / 11.2.0 | 轻量键值 / 敏感数据加密存储 |
| 网络感知 | `connectivity_plus` | ^7.3.1 | 网络连通性 + 网络质量分级 |
| 日志 | `pretty_dio_logger` + `logger` | 1.4.0 / ^2.7.0 | 请求/响应日志、业务日志 |
| 蓝牙 | `flutter_blue_plus` | 2.3.13 | BLE 扫描展示 |
| 本地插件 | `smart_ble_link` | 本地 | Hiflying BLELink（Android）/ JY_BlueSDK（iOS）原生封装 |
| 下拉刷新 | `pull_to_refresh_simple` | 3.0.3 | 统一下拉刷新控制器 |
| 权限 | `permission_handler` | 12.0.3 | 蓝牙/定位权限 |
| 图表 | `syncfusion_flutter_charts` | 35.1.41 | 堆/簇 SOC-电压-电流趋势图 |
| 条码 | `ai_barcode_scanner` | 8.2.0 | 配网扫描设备二维码 |
| 时区 | `time_zone_plus` | 0.0.4 | 站点多时区适配 |
| 事件 | `event_bus` | 2.0.1 | 跨模块事件通信 |
| WebView | `webview_flutter` | ^4.14.0 | 内嵌 Web 页面（协议/帮助） |
| 代码生成 | `build_runner` + `json_serializable` | ^2.15.0 | `fromJson` / `toJson` 生成 |
| 资源生成 | `flutter_gen_runner` | 5.15.0 | 图片/字体/JSON 常量生成 |

**本地插件路径：**
```
plugins/smart_ble_link           ← Hiflying BLE 配网 SDK 封装
plugins/country_state_city_selector ← 国家/省/市选择器
```

---

## 3. 工程结构

```
cesc01/
├── lib/
│   ├── main.dart                          # GetMaterialApp 入口
│   ├── bootstrap/                         # 全局初始化管线
│   │   ├── application.dart               # Initializer 顺序编排
│   │   ├── system_ui_initializer.dart     # SystemChrome + ScreenUtilInit
│   │   ├── service_initializer.dart       # Get.put(UserService/NetworkService)
│   │   ├── network_initializer.dart       # Http 单例初始化
│   │   ├── storage_initializer.dart       # SharedPreferences 初始化
│   │   ├── totast_initializer.dart        # FlutterEasyLoading 初始化
│   │   ├── theme_initializer.dart         # 主题加载（已注释）
│   │   └── app_initializer.dart           # 抽象基类
│   ├── core/                              # 核心层（业务无关）
│   │   ├── network/
│   │   │   ├── path.dart                  # 23 个 API 路径常量
│   │   │   ├── http.dart                  # Dio 单例 + 拦截器链
│   │   │   ├── api/                       # 7 个 API 文件（按业务域）
│   │   │   ├── bean/                      # 21 个实体类
│   │   │   ├── result/result.dart         # ApiResult<T> 密封类
│   │   │   ├── base/
│   │   │   │   ├── header/                # Auth/Authorization/Locale/Timezone 头
│   │   │   │   ├── interceptor/
│   │   │   │   │   ├── auth/              # Token 注入
│   │   │   │   │   ├── mock/              # MockInterceptor + mock_data
│   │   │   │   │   ├── network_status/    # 网络质量 + 请求队列
│   │   │   │   │   ├── retry/             # 重试 + 熔断器
│   │   │   │   │   └── response/          # 响应统一处理
│   │   │   │   ├── exceptions/            # 网络/超时/业务异常
│   │   │   │   └── base_options.dart      # baseUrl / connectTimeout 等
│   │   │   └── generated/json/             # 23 个 .g.dart（json_serializable）
│   │   ├── state/
│   │   │   ├── uiState.dart               # UiState 密封类
│   │   │   ├── app_network_mixin.dart     # 网络感知 mixin
│   │   │   └── network/                   # BaseNetStateLogic / BaseNetConnectLogic
│   │   ├── translations/
│   │   │   ├── lan_key.dart               # 67+ 个 key 常量
│   │   │   ├── lan_tools.dart             # tr / trArgs 扩展
│   │   │   ├── zh.dart                    # 中文翻译
│   │   │   ├── en.dart                    # 英文翻译
│   │   │   └── language.dart              # Locale 枚举
│   │   ├── system/                        # 主题、颜色、存储
│   │   ├── helper/                        # device_status、tools、app_loading
│   │   ├── service/                       # UserService / NetworkService
│   │   ├── components/                    # 通用 UI 组件
│   │   ├── permission/                    # BLEManager + PermissionTools
│   │   ├── event/                         # AppEventBus / NetworkEvent
│   │   └── log/                           # LogUtil
│   ├── feature/                           # 业务模块（GetX 命名）
│   │   ├── home/                          # 首页
│   │   ├── realtime/                      # 实时运行
│   │   ├── station/                       # 站点详情（堆+簇）
│   │   ├── alarm/                         # 告警中心
│   │   ├── message/                       # 消息通知
│   │   ├── provision/                     # 设备配网
│   │   ├── language/                      # 语言切换
│   │   └── web/                           # WebView
│   └── routes/
│       └── app_route.dart                 # 9 个路由 + 弹窗路由
├── plugins/                               # 本地原生插件
├── assets/                                # JSON/图标/启动图/HTML
└── pubspec.yaml                           # v1.0.0+1
```

---

## 4. 启动流程

```
main.dart
  └── runApp(ScreenUtilInit + GetMaterialApp)
        └── Application.init()  ← Future<void> 顺序执行
              ├── SystemUiInitializer.init()
              │     └── SystemChrome + ScreenUtilInit 初始化
              ├── ServiceInitializer.init()
              │     └── Get.put(UserService) + Get.put(NetworkService)
              ├── NetworkInitializer.init()
              │     └── Http() 单例创建 → Dio + 拦截器链
              ├── ToastInitializer.init()
              │     └── FlutterEasyLoading 初始化
              ├── StorageInitializer.init()
              │     └── SharedPreferences.getInstance()
              └── ThemeInitializer.init()  (已注释)

GetMaterialApp 配置：
  translations: AppTranslations()  ← zh / en
  fallbackLocale: en_US
  getPages: ARoute.routes           ← 9 个 GetPage
  themeMode: ThemeMode.light
  initialRoute: ARoute.main         ← 挂载 AuthGuard
  navigatorObservers: [appRouteObserver]
```

**AuthGuard 职责：** 判断是否登录 → 未登录跳转 LoginPage，已登录跳转 MainPage（Home/Realtime/Station 三 Tab）。

---

## 5. 架构分层

### 5.1 状态契约

项目使用两个密封类（`sealed class`）定义状态与结果，所有 Logic 遵循统一模式。

**UiState — 页面加载状态（Logic.state 字段）**

```dart
sealed class UiState {}
class Loading   extends UiState {}  // 初始/刷新中
class Success<T> extends UiState { final T data; }  // 成功，携带数据
class Failure   extends UiState {}  // 业务错误
class Offline   extends UiState {}  // 网络离线
class Empty     extends UiState {}  // 空数据
```

**ApiResult — API 返回结果**

```dart
enum ErrorState { error, exception, paramError }
sealed class ApiResult<T> {}
class ApiSuccess<T> extends ApiResult<T> { final T data; }
class ApiError<T>   extends ApiResult<T> { final String? msg; final ErrorState? errorState; }
```

**Logic 基类 — BaseNetStateLogic**

```dart
abstract class BaseNetStateLogic extends GetxController {
  UiState state = Loading();  // 初始状态

  void loadData<T>({
    bool loading = true,
    bool isDelayed = false,
    required Function onFetch,
  }) async {
    // 1. 检查网络连通性 → 断开则 state = Offline()
    // 2. loading=true → state = Loading()
    // 3. 执行 onFetch() → 根据 ApiResult 更新 state
  }
}
```

UI 层通过 `Obx` / `GetBuilder` 监听 `state`，配合 `UiStateWidget`（Loading/Empty/Offline/Success 四态切换）渲染。

### 5.2 GetX 路由与鉴权

**路由定义（ARoute）**

| 常量 | 路径 | 页面 | 备注 |
|---|---|---|---|
| `login` | `/login` | LoginPage | 免鉴权 |
| `main` | `/main` | MainPage | **挂载 AuthGuard** |
| `stackAlarmDetail` | `/stackAlarmDetail` | StackAlarmDetailPage | arguments: {siteId, stackSn, status} |
| `message` | `/message` | MessagePage | — |
| `provision` | `/provision` | ProvisionPage | BLE 配网 |
| `language` | `/language` | LanguagePage | — |
| `about` | `/about` | AboutPage | — |
| `version` | `/version` | VersionPage | — |
| `web` | `/web` | WebPage | arguments: {url, title} |

**弹窗路由（Get.dialog / Get.bottomSheet）**

- `ARoute.alarmFilterSite` — 告警筛选-站点弹窗
- `ARoute.alarmAlarmDetail` — 告警详情 Sheet
- `ARoute.provisionSuccess` — 配网成功 Sheet
- `ARoute.provisionTimeout` — 配网超时 Sheet
- `ARoute.provisionStateSheet` — 配网状态 Sheet
- `ARoute.iosBleDialog` — iOS 蓝牙开关提示
- `ARoute.iosLocationService` — iOS 定位服务提示
- `ARoute.blePermissionTip` — BLE 权限提示

### 5.3 网络层

**API 文件组织（按业务域）**

| 文件 | 对应模块 | 主要方法 |
|---|---|---|
| `home.dart` | 首页 | `getDashboard()` |
| `realtime.dart` | 实时运行 | `postList(pageNum, commStatus)` |
| `site.dart` | 站点详情 | `getOverView(siteId)` / `getSiteList()` / `getOptions(siteId)` / `getStackAndCluster(stackId, clusterId)` / `postBatteryList(pageNum, siteId)` |
| `alarm.dart` | 告警 | `postList(pageNum, siteId, stackSn, alarmLevel, status)` / `getAlarmsSummary(...)` / `getAlarmDetail(alarmId)` / `getStackAlarmDetail(...)` |
| `notify.dart` | 消息 | `getNotifications()` |
| `admin.dart` | 登录/用户 | `postLogin()` / `getUserInfo()` / `postLogout()` |
| `provision.dart` | 配网 | `createAndBindingSite(...)` / `postBindSite(...)` |

**两种解析模式**

```dart
// 模式 A：ApiResult 密封类（带错误状态）
static Future<ApiResult<SiteOverViewDataEntity>> getOverView({required String? siteId}) async {
  var result = await Http.instance.get(ApiPath.getSiteOverview(siteId: siteId ?? ""));
  if (result["code"] == NetStatus.ok) {
    return ApiSuccess(SiteOverViewDataEntity.fromJson(result["data"]));
  } else {
    return ApiError(errorState: ErrorState.error, msg: result["message"]);
  }
}

// 模式 B：nullable（成功返回实体，失败返回 null）
static Future<StackAndClusterEntity?> getStackAndCluster({required String stackId}) async {
  var result = await Http.instance.get(ApiPath.getStackAndCluster(stackId: stackId));
  if (result["code"] == NetStatus.ok) {
    return StackAndClusterEntity.fromJson(result["data"]);
  }
  return null;
}

// 模式 C：(bool, List<T>) Record（列表类）
static Future<(bool, List<SiteItemEntity>)> getSiteList() async {
  var result = await Http.instance.get(ApiPath.getSites);
  if (result["code"] == NetStatus.ok) {
    List<SiteItemEntity> value = await compute(
      (List<dynamic> jsonList) => jsonList.map((e) => SiteItemEntity.fromJson(e)).toList(),
      (result["data"] as List),
    );
    return (true, value);
  }
  return (false, <SiteItemEntity>[]);
}
```

### 5.4 实体与序列化

**21 个实体类 — 统一使用 `json_serializable` 代码生成**

```dart
@JsonSerializable()
class DashboardEntity {
  String? connectedSiteCount;
  // ...
  factory DashboardEntity.fromJson(Map<String, dynamic> json) => $DashboardEntityFromJson(json);
  Map<String, dynamic> toJson() => $DashboardEntityToJson(this);
}
```

**关键实体清单**

| 实体 | 用途 | 解析路径 |
|---|---|---|
| `DashboardEntity` | 首页概览 | `result["data"]` |
| `RealtimeEntity` | 实时运行列表 | `result["data"]` |
| `SiteOverViewDataEntity` | 站点概览（堆分布） | `result["data"]` |
| `StackAndClusterEntity` | 堆+簇详情（最复杂，含 8 个子结构） | `result["data"]` |
| `AlarmDetailEntity` | 告警列表项（堆级，含 clusters[]） | `result["data"]["list"]` |
| `StackAlarmDetailEntity` | 堆告警详情 | `result["data"]` |
| `AlarmSummaryEntity` | 告警汇总统计 | `result["data"]` |
| `OptionsEntity` | 站点堆簇下拉选项 | `result["data"]` |
| `SiteItemEntity` | 站点列表项（含 stacks[]） | `result["data"]` |
| `BatteryListList` | 电池包列表 | `result["data"]["list"]` |
| `NotifyItemEntity` | 消息通知 | `result["data"]["items"]` |
| `AuthEntity` | 用户信息 | `result["data"]` |

**运行代码生成**

```bash
dart run build_runner build      # 生成 .g.dart
dart run build_runner watch      # 监听变更自动生成
```

### 5.5 拦截器链

```
Http._internal()
  └── _dio.interceptors 按序添加：
        ① AuthInterceptor()         ← 注入 Authorization / Locale / Timezone 头
        ② MockInterceptor()         ← 本地 Mock 数据拦截（host == ApiPath.mockUrl 时生效）
        ③ NetworkStatusInterceptor  ← 网络质量检测 + 请求队列 + 动态超时
        ④ PrettyDioLogger           ← kDebugMode 时追加，打印请求/响应
```

**动态超时机制**

```dart
NetworkStatusService.instance.qualityStream.listen((quality) {
  _dio.options.connectTimeout = NetworkStatusService.instance.connectTimeout;
  _dio.options.receiveTimeout = NetworkStatusService.instance.receiveTimeout;
});
// 网络质量分级：Good(10s) → Moderate(20s) → Poor(40s) → Offline(拒绝)
```

---

## 6. 业务模块

### 6.1 Home — 首页

| 组件 | 功能 | API |
|---|---|---|
| `HomeOverviewWidget` | 4 指标卡（站点数/堆数/簇数/告警簇数） | `HomeAPI.getDashboard()` → `DashboardEntity` |
| `HomeSiteCard` | 站点卡片列表（站点名/地区/状态徽章/在线堆） | 同上 `DashboardEntity.sites` |
| `ProvisionQuickCard` | 配网快捷入口 | — |

### 6.2 RealTime — 实时运行

| 组件 | 功能 | API |
|---|---|---|
| `RealtimeFilterWidget` | 通信状态筛选（全部/在线/告警/延迟/离线） | 筛选状态通过 POST body `commStatus` 传给 API |
| `SearchBarWidget` | 站点名称搜索 | POST body `keyword` |
| `SiteCardItem` | 站点卡片（状态/堆数·簇数/SOC/温度/最新上报/告警） | `RealtimeAPI.postList()` → `RealtimeEntity` |

### 6.3 Station — 站点详情

**三个 Tab：站点概览 / 电池数据 / 历史数据**

| 组件 | 功能 | API |
|---|---|---|
| `SingleSiteInfoItem` | 站点基础信息（名称/地区/地址/通信状态/运行状态） | `SiteAPI.getOverView()` → `SiteOverViewDataEntity` |
| `BatteryStackList` | 堆卡片列表（SOC/SOH/电压/电流/温度/告警） | `SiteOverViewDataEntity.stacks[]` |
| `BatteryData` | 电池数据 Tab 容器（堆/簇选择器 + IndexedStack） | 组合下面两个 |
| `StackClusterSelector` | 堆 + 簇双选择器（chip 下拉） | `SiteAPI.getOptions()` → `OptionsEntity` |
| `StackDataView` | 堆数据视图 | `SiteAPI.getStackAndCluster()` → `StackAndClusterEntity` |
| `ClusterDataView` | 簇数据视图 | 同上，切换 clusterId 查询 |
| `StackMetricsGrid` | 指标网格（SOC/SOH/电压/电流/温度/压差） | `StackAndClusterEntity.summary` |
| `StackRunningWidget` | 运行保护卡（运行状态/循环次数/最大充放电电流） | `StackAndClusterEntity.runningProtection` |
| `StackElectricity` | 电量卡（剩余/可充/可放/累计充放电/最大温差） | `StackAndClusterEntity.energy` |
| `BatteryTrendChartCard` | SOC-电压-电流趋势折线图 | `StackAndClusterEntity.trend.points[]` |
| `BatteryClusterDetailPanel` | 簇详情面板（指标卡 + Pack 诊断 + 极值） | `StackAndClusterEntity.clusters[]` + `diagnosis` + `extrema` |

### 6.4 Alarm — 告警中心

**三个 Tab：实时告警 / 历史告警 / 告警汇总**

| 组件 | 功能 | API |
|---|---|---|
| `FilterStatusWidget` | 告警等级筛选（全部/严重/重要/一般） | POST body `alarmLevel` |
| `FilterSiteWidget` | 站点/堆筛选弹窗 | `SiteAPI.getSiteList()` → `siteList` |
| `AlertCard` | 告警卡片（站点名·编码/堆名·SN/告警簇数·等级·发生时间） | `AlarmAPI.postList()` → `List<AlarmDetailEntity>` |
| `BatteryStackInfoCard` | 告警详情头部（堆名/SN/站点/告警簇数·告警数） | `AlarmDetailEntity` |
| `BatteryClusterAlarmCard` | 簇告警卡片（簇名/SN/告警条数·等级/状态·Pack·单体） | `StackAlarmDetailEntity.clusters[]` |

**告警详情跳转链**

```
AlertCard.onTap
  → PageTools.toAlarmDetail(siteId, stackSn, status)
    → Get.toNamed('/stackAlarmDetail', arguments: {siteId, stackSn, status})
      → StackAlarmDetailLogic.onInit() 读 Get.arguments
        → AlarmAPI.getStackAlarmDetail(siteId:, stackSn:, status:)
          → GET /alarms/stack-detail
```

### 6.5 Message — 消息通知

| 组件 | 功能 | API |
|---|---|---|
| `AlarmMessageItem` | 告警推送消息（等级徽章/标题/站点·时间） | `NotifyAPI.getNotifications()` → `List<NotifyItemEntity>` (type=ALARM) |
| `UpgradeMessageItem` | 固件升级消息（蓝色徽章/标题/时间） | 同上 (type=UPGRADE) |

### 6.6 Provision — 设备配网

**四步流程：Step0 权限 → Step1 扫描连接 → Step2 WiFi 下发 → Step3 建站/绑定**

| 步骤 | 组件 | 说明 |
|---|---|---|
| Step0 | `StepBluetooth` | BLE/定位权限请求 + 系统蓝牙开关提示 |
| Step1 | `StepConnect` | BLE 设备扫描列表 → 点击连接（`flutter_blue_plus`） |
| Step2 | `BuildStepConfig` | WiFi 名称/密码输入 → `SmartBleLinkTools.startLinking()` 下发 |
| Step3 | `BuildStepSite` | 站点信息填写 → `ProvisionAPI.createAndBindingSite()` / `postBindSite()` |

**BLE 双通道架构**

```
flutter_blue_plus          → 用于设备扫描展示（跨平台）
smart_ble_link (本地插件)   → 用于 WiFi 下发（Hiflying BLELink Android / JY_BlueSDK iOS）
```

**事件驱动配网状态机**

```dart
SmartBleLink.events  ← Stream<SmartBleLinkEvent>
  ├── isProgress     → 进度更新
  ├── isMessage      → 普通消息
  ├── isLinked       → 设备发现成功（AP 模式）
  ├── isTimeout      → 配网超时
  ├── isError        → 配网失败
  └── isFinished     → 配网完成（设备连上路由器）
```

---

## 7. 关键实现范式

### 范式 1：Logic + View + Widget 分层

```
feature/alarm/
  ├── logic.dart        ← GetxController（状态 + API 调用）
  ├── view.dart         ← StatelessWidget（Obx 监听 state，渲染页面骨架）
  ├── index.dart        ← part 指令汇总
  └── widget/           ← 可复用子组件
        ├── alert_card.dart
        ├── alarm_status_widget.dart
        └── filter_status_widget.dart
```

### 范式 2：GetBuilder + Obx 双模式

```dart
// 简单场景：GetBuilder
GetBuilder<HomeLogic>(builder: (logic) { ... })
logic.update();  // 手动刷新

// 复杂场景：Obx（响应式变量）
RxInt count = 0.obs;
Obx(() => Text('${logic.count.value}'));
count.value++;  // 自动刷新
```

### 范式 3：UiState 四态切换

```dart
Obx(() {
  final state = logic.state.value;
  if (state is Loading) return AppPageLoading();
  if (state is Empty) return AppPageEmpty();
  if (state is Offline) return AppPageOffline();
  if (state is Success<T>) return _buildContent(state.data);
  return const SizedBox.shrink();
})
```

### 范式 4：MockInterceptor 参数过滤

```dart
// 从 POST body 读 commStatus / alarmLevel / siteId
dynamic _handleAlarmList(RequestOptions options) {
  final status = _getParam<String>(options, "status");
  final alarmLevel = _getParam<int>(options, "alarmLevel");

  List<Map<String, dynamic>> filtered = List.from(alarmResult["list"]);
  if (alarmLevel != null) {
    filtered = filtered.where((item) => item["alarmLevel"] == alarmLevel).toList();
  }
  return toBaseResult(data: {"list": filtered});
}
```

### 范式 5：路径匹配防御性编程

```dart
// 反例：ApiPath.getSites 和 ApiPath.getStackAndClusterOptions 路径有包含关系
// 正例：显式排除
if (path.contains("/sites/") && path.endsWith("/options") && path != ApiPath.getSites) {
  response = toBaseResult(data: stackAndClusterOptions);  // Map
}
// switch 中精确匹配优先
case ApiPath.getSites:
  response = toBaseResult(data: siteList);  // List
```

### 范式 6：时间戳 + 时区适配

```dart
// SiteAPI 从服务器拿 UTC 时间戳
// time_zone_plus 库处理多时区站点
// Station 详情页显示站点本地时间
"lastDataTime": "2026-10-28 14:36:17",
"timezone": "Europe/Madrid",
```

---

## 8. Mock 体系

### 8.1 架构

```
MockInterceptor (extends InterceptorsWrapper)
  ├── 判断 host == ApiPath.mockUrl → 拦截所有请求
  ├── switch + else-if 链匹配路径
  ├── 静态常量返回（loginResult / homeResult / stackAndCluster ...）
  └── 动态过滤方法（_handleRealTimeList / _handleAlarmList / _handleSiteOverview）

mock_data.dart — 21 个常量（const Map / List）
mock_interceptor.dart — 路径匹配 + 参数解析 + 动态过滤
```

### 8.2 路径匹配优先级

```
switch (path) {
  case ApiPath.getSites:              → 精确匹配 "/sites/options"
  case ApiPath.getDashboard:          → 精确匹配
  ...
}

// else-if 链（带排除条件，防止路径包含关系冲突）
if (path.startsWith("/alarms/")) 排除 summary/stack-detail → alarmDetail1/2/3
else if (path.contains("/sites/overview")) 排除 getSites  → _handleSiteOverview(siteId)
else if (path.contains("/sites/options")) 排除 getSites → stackAndClusterOptions
else if (path.startsWith("/battery-stacks/") && endsWith("/data")) → _handleStackAndCluster
else if (path == "/alarms/stack-detail") → stackAlarmDetail
else if (path == "/alarms/summary") → _handleAlarmsSummary
else if (path == "/notifications") → notifications
```

### 8.3 动态过滤接口

| 接口 | 请求参数 | 过滤逻辑 |
|---|---|---|
| `POST /sites/realtime/page` | commStatus / keyword | 按通信状态 / 站点名过滤 list |
| `POST /alarms/page` | status / alarmLevel / siteId / stackSn | 按告警状态 / 等级 / 站点 / 堆过滤 list |
| `GET /alarms/summary` | alarmLevel / siteId / stackSn | 动态计算 siteCount / stackCount / alarmClusterCount |
| `GET /sites/{siteId}/overview` | siteId | 从 siteList 找匹配站点，动态构造 SiteOverViewDataEntity |
| `GET /battery-stacks/{stackId}/data` | stackId | 返回完整 stackAndCluster |

### 8.4 数据一致性

所有 mock 常量共享同一组 siteId / siteName / stackSn：

```
site-001 巴塞罗那阳光公寓  → HIFLY-20260610-001 (ALARM) + HIFLY-20260610-002 (ONLINE)
site-002 米兰绿色社区      → HIFLY-20260615-001 (ALARM) + HIFLY-20260615-002 (ONLINE)
site-003 阿姆斯特丹运河住宅 → HIFLY-20260620-001 (DISCHARGING)
site-004 柏林湖畔别墅      → HIFLY-20260702-001 (DELAYED)
site-005 苏黎世山景住宅    → OFFLINE
```

---

## 9. BLE 配网子系统

### 9.1 双通道设计

```
┌─────────────────────────────────────────────────────────┐
│                    ProvisionPage                        │
├──────────────────┬──────────────────────────────────────┤
│  flutter_blue_plus│        smart_ble_link (本地插件)       │
│  设备扫描展示      │        WiFi 下发 + 配网状态机          │
│  跨平台 (iOS/And)  │  Hiflying BLELink (Android)          │
│                   │  JY_BlueSDK (iOS)                    │
└──────────────────┴──────────────────────────────────────┘
```

### 9.2 配网时序

```
Step0 权限
  └── BLEManager.instance.requestPermissions()
        → permission_handler: BLUETOOTH_CONNECT / BLUETOOTH_SCAN / LOCATION
        → 失败 → BlePermissionTipDialog

Step1 扫描连接
  └── BLEManager.instance.startScan(keyword: "HIFLY")
        → flutter_blue_plus.ScanResults 流
        → UI 显示设备卡片列表
        → 点击 → BLEManager.instance.connect(device)

Step2 WiFi 下发
  └── SmartBleLinkTools.instance.startLinking(
        ssid: controller.ssid.text,
        password: controller.password.text,
        bleName: selectedDevice.name,
      )
        → SmartBleLink.startLinking(..., timeoutSeconds: 50)
        → 事件流驱动 UI 状态变更

Step3 建站/绑定
  ├── 新站点 → ProvisionAPI.createAndBindingSite(
  │     siteName, countryRegion, timezone, address, stackSns: [sn])
  └── 已存在 → ProvisionAPI.postBindSite(siteId, stackSns: [sn])
        → 成功 → SmartBleLinkTools.instance.stopLinking() + Get.back()
```

### 9.3 配网事件状态机

| 事件 | 含义 | UI 行为 |
|---|---|---|
| `isProgress` | 进度更新 | 进度条 + 百分比 |
| `isMessage` | 普通消息 | 状态文本（如「正在连接 AP...」） |
| `isLinked` | 设备发现（AP 模式） | 提示用户确认 |
| `isTimeout` | 配网超时（50s） | TimeoutSheet |
| `isError` | 配网失败 | 错误提示 + 重试按钮 |
| `isFinished` | 配网完成 | SuccessSheet |

### 9.4 错误码映射

```dart
LinkingErrorExtension.message → {
  ERROR: internalError,
  CANCEL: bleCancel,
  BLUETOOTH_DISABLED: bleDisabled,
  NO_VALID_WIFI_CONNECTION: noValidWifiConnect,
  BLE_NOT_FOUND: bleDeviceNotFound,
  CONNECT_BLE_FAILED: failedToConnectBle,
  CONFIG_BLE_FAILED: failedToConfigureBle,
  FIND_DEVICE_FAILED: notLinkedDeviceFound,
  FIND_DEVICE_FAILED_AP_PASSWORD_ERROR: incorrectWifiPassword,
  FIND_DEVICE_FAILED_AP_NOT_EXIST: wifiNotExist,
  default: unknow,
}
```

---

## 10. 国际化

### 10.1 架构

```
core/translations/
  ├── lan_key.dart       ← 所有翻译 key 常量（67+）
  ├── lan_tools.dart     ← LKey extension + tr() / trArgs()
  ├── zh.dart            ← 中文翻译 Map
  ├── en.dart            ← 英文翻译 Map
  └── language.dart      ← Locale 枚举
```

### 10.2 使用方式

```dart
// 简单 key
Text(LKey.cluster.tr)        // → "簇" / "Cluster"

// 带参数
Text(LKey.clusterCountUnit.trArgs(['${clusters.length}']))
  // → "3 簇" / "3 Clusters"

// 动态状态文本（枚举扩展）
AlarmLevel.severe.title  // → "严重" / "Severe"
AlarmLevel.severe.colorValue  // → Colors.red
```

---

## 11. 构建与调试

### 11.1 开发环境

```bash
# Flutter SDK
flutter --version  # → 3.x.x (Dart 3.x)

# 代码生成
dart run build_runner build --delete-conflicting-outputs

# Mock 模式
# mock_interceptor.dart 中 host == ApiPath.mockUrl 时拦截
# path.dart 中 baseUrl = "http://192.168.8.35:10003"
# mockUrl = "https://api.mock.com"
# 切换：path.dart 中 baseUrl → mockUrl 即可启用 Mock
```

### 11.2 关键命令

```bash
flutter clean && flutter pub get
flutter run                      # 真机/模拟器
flutter run --profile            # 性能分析
flutter analyze                  # 静态检查
flutter test                     # 单元测试（当前项目暂无）

# 代码生成
dart run build_runner build
dart run flutter_gen_runner build
```

### 11.3 Mock 切换说明

在 `path.dart` 中：

```dart
// 真实后端
static const String baseUrl = "http://192.168.8.35:10003";

// Mock 模式：将 baseUrl 改为 mockUrl
static const String baseUrl = "https://api.mock.com";  // ← 注释掉上一行启用
```

---

## 12. 已知限制

| # | 限制 | 说明 |
|---|---|---|
| 1 | 无单元测试 | `flutter test` 当前无覆盖 |
| 2 | 无 Provider/Riverpod | 全项目仅 GetX，无其他状态管理方案 |
| 3 | 主题已注释 | `ThemeInitializer.init()` 在 `application.dart` 中已注释 |
| 4 | WiFi 扫描依赖注释 | `wifi_scan` 和 `hiblob` 依赖已注释掉 |
| 5 | 实时刷新未实现 | `BatteryData` 的 `_refreshData()` 方法已注释 |
| 6 | 历史数据接口缺失 | `BatteryDataEntity` 相关 API 未实现 |
| 7 | 版本详情页空实现 | `VersionDataEntity` mock 数据未提供 |
| 8 | 部分 widget 有 `if (false)` 死代码 | `battery_cluster_detail_panel.dart` 第 946 行，有意禁用单位显示样式 |
| 9 | mock 数据静态常量 | 所有 mock 数据为 `const`，不支持运行时动态生成 |
| 10 | iOS 原生插件未验证 | `smart_ble_link` iOS 端 JY_BlueSDK 未在本仓库中提供 |
