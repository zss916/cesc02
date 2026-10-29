import 'package:cesc01/core/network/base/interceptor/net_status.dart';

///
dynamic toBaseResult({dynamic data}) => {
  "code": NetStatus.ok,
  "data": data,
  "message": "Mock",
};

dynamic toBaseListPage({dynamic data}) => {
  "total": 0,
  "totalPage": 0,
  "pageNum": 0,
  "pageSize": 0,
  "hasNext": true,
  "list": data,
};

///返回登录数据
const loginResult = {
  "token": "",
  "tokenHeader": "",
  "userId": "0",
  "username": "Admin",
  "displayName": "Admin",
  "personnelType": "",
  "dataScopeType": "",
  "roles": [""],
  "permissions": [""],
};

///用户信息返回数据 —— 对应 AuthEntity
///路由：/auth/me → AdminAPI.getUserInfo
///MineView 字段访问：
///   showDisplayName（→ nickname）、personnelType（→ .type 扩展展示岗位）、
///   organizationName、siteCount
const authResult = {
  "token": "mock-jwt-token-mock-jwt-token-mock-jwt-token-abc123",
  "tokenHeader": "Authorization",
  "userId": "U-10086",
  "username": "admin",
  "nickname": "运维主管 · 张三",
  "userPhone": "+39 333 1234567",
  "email": "zhangsan@hifly-tech.com",
  "organizationName": "HIFLY 欧洲运维中心",
  "personnelType": "INTERNAL_OPS",
  "dataScopeType": "ALL",
  "roles": ["ADMIN", "OPS_MANAGER"],
  "permissions": [
    "dashboard:view",
    "sites:view",
    "alarms:view",
    "alarms:handle",
    "battery:view",
    "battery:diagnose",
    "firmware:upgrade",
  ],
  "assignedSiteIds": ["site-001", "site-002", "site-003", "site-004", "site-005"],
  "siteCount": 5,
};

///首页返回数据 —— 对应 DashboardEntity
///summary 字段全部为 String 类型（DashboardSummary）
///sites 字段（非旧 attentionSites）对应 DashboardAttentionSites
const homeResult = {
  "summary": {
    "connectedSiteCount": "5",
    "totalStackCount": "12",
    "onlineStackCount": "10",
    "totalClusterCount": "24",
    "totalSubPackCount": "264",
    "alarmClusterCount": "2",
  },
  "siteStatusStatistics": {
    "normalSiteCount": 3,
    "warningSiteCount": 1,
    "delayedSiteCount": 1,
    "offlineSiteCount": 0,
  },
  "sites": [
    {
      "siteId": "site-001",
      "siteName": "巴塞罗那阳光公寓",
      "countryRegion": "西班牙 · 加泰罗尼亚",
      "commStatus": "ONLINE",
      "stackCount": 3,
      "clusterCount": 6,
      "packCount": 66,
    },
    {
      "siteId": "site-002",
      "siteName": "米兰绿色社区",
      "countryRegion": "意大利 · 伦巴第",
      "commStatus": "ALARM",
      "stackCount": 2,
      "clusterCount": 4,
      "packCount": 44,
    },
    {
      "siteId": "site-003",
      "siteName": "阿姆斯特丹运河住宅",
      "countryRegion": "荷兰 · 北荷兰",
      "commStatus": "ONLINE",
      "stackCount": 4,
      "clusterCount": 8,
      "packCount": 88,
    },
    {
      "siteId": "site-004",
      "siteName": "柏林湖畔别墅",
      "countryRegion": "德国 · 柏林",
      "commStatus": "DELAYED",
      "stackCount": 2,
      "clusterCount": 4,
      "packCount": 44,
    },
    {
      "siteId": "site-005",
      "siteName": "苏黎世山景住宅",
      "countryRegion": "瑞士 · 苏黎世",
      "commStatus": "ONLINE",
      "stackCount": 1,
      "clusterCount": 2,
      "packCount": 22,
    },
  ],
  "refreshedAt": 1761672000000,
};

///实时运行 —— 对应 RealtimeEntity
///解析路径：result["data"]["page"]["list"] → List(RealtimePageList)
///SiteCard 字段访问：
///   showSiteName/siteName、showSiteAddress/countryRegion、
///   showRuntimeStatus/commStatus、runtimeStatusVisibility（commStatus != null）、
///   packRate（→ totalStackCount + totalClusterCount）、
///   showSocRange（→ soc.display）、showMaxTemp（→ maxTemperature.display）、
///   showLastDataTime（→ lastDataTime）、alarmCount（→ activeAlarmCount）
const realTimeResult = {
  "summary": {
    "normalSiteCount": 3,
    "visibleSiteCount": 5,
    "onlinePackCount": 264,
    "totalPackCount": 264,
    "activeAlarmCount": 2,
    "abnormalPackCount": 0,
  },
  "page": {
    "total": 5,
    "totalPage": 1,
    "pageNum": 1,
    "pageSize": 10,
    "hasNext": false,
    "list": [
      {
        "siteId": "site-001",
        "siteName": "巴塞罗那阳光公寓",
        "countryRegion": "西班牙 · 加泰罗尼亚",
        "runStatus": "CHARGING",
        "commStatus": "ONLINE",
        "totalStackCount": 3,
        "totalClusterCount": 6,
        "activeAlarmCount": 0,
        "soc": {"min": 72, "max": 89, "unit": "%", "display": "72-89%"},
        "soh": {"min": 97, "max": 99, "unit": "%", "display": "97-99%"},
        "totalVoltage": {"min": 405, "max": 410, "unit": "V", "display": "405-410V"},
        "totalCurrent": {"min": 5, "max": 12, "unit": "A", "display": "5-12A"},
        "maxTemperature": {"min": 24, "max": 31, "unit": "°C", "display": "24-31°C"},
        "chargeDisabled": false,
        "dischargeDisabled": false,
        "lastDataTime": "2026-10-28 14:36:17",
      },
      {
        "siteId": "site-002",
        "siteName": "米兰绿色社区",
        "countryRegion": "意大利 · 伦巴第",
        "runStatus": "ALARM",
        "commStatus": "ALARM",
        "totalStackCount": 2,
        "totalClusterCount": 4,
        "activeAlarmCount": 2,
        "soc": {"min": 45, "max": 68, "unit": "%", "display": "45-68%"},
        "soh": {"min": 95, "max": 98, "unit": "%", "display": "95-98%"},
        "totalVoltage": {"min": 398, "max": 408, "unit": "V", "display": "398-408V"},
        "totalCurrent": {"min": 3, "max": 8, "unit": "A", "display": "3-8A"},
        "maxTemperature": {"min": 28, "max": 38, "unit": "°C", "display": "28-38°C"},
        "chargeDisabled": true,
        "dischargeDisabled": false,
        "lastDataTime": "2026-10-28 14:35:02",
      },
      {
        "siteId": "site-003",
        "siteName": "阿姆斯特丹运河住宅",
        "countryRegion": "荷兰 · 北荷兰",
        "runStatus": "DISCHARGING",
        "commStatus": "ONLINE",
        "totalStackCount": 4,
        "totalClusterCount": 8,
        "activeAlarmCount": 0,
        "soc": {"min": 55, "max": 82, "unit": "%", "display": "55-82%"},
        "soh": {"min": 96, "max": 99, "unit": "%", "display": "96-99%"},
        "totalVoltage": {"min": 402, "max": 411, "unit": "V", "display": "402-411V"},
        "totalCurrent": {"min": 8, "max": 15, "unit": "A", "display": "8-15A"},
        "maxTemperature": {"min": 22, "max": 29, "unit": "°C", "display": "22-29°C"},
        "chargeDisabled": false,
        "dischargeDisabled": false,
        "lastDataTime": "2026-10-28 14:36:45",
      },
      {
        "siteId": "site-004",
        "siteName": "柏林湖畔别墅",
        "countryRegion": "德国 · 柏林",
        "runStatus": "STANDBY",
        "commStatus": "DELAYED",
        "totalStackCount": 2,
        "totalClusterCount": 4,
        "activeAlarmCount": 0,
        "soc": {"min": 60, "max": 78, "unit": "%", "display": "60-78%"},
        "soh": {"min": 94, "max": 97, "unit": "%", "display": "94-97%"},
        "totalVoltage": {"min": 400, "max": 407, "unit": "V", "display": "400-407V"},
        "totalCurrent": {"min": 0, "max": 2, "unit": "A", "display": "0-2A"},
        "maxTemperature": {"min": 20, "max": 26, "unit": "°C", "display": "20-26°C"},
        "chargeDisabled": false,
        "dischargeDisabled": false,
        "lastDataTime": "2026-10-28 13:58:11",
      },
      {
        "siteId": "site-005",
        "siteName": "苏黎世山景住宅",
        "countryRegion": "瑞士 · 苏黎世",
        "runStatus": "SLEEP",
        "commStatus": "OFFLINE",
        "totalStackCount": 1,
        "totalClusterCount": 2,
        "activeAlarmCount": 0,
        "soc": {"min": 30, "max": 42, "unit": "%", "display": "30-42%"},
        "soh": {"min": 98, "max": 100, "unit": "%", "display": "98-100%"},
        "totalVoltage": {"min": 406, "max": 412, "unit": "V", "display": "406-412V"},
        "totalCurrent": {"min": 0, "max": 1, "unit": "A", "display": "0-1A"},
        "maxTemperature": {"min": 18, "max": 24, "unit": "°C", "display": "18-24°C"},
        "chargeDisabled": false,
        "dischargeDisabled": false,
        "lastDataTime": "2026-10-27 22:15:00",
      },
    ],
  },
};

///告警列表返回数据 —— 对应 AlarmDetailEntity（堆级结构）
///解析路径：result["data"]["list"] → List(AlarmDetailEntity)
///AlertCard 字段访问：
///   showSiteName/siteName、showSiteCode/siteCode、
///   showStackName/stackName、showStackSn/stackSn、
///   alarmLevel（→ colorValue + title）、
///   alarmClusterCount、showClusterNos（→ clusterNos）、
///   timeDisplay（→ latestOccurredAt）、siteId、stackSn
const alarmResult = {
  "list": [
    {
      "siteId": "site-002",
      "siteName": "米兰绿色社区",
      "siteCode": "IT-MILAN-001",
      "timezone": "Europe/Rome",
      "stackSn": "HIFLY-20260615-001",
      "stackName": "米兰社区 1号堆",
      "alarmClusterCount": 2,
      "alarmLevel": 1,
      "latestOccurredAt": "2026-10-28 14:20:35",
      "clusterNos": [1, 3],
      "clusters": [
        {
          "clusterNo": 1,
          "clusterSn": "CL-HIFLY-001",
          "clusterName": "簇 1",
          "domainType": "CLUSTER",
          "alarmLevel": 1,
          "alarmName": "电芯温度过高",
          "status": "ACTIVE",
          "occurredAt": "2026-10-28 14:20:35",
          "recoveredAt": null,
          "packNo": 2,
          "cellNo": 14,
        },
        {
          "clusterNo": 3,
          "clusterSn": "CL-HIFLY-003",
          "clusterName": "簇 3",
          "domainType": "CLUSTER",
          "alarmLevel": 2,
          "alarmName": "单体电压偏高",
          "status": "ACTIVE",
          "occurredAt": "2026-10-28 14:18:12",
          "recoveredAt": null,
          "packNo": 1,
          "cellNo": 9,
        },
      ],
    },
    {
      "siteId": "site-002",
      "siteName": "米兰绿色社区",
      "siteCode": "IT-MILAN-001",
      "timezone": "Europe/Rome",
      "stackSn": "HIFLY-20260615-002",
      "stackName": "米兰社区 2号堆",
      "alarmClusterCount": 1,
      "alarmLevel": 2,
      "latestOccurredAt": "2026-10-28 13:55:00",
      "clusterNos": [2],
      "clusters": [
        {
          "clusterNo": 2,
          "clusterSn": "CL-HIFLY-002",
          "clusterName": "簇 2",
          "domainType": "CLUSTER",
          "alarmLevel": 2,
          "alarmName": "充电过流保护",
          "status": "ACTIVE",
          "occurredAt": "2026-10-28 13:55:00",
          "recoveredAt": null,
          "packNo": 3,
          "cellNo": null,
        },
      ],
    },
    {
      "siteId": "site-004",
      "siteName": "柏林湖畔别墅",
      "siteCode": "DE-BERLIN-002",
      "timezone": "Europe/Berlin",
      "stackSn": "HIFLY-20260702-001",
      "stackName": "柏林别墅 1号堆",
      "alarmClusterCount": 1,
      "alarmLevel": 3,
      "latestOccurredAt": "2026-10-28 10:30:22",
      "clusterNos": [1],
      "clusters": [
        {
          "clusterNo": 1,
          "clusterSn": "CL-HIFLY-011",
          "clusterName": "簇 1",
          "domainType": "CLUSTER",
          "alarmLevel": 3,
          "alarmName": "通信延迟告警",
          "status": "ACTIVE",
          "occurredAt": "2026-10-28 10:30:22",
          "recoveredAt": null,
          "packNo": null,
          "cellNo": null,
        },
      ],
    },
    {
      "siteId": "site-003",
      "siteName": "阿姆斯特丹运河住宅",
      "siteCode": "NL-AMS-001",
      "timezone": "Europe/Amsterdam",
      "stackSn": "HIFLY-20260620-001",
      "stackName": "运河住宅 1号堆",
      "alarmClusterCount": 1,
      "alarmLevel": 2,
      "latestOccurredAt": "2026-10-28 09:12:44",
      "clusterNos": [4],
      "clusters": [
        {
          "clusterNo": 4,
          "clusterSn": "CL-HIFLY-008",
          "clusterName": "簇 4",
          "domainType": "CLUSTER",
          "alarmLevel": 2,
          "alarmName": "Pack4 电池温度异常",
          "status": "ACTIVE",
          "occurredAt": "2026-10-28 09:12:44",
          "recoveredAt": null,
          "packNo": 4,
          "cellNo": 7,
        },
      ],
    },
  ],
};

///告警详情 —— 对应 AlarmDetailEntity（堆级结构）
///路由：/alarms/{id} → AlarmAPI.getAlarmDetail
///AlertCard 字段访问：
///   showSiteName/siteName、showSiteCode/siteCode、
///   showStackName/stackName、showStackSn/stackSn、
///   alarmLevel（→ colorValue + title）、
///   alarmClusterCount、showClusterNos（→ clusterNos）、
///   timeDisplay（→ latestOccurredAt）、siteId、stackSn
const alarmDetail1 = {
  "siteId": "site-002",
  "siteName": "米兰绿色社区",
  "siteCode": "IT-MILAN-001",
  "timezone": "Europe/Rome",
  "stackSn": "HIFLY-20260615-001",
  "stackName": "米兰社区 1号堆",
  "alarmClusterCount": 2,
  "alarmLevel": 1,
  "latestOccurredAt": "2026-10-28 14:20:35",
  "clusterNos": [1, 3],
  "clusters": [
    {
      "clusterNo": 1,
      "clusterSn": "CL-HIFLY-001",
      "clusterName": "簇 1",
      "domainType": "CLUSTER",
      "alarmLevel": 1,
      "alarmName": "电芯温度过高",
      "status": "ACTIVE",
      "occurredAt": "2026-10-28 14:20:35",
      "recoveredAt": null,
      "packNo": 2,
      "cellNo": 14,
    },
    {
      "clusterNo": 3,
      "clusterSn": "CL-HIFLY-003",
      "clusterName": "簇 3",
      "domainType": "CLUSTER",
      "alarmLevel": 2,
      "alarmName": "单体电压偏高",
      "status": "ACTIVE",
      "occurredAt": "2026-10-28 14:18:12",
      "recoveredAt": null,
      "packNo": 1,
      "cellNo": 9,
    },
  ],
};

const alarmDetail2 = {
  "siteId": "site-002",
  "siteName": "米兰绿色社区",
  "siteCode": "IT-MILAN-001",
  "timezone": "Europe/Rome",
  "stackSn": "HIFLY-20260615-002",
  "stackName": "米兰社区 2号堆",
  "alarmClusterCount": 1,
  "alarmLevel": 2,
  "latestOccurredAt": "2026-10-28 13:55:00",
  "clusterNos": [2],
  "clusters": [
    {
      "clusterNo": 2,
      "clusterSn": "CL-HIFLY-002",
      "clusterName": "簇 2",
      "domainType": "CLUSTER",
      "alarmLevel": 2,
      "alarmName": "充电过流保护",
      "status": "ACTIVE",
      "occurredAt": "2026-10-28 13:55:00",
      "recoveredAt": null,
      "packNo": 3,
      "cellNo": null,
    },
  ],
};

const alarmDetail3 = {
  "siteId": "site-004",
  "siteName": "柏林湖畔别墅",
  "siteCode": "DE-BERLIN-002",
  "timezone": "Europe/Berlin",
  "stackSn": "HIFLY-20260702-001",
  "stackName": "柏林别墅 1号堆",
  "alarmClusterCount": 1,
  "alarmLevel": 3,
  "latestOccurredAt": "2026-10-28 10:30:22",
  "clusterNos": [1],
  "clusters": [
    {
      "clusterNo": 1,
      "clusterSn": "CL-HIFLY-011",
      "clusterName": "簇 1",
      "domainType": "CLUSTER",
      "alarmLevel": 3,
      "alarmName": "通信延迟告警",
      "status": "ACTIVE",
      "occurredAt": "2026-10-28 10:30:22",
      "recoveredAt": null,
      "packNo": null,
      "cellNo": null,
    },
  ],
};

///堆告警详情 —— 对应 StackAlarmDetailEntity
///路由：/alarms/stack-detail → AlarmAPI.getStackAlarmDetail
///StackAlarmDetailPage 字段访问：
///   siteId、showSiteName/siteName、showSiteCode/siteCode、
///   showStackName/stackName、showStackSn/stackSn、
///   alarmClusterCount、alarmCount、
///   showTimezone/timezone、showClusters/clusters
///BatteryClusterAlarmCard 对 clusters 项访问：
///   clusterNo（分组键）、showClusterName/showClusterSn、
///   alarmCount（簇下告警条数）、showAlarmName、showAlarmLevel（→ colorValue + title）、
///   showOccurredAt、showRecoveredAt、status
const stackAlarmDetail = {
  "siteId": "site-002",
  "siteName": "米兰绿色社区",
  "siteCode": "IT-MILAN-001",
  "stackSn": "HIFLY-20260615-001",
  "stackName": "米兰社区 1号堆",
  "timezone": "Europe/Rome",
  "alarmClusterCount": 2,
  "alarmCount": 3,
  "alarmLevel": 1,
  "latestOccurredAt": "2026-10-28 14:20:35",
  "clusterNos": [1, 3],
  "clusters": [
    {
      "clusterNo": 1,
      "clusterSn": "CL-HIFLY-001",
      "clusterName": "簇 1",
      "domainType": "CLUSTER",
      "alarmCount": 2,
      "alarmLevel": 1,
      "alarmName": "电芯温度过高",
      "status": "ACTIVE",
      "occurredAt": "2026-10-28 14:20:35",
      "recoveredAt": null,
      "packNo": 2,
      "cellNo": 14,
    },
    {
      "clusterNo": 1,
      "clusterSn": "CL-HIFLY-001",
      "clusterName": "簇 1",
      "domainType": "CLUSTER",
      "alarmCount": 2,
      "alarmLevel": 1,
      "alarmName": "电芯温度过高 (Pack1-13)",
      "status": "ACTIVE",
      "occurredAt": "2026-10-28 14:19:50",
      "recoveredAt": null,
      "packNo": 1,
      "cellNo": 13,
    },
    {
      "clusterNo": 3,
      "clusterSn": "CL-HIFLY-003",
      "clusterName": "簇 3",
      "domainType": "CLUSTER",
      "alarmCount": 1,
      "alarmLevel": 2,
      "alarmName": "单体电压偏高",
      "status": "ACTIVE",
      "occurredAt": "2026-10-28 14:18:12",
      "recoveredAt": null,
      "packNo": 1,
      "cellNo": 9,
    },
  ],
};

///单站详情 —— 对应 SiteOverViewDataEntity
///路由：GET /sites/{siteId}/overview → SiteAPI.getOverView
///解析路径：result["data"] → SiteOverViewDataEntity
///StationView 字段访问：
///   showSiteName/siteName、showSubTitle（countryRegion · address）、
///   showCommStatus/commStatus、showRuntimeStatus/runStatus、
///   showTotalStackCount/totalStackCount、showOnlineStackCount/onlineStackCount、
///   showTotalClusterCount/totalClusterCount、showTotalSubPackCount/totalSubPackCount、
///   showAlarmClusterCount/alarmClusterCount、alarmStackCount、
///   stackStatusDistribution{online,alarm,delayed,offline}、
///   showStacks/stacks[] → SiteOverViewDataStacks
///SiteOverViewDataStacks 字段访问：
///   showStackName/stackName、showStackSn/stackSn、showCommStatus/commStatus、
///   showFirmwareVersion/firmwareVersion、showSysMode/sysMode、
///   showClusterCount/clusterCount、showPackCount/packCount、
///   alarmClusterCount、soc、soh、totalVoltage、totalCurrent、
///   maxTemperature、maxVoltageDiff、showLastDataTime/lastDataTime
const singleSiteDetail = {
  "siteId": 201,
  "siteName": "巴塞罗那阳光公寓",
  "countryRegion": "西班牙 · 加泰罗尼亚",
  "address": "Carrer de Balmes 123, 08007 Barcelona",
  "commStatus": "ALARM",
  "runStatus": "ALARM",
  "totalStackCount": 2,
  "onlineStackCount": 1,
  "totalClusterCount": 6,
  "totalSubPackCount": 66,
  "alarmClusterCount": 2,
  "alarmStackCount": 1,
  "stackStatusDistribution": {
    "online": 1,
    "alarm": 1,
    "delayed": 0,
    "offline": 0,
  },
  "stacks": [
    {
      "stackId": "101",
      "stackName": "阳光公寓 1号堆",
      "stackSn": "HIFLY-20260610-001",
      "firmwareVersion": "v2.2.1",
      "sysMode": 2,
      "clusterCount": 3,
      "packCount": 33,
      "commStatus": "ALARM",
      "runStatus": "ALARM",
      "alarmClusterCount": 2,
      "soc": "72%",
      "soh": "99%",
      "totalVoltage": "408.2 V",
      "totalCurrent": "9.4 A",
      "maxTemperature": "28.3 °C",
      "maxVoltageDiff": "36 mV",
      "lastDataTime": "2026-10-28 14:36:17",
    },
    {
      "stackId": "102",
      "stackName": "阳光公寓 2号堆",
      "stackSn": "HIFLY-20260610-002",
      "firmwareVersion": "v2.2.1",
      "sysMode": 2,
      "clusterCount": 3,
      "packCount": 33,
      "commStatus": "ONLINE",
      "runStatus": "DISCHARGING",
      "alarmClusterCount": 0,
      "soc": "65%",
      "soh": "98%",
      "totalVoltage": "405.5 V",
      "totalCurrent": "12.1 A",
      "maxTemperature": "26.8 °C",
      "maxVoltageDiff": "28 mV",
      "lastDataTime": "2026-10-28 14:36:45",
    },
  ],
};

///堆簇下拉选项 —— 对应 OptionsEntity
///路由：GET /sites/{siteId}/options → SiteAPI.getOptions
///解析路径：result["data"] → OptionsEntity
///StationLogic.getOptionsApi 字段访问：
///   siteId、siteCode、name、label、showStacks/stacks[] → OptionsStacks
///OptionsStacks 字段访问：
///   showStackName/stackName、showStackSn/stackSn、commStatus、
///   showCommStatus、clusterCount（→ clusters.length）、
///   clusters[] → OptionsStacksClusters
///OptionsStacksClusters 字段访问：
///   showClusterName/clusterName、showClusterSn/clusterSn、
///   showPackCount/packCount、showCommStatus/commStatus
const stackAndClusterOptions = {
  "siteId": 201,
  "siteCode": "ES-BCN-001",
  "name": "巴塞罗那阳光公寓",
  "label": "ES-BCN-001",
  "stacks": [
    {
      "stackId": "101",
      "stackSn": "HIFLY-20260610-001",
      "stackName": "阳光公寓 1号堆",
      "label": "STACK-001",
      "modelName": "PowerNest 10",
      "commStatus": "ALARM",
      "clusters": [
        {
          "clusterId": "c-1",
          "clusterNo": 1,
          "clusterSn": "CL-HIFLY-001",
          "clusterName": "簇 1",
          "packCount": 11,
          "commStatus": "ALARM",
        },
        {
          "clusterId": "c-2",
          "clusterNo": 2,
          "clusterSn": "CL-HIFLY-002",
          "clusterName": "簇 2",
          "packCount": 11,
          "commStatus": "ONLINE",
        },
        {
          "clusterId": "c-3",
          "clusterNo": 3,
          "clusterSn": "CL-HIFLY-003",
          "clusterName": "簇 3",
          "packCount": 11,
          "commStatus": "ALARM",
        },
      ],
    },
    {
      "stackId": "102",
      "stackSn": "HIFLY-20260610-002",
      "stackName": "阳光公寓 2号堆",
      "label": "STACK-002",
      "modelName": "PowerNest 10",
      "commStatus": "ONLINE",
      "clusters": [
        {
          "clusterId": "c-4",
          "clusterNo": 1,
          "clusterSn": "CL-HIFLY-004",
          "clusterName": "簇 1",
          "packCount": 11,
          "commStatus": "ONLINE",
        },
        {
          "clusterId": "c-5",
          "clusterNo": 2,
          "clusterSn": "CL-HIFLY-005",
          "clusterName": "簇 2",
          "packCount": 11,
          "commStatus": "ONLINE",
        },
        {
          "clusterId": "c-6",
          "clusterNo": 3,
          "clusterSn": "CL-HIFLY-006",
          "clusterName": "簇 3",
          "packCount": 11,
          "commStatus": "ONLINE",
        },
      ],
    },
  ],
};

///堆簇详情 —— 对应 StackAndClusterEntity
///路由：GET /battery-stacks/{stackId}/data?clusterId=xxx → SiteAPI.getStackAndCluster
///解析路径：result["data"] → StackAndClusterEntity
///StationLogic.fetchStackAndClusterApi 字段访问：
///   scope、stackId、clusterId、stackSn、clusterSn、stackName、clusterName、
///   firmwareVersion、sysMode、commStatus、clusterCount、packCount、
///   alarmClusterCount、lastDataTime、timezone、
///   summary、runningProtection、energy、trend、extrema、diagnosis、
///   alarmInfo、systemInfo、clusters[]
///StackMetricsGrid 字段访问：summary.showSoc/showSoh/showTotalVoltage/showTotalCurrent/showMaxTemperature/showMaxVoltageDiff
///StackRunningWidget 字段访问：runningProtection.showRunStatus/showCycles/showMaxChargeCurrent/showMaxDischargeCurrent
///StackElectricity 字段访问：energy.showRemainingKwh/showCanChargeKwh/showCanDischargeKwh/showTotalChargedKwh/showTotalDischargedKwh/showMaxTemperatureDiff
///BatteryTrendChartCard 字段访问：trend.points[].timestamp/soc/voltage/current
///BatteryClusterDetailPanel 字段访问：clusters[].clusterNo/clusterSn/clusterName/summary/soc/soh/totalVoltage/totalCurrent
const stackAndCluster = {
  "scope": "STACK",
  "stackId": 101,
  "clusterId": null,
  "stackSn": "HIFLY-20260610-001",
  "clusterSn": null,
  "stackName": "阳光公寓 1号堆",
  "clusterName": null,
  "firmwareVersion": "v2.2.1",
  "sysMode": 2,
  "commStatus": "ALARM",
  "clusterCount": 3,
  "packCount": 33,
  "alarmClusterCount": 2,
  "lastDataTime": "2026-10-28 14:36:17",
  "timezone": "Europe/Madrid",
  "summary": {
    "soc": "72%",
    "soh": "99%",
    "totalVoltage": "408.2 V",
    "totalCurrent": "9.4 A",
    "maxTemperature": "28.3 °C",
    "maxVoltageDiff": "36 mV",
  },
  "runningProtection": {
    "runStatus": "CHARGING",
    "chargeDischargePermission": "ALLOWED",
    "maxChargeCurrent": "16 A",
    "maxDischargeCurrent": "16 A",
    "current1": "8.4 A",
    "current2": "8.2 A",
    "cycles": 116,
    "heaterStatus": 0,
  },
  "energy": {
    "remainingKwh": "28.5",
    "canChargeKwh": "24.2",
    "canDischargeKwh": "77.0",
    "totalChargedKwh": "12845.6",
    "totalDischargedKwh": "12561.3",
    "maxTemperatureDiff": "8.6 °C",
  },
  "trend": {
    "intervalMinutes": 15,
    "expectedPoints": 24,
    "timezone": "Europe/Madrid",
    "points": [
      {"timestamp": 1761588000, "soc": 45.0, "voltage": 402.5, "current": 3.2},
      {"timestamp": 1761588900, "soc": 48.0, "voltage": 403.1, "current": 5.1},
      {"timestamp": 1761589800, "soc": 52.0, "voltage": 404.0, "current": 7.8},
      {"timestamp": 1761590700, "soc": 56.0, "voltage": 404.8, "current": 9.4},
      {"timestamp": 1761591600, "soc": 60.0, "voltage": 405.5, "current": 10.2},
      {"timestamp": 1761592500, "soc": 63.0, "voltage": 406.2, "current": 8.6},
      {"timestamp": 1761593400, "soc": 66.0, "voltage": 406.8, "current": 9.1},
      {"timestamp": 1761594300, "soc": 68.0, "voltage": 407.4, "current": 9.3},
      {"timestamp": 1761595200, "soc": 70.0, "voltage": 407.8, "current": 9.0},
      {"timestamp": 1761596100, "soc": 72.0, "voltage": 408.2, "current": 9.4},
    ],
  },
  "extrema": {
    "maxCellVoltage": {"value": "4.096", "clusterId": 1, "packNo": 2, "cellNo": 9},
    "minCellVoltage": {"value": "4.060", "clusterId": 1, "packNo": 3, "cellNo": 7},
    "maxTemperature": {"value": "28.3", "clusterId": 1, "packNo": 2, "probeNo": 3},
    "minTemperature": {"value": "22.1", "clusterId": 2, "packNo": 1, "probeNo": 1},
  },
  "diagnosis": {
    "packs": [
      {
        "packNo": 1,
        "cellCount": 16,
        "cellTempCount": 4,
        "soh": "99%",
        "environmentTemperature": "24.5",
        "heaterTemperature": "23.8",
        "balance": 1,
        "balancingCells": [9, 11],
        "cellVoltages": [
          {"cellNo": 1, "voltageMv": 4089.0, "voltageV": 4.089, "isMax": false, "isMin": false, "isBalancing": false},
          {"cellNo": 2, "voltageMv": 4092.0, "voltageV": 4.092, "isMax": false, "isMin": false, "isBalancing": false},
          {"cellNo": 9, "voltageMv": 4096.0, "voltageV": 4.096, "isMax": true, "isMin": false, "isBalancing": true},
          {"cellNo": 11, "voltageMv": 4090.0, "voltageV": 4.090, "isMax": false, "isMin": false, "isBalancing": true},
          {"cellNo": 14, "voltageMv": 4078.0, "voltageV": 4.078, "isMax": false, "isMin": true, "isBalancing": false},
        ],
        "cellTemperatures": [
          {"probeNo": 1, "tempRawDc": 2450, "tempC": 24.5, "isMax": false, "isMin": false},
          {"probeNo": 3, "tempRawDc": 2830, "tempC": 28.3, "isMax": true, "isMin": false},
          {"probeNo": 4, "tempRawDc": 2380, "tempC": 23.8, "isMax": false, "isMin": true},
        ],
        "mosTemperatures": [
          {"no": 1, "tempC": 29.9},
          {"no": 2, "tempC": 29.5},
        ],
      },
      {
        "packNo": 2,
        "cellCount": 16,
        "cellTempCount": 4,
        "soh": "98%",
        "environmentTemperature": "25.2",
        "heaterTemperature": "24.1",
        "balance": 0,
        "balancingCells": [],
        "cellVoltages": [
          {"cellNo": 5, "voltageMv": 4082.0, "voltageV": 4.082, "isMax": false, "isMin": false, "isBalancing": false},
          {"cellNo": 7, "voltageMv": 4060.0, "voltageV": 4.060, "isMax": false, "isMin": true, "isBalancing": false},
        ],
        "cellTemperatures": [
          {"probeNo": 2, "tempRawDc": 2520, "tempC": 25.2, "isMax": false, "isMin": false},
        ],
        "mosTemperatures": [
          {"no": 1, "tempC": 28.7},
        ],
      },
    ],
  },
  "alarmInfo": {
    "status": "ACTIVE",
    "siteId": "site-001",
    "siteName": "巴塞罗那阳光公寓",
    "domainType": "CLUSTER",
    "stackSn": "HIFLY-20260610-001",
    "stackName": "阳光公寓 1号堆",
    "clusterSn": "CL-HIFLY-001",
    "clusterName": "簇 1",
    "alarmLevel": 1,
    "packNo": 2,
    "cellNo": 14,
  },
  "systemInfo": {
    "stackSn": "HIFLY-20260610-001",
    "clusterSn": "CL-HIFLY-001",
    "clusterNo": 1,
    "softwareVersion": "BMS 4.2.1",
    "hardwareVersion": "HW-1.0",
    "bootVersion": "BOOT-0.6.1",
    "designMah": 100000,
    "designCapacity": "10 kWh",
    "packCount": 11,
    "packCellCount": 16,
    "packTempCount": 4,
    "sysMode": 2,
    "accessMode": 1,
  },
  "clusters": [
    {
      "clusterId": "c-1",
      "clusterSn": "CL-HIFLY-001",
      "clusterNo": 1,
      "clusterName": "簇 1",
      "packCount": 11,
      "commStatus": "ALARM",
      "soc": "72%",
      "soh": "99%",
      "totalVoltage": "408.2 V",
      "totalCurrent": "9.4 A",
      "maxTemperature": "28.3 °C",
      "maxVoltageDiff": "36 mV",
      "lastDataTime": "2026-10-28 14:36:17",
    },
    {
      "clusterId": "c-2",
      "clusterSn": "CL-HIFLY-002",
      "clusterNo": 2,
      "clusterName": "簇 2",
      "packCount": 11,
      "commStatus": "ONLINE",
      "soc": "68%",
      "soh": "98%",
      "totalVoltage": "405.5 V",
      "totalCurrent": "10.1 A",
      "maxTemperature": "25.6 °C",
      "maxVoltageDiff": "22 mV",
      "lastDataTime": "2026-10-28 14:36:17",
    },
    {
      "clusterId": "c-3",
      "clusterSn": "CL-HIFLY-003",
      "clusterNo": 3,
      "clusterName": "簇 3",
      "packCount": 11,
      "commStatus": "ALARM",
      "soc": "70%",
      "soh": "97%",
      "totalVoltage": "407.1 V",
      "totalCurrent": "8.8 A",
      "maxTemperature": "30.1 °C",
      "maxVoltageDiff": "41 mV",
      "lastDataTime": "2026-10-28 14:36:17",
    },
  ],
};

///站点列表 —— 对应 List(SiteItemEntity)
///路由：/sites/options → SiteAPI.getSiteList
///解析路径：result["data"] → List(SiteItemEntity)（数组本身，非分页对象）
///AlarmFilterSite 字段访问：
///   siteId（筛选选中态判断）、showSiteCode/siteCode、showSiteName/name、
///   showStacks/stacks（子堆列表，长度显示 X堆）
///StackItemEntity 子项访问：stackSn（筛选选中态判断）、showStackName/stackName
const siteList = [
  {
    "siteId": "site-001",
    "siteCode": "ES-BCN-001",
    "name": "巴塞罗那阳光公寓",
    "label": "ES-BCN-001",
    "stacks": [
      {
        "stackId": 101,
        "stackSn": "HIFLY-20260610-001",
        "stackName": "阳光公寓 1号堆",
        "label": "STACK-001",
        "modelName": "PowerNest 10",
        "firmwareVersion": "v2.2.1",
        "clusterCount": 3,
        "sysMode": 2,
        "commStatus": "ONLINE",
        "runStatus": "CHARGING",
        "siteId": 201,
        "bound": true,
      },
      {
        "stackId": 102,
        "stackSn": "HIFLY-20260610-002",
        "stackName": "阳光公寓 2号堆",
        "label": "STACK-002",
        "modelName": "PowerNest 10",
        "firmwareVersion": "v2.2.1",
        "clusterCount": 3,
        "sysMode": 2,
        "commStatus": "ONLINE",
        "runStatus": "DISCHARGING",
        "siteId": 201,
        "bound": true,
      },
    ],
  },
  {
    "siteId": "site-002",
    "siteCode": "IT-MILAN-001",
    "name": "米兰绿色社区",
    "label": "IT-MILAN-001",
    "stacks": [
      {
        "stackId": 103,
        "stackSn": "HIFLY-20260615-001",
        "stackName": "米兰社区 1号堆",
        "label": "STACK-001",
        "modelName": "PowerNest 10",
        "firmwareVersion": "v2.2.1",
        "clusterCount": 3,
        "sysMode": 2,
        "commStatus": "ALARM",
        "runStatus": "ALARM",
        "siteId": 202,
        "bound": true,
      },
      {
        "stackId": 104,
        "stackSn": "HIFLY-20260615-002",
        "stackName": "米兰社区 2号堆",
        "label": "STACK-002",
        "modelName": "PowerNest 10",
        "firmwareVersion": "v2.1.8",
        "clusterCount": 2,
        "sysMode": 2,
        "commStatus": "ONLINE",
        "runStatus": "STANDBY",
        "siteId": 202,
        "bound": true,
      },
    ],
  },
  {
    "siteId": "site-003",
    "siteCode": "NL-AMS-001",
    "name": "阿姆斯特丹运河住宅",
    "label": "NL-AMS-001",
    "stacks": [
      {
        "stackId": 105,
        "stackSn": "HIFLY-20260620-001",
        "stackName": "运河住宅 1号堆",
        "label": "STACK-001",
        "modelName": "PowerNest 10",
        "firmwareVersion": "v2.2.0",
        "clusterCount": 4,
        "sysMode": 2,
        "commStatus": "ONLINE",
        "runStatus": "DISCHARGING",
        "siteId": 203,
        "bound": true,
      },
    ],
  },
  {
    "siteId": "site-004",
    "siteCode": "DE-BERLIN-002",
    "name": "柏林湖畔别墅",
    "label": "DE-BERLIN-002",
    "stacks": [
      {
        "stackId": 106,
        "stackSn": "HIFLY-20260702-001",
        "stackName": "柏林别墅 1号堆",
        "label": "STACK-001",
        "modelName": "PowerNest 10",
        "firmwareVersion": "v2.1.5",
        "clusterCount": 2,
        "sysMode": 2,
        "commStatus": "DELAYED",
        "runStatus": "SLEEP",
        "siteId": 204,
        "bound": true,
      },
    ],
  },
  {
    "siteId": "site-005",
    "siteCode": "CH-ZRH-001",
    "name": "苏黎世山景住宅",
    "label": "CH-ZRH-001",
    "stacks": [
      {
        "stackId": 107,
        "stackSn": "HIFLY-20260710-001",
        "stackName": "山景住宅 1号堆",
        "label": "STACK-001",
        "modelName": "PowerNest 10",
        "firmwareVersion": "v2.2.1",
        "clusterCount": 2,
        "sysMode": 2,
        "commStatus": "ONLINE",
        "runStatus": "SELF_CHECK",
        "siteId": 205,
        "bound": true,
      },
    ],
  },
];

///电池包详情
const batteryCell = {
  "packId": 0,
  "packName": "Battery-A11",
  "modelName": "PowerNest 10",
  "sn": "BP202606101",
  "commStatus": "ONLINE",
  "runStatus": "ALARM",
  "statusDesc": "string",
  "reportTime": "string",
  "dataValidDesc": "string",
  "keyMetrics": {
    "core": {
      "runStatus": '充电',
      "soc": "76",
      "soh": "99",
      "totalVoltage": "407.8",
      "totalCurrent": "9.4",
      "remainingCapacity": "70",
      "maxTemperature": "28.3",
      "maxVoltageDiff": "36",
      "chargeDischargePermission": "string",
      "maxChargeCurrent": "",
      "maxDischargeCurrent": "",
      "alarmCount": 0,
      "alarmCountDesc": "string",
    },
    "extrema": {
      "maxCellVoltage": "4.096",
      "maxCellVoltagePosition": "1-9",
      "minCellVoltage": "4.060",
      "minCellVoltagePosition": "1-11",
      "maxTempExtrema": "28.3",
      "maxTempPosition": "string",
      "minTempExtrema": "26.2",
      "minTempPosition": "string",
      "maxTempDiff": "string",
      "maxTempDiffPosition": "string",
    },
    "capacity": {
      "canChargeCapacity": "24",
      "canDischargeCapacity": "77",
      "totalChargedEnergy": "string",
      "totalDischargedEnergy": "string",
      "cycles": "116",
      "heaterStatusDesc": "string",
      "balanceStatusDesc": "string",
      "balancingPacks": [
        {
          "packIdx": 0,
          "packLabel": "string",
          "cells": [0],
        },
      ],
      "environmentTemperature": "string",
    },
  },
  "advancedDiagnosis": {
    "current1": "8.4",
    "current2": "8.2",
    "mosMaxTemperature": "29.9",
    "heaterTemperature": "26.6",
    "packCount": 0,
    "packs": [
      {
        "packIdx": 0,
        "packLabel": "Pack1",
        "cellPositionPrefix": "string",
        "cellCountDesc": "string",
        "cellTempCountDesc": "string",
        "cellCount": 0,
        "cellTempCount": 0,
        "packDesignCapacity": "string",
        "cellVoltages": [
          {
            "cellNo": 0,
            "positionLabel": "1-1",
            "voltageMv": 0,
            "voltageV": 0,
            "isMax": true,
            "isMin": true,
            "isBalancing": true,
          },
        ],
        "cellTemperatures": [
          {
            "probeNo": 0,
            "positionLabel": "Pack1 探头1",
            "tempRawDc": 0,
            "tempC": 0,
            "isMax": true,
            "isMin": true,
          },
        ],
        "mosTemperatures": [
          {"no": 0, "positionLabel": "Pack1 探头1", "tempC": 0},
        ],
      },
    ],
  },
  "systemInfo": {
    "bmsFirmware": "BMS 4.2.1",
    "softwareVersion": "1.1.0",
    "hardwareVersion": "HW-1.0",
    "bootVersion": "BOOT-0.6.1",
    "designCapacity": "100",
    "packCount": 11,
    "cellCount": 16,
    "cellTempCount": 0,
    "deviceSn": "string",
    "deviceModel": "string",
    "platformReceiveTime": "14:36:17",
    "dataValidDesc": "string",
  },
};

///电池列表
const batteryList = [
  {
    "id": 0,
    "sn": "123456",
    "packIdx": 0,
    "packName": "pck123456",
    "modelName": "model12345",
    "siteId": 0,
    "siteName": "巴萨罗那阳光公寓",
    "commStatus": "ALARM",
    "runStatus": "SELF_CHECK",
    "hasAlarm": true,
    "soc": 0,
    "soh": 0,
    "totalVoltage": "100 V",
    "totalCurrent": "20 Ah",
    "maxTemperature": "30 °C",
    "alarmCount": 1,
    "firmwareVersion": "0.0.0.1",
    "lastDataTime": "2026-10-19",
  },
];

///站点
const createAndBindSite = {
  "siteId": "1001",
  "siteCode": "1002",
  "name": "xxxx",
  "countryRegion": "xxxx2",
  "detailAddress": "xxxxx3",
  "timezone": "2026-10-19",
  "batteryCountText": "1",
  "onlineBatteryCount": "1",
  "totalBatteryCount": "1",
  "runtimeStatus": "-",
  "updateTime": "2026-10-19",
};

///告警汇总 —— 对应 AlarmSummaryEntity
///路由：/alarms/summary → AlarmAPI.getAlarmsSummary
///RealAlarmLogic/HistoryAlarmLogic 首先调用此接口
const alarmSummary = {
  "siteCount": 2,
  "stackCount": 3,
  "alarmClusterCount": 2,
};

///消息通知 —— 对应 List(NotifyItemEntity)
///路由：/notifications?limit=20 → NotifyAPI.getNotifications
///解析路径：result["data"]["items"] → List(NotifyItemEntity)
///MessagePage 按 type 分发："ALARM" → AlarmMessageItem、"UPGRADE" → UpgradeMessageItem
///AlarmMessageItem 字段访问：
///   showAlarmLevel（→ alarmLevel，colorValue + title 渲染等级徽章）、
///   showTitle/title、showSiteName/siteName、showTime/time、
///   stackSn/siteId（点击跳转 StackAlarmDetailPage）
///UpgradeMessageItem 字段访问：
///   showTitle/title、showTime/time
const notifications = {
  "items": [
    {
      "id": "notify-001",
      "type": "ALARM",
      "level": "SEVERE",
      "levelLabel": "严重",
      "alarmLevel": 1,
      "title": "米兰绿色社区 1号堆簇1 电芯温度过高",
      "time": "2026-10-28 14:20:35",
      "timestamp": 1761672035000,
      "siteId": "site-002",
      "siteName": "米兰绿色社区",
      "stackSn": "HIFLY-20260615-001",
      "stackName": "米兰社区 1号堆",
      "alarmId": 1001,
      "taskId": null,
      "taskNo": null,
      "upgradeType": null,
      "versionDisplay": null,
    },
    {
      "id": "notify-002",
      "type": "ALARM",
      "level": "WARNING",
      "levelLabel": "警告",
      "alarmLevel": 2,
      "title": "米兰绿色社区 2号堆簇2 充电过流保护",
      "time": "2026-10-28 13:55:00",
      "timestamp": 1761670500000,
      "siteId": "site-002",
      "siteName": "米兰绿色社区",
      "stackSn": "HIFLY-20260615-002",
      "stackName": "米兰社区 2号堆",
      "alarmId": 1002,
      "taskId": null,
      "taskNo": null,
      "upgradeType": null,
      "versionDisplay": null,
    },
    {
      "id": "notify-003",
      "type": "ALARM",
      "level": "INFO",
      "levelLabel": "提示",
      "alarmLevel": 3,
      "title": "柏林湖畔别墅 1号堆 通信延迟告警",
      "time": "2026-10-28 10:30:22",
      "timestamp": 1761651022000,
      "siteId": "site-004",
      "siteName": "柏林湖畔别墅",
      "stackSn": "HIFLY-20260702-001",
      "stackName": "柏林别墅 1号堆",
      "alarmId": 1003,
      "taskId": null,
      "taskNo": null,
      "upgradeType": null,
      "versionDisplay": null,
    },
    {
      "id": "notify-004",
      "type": "UPGRADE",
      "level": "UPGRADE",
      "levelLabel": "升级",
      "alarmLevel": null,
      "title": "HIFLY-20260615-001 堆固件可升级至 v2.3.0",
      "time": "2026-10-27 10:00:00",
      "timestamp": 1761588000000,
      "siteId": "site-002",
      "siteName": "米兰绿色社区",
      "stackSn": "HIFLY-20260615-001",
      "stackName": "米兰社区 1号堆",
      "alarmId": null,
      "taskId": 2001,
      "taskNo": "UPG-20261027-001",
      "upgradeType": "FIRMWARE",
      "versionDisplay": "v2.2.1 → v2.3.0",
    },
    {
      "id": "notify-005",
      "type": "UPGRADE",
      "level": "UPGRADE",
      "levelLabel": "升级",
      "alarmLevel": null,
      "title": "HIFLY-20260615-002 堆 BMS 固件 v2.1.8 → v2.2.0",
      "time": "2026-10-26 16:30:00",
      "timestamp": 1761517800000,
      "siteId": "site-002",
      "siteName": "米兰绿色社区",
      "stackSn": "HIFLY-20260615-002",
      "stackName": "米兰社区 2号堆",
      "alarmId": null,
      "taskId": 2002,
      "taskNo": "UPG-20261026-002",
      "upgradeType": "FIRMWARE",
      "versionDisplay": "v2.1.8 → v2.2.0",
    },
  ],
};

///站点下的电池堆列表 —— 对应 List(StackItemEntity)
///路由：/sites/{siteId}/battery-stacks → AlarmAPI.getBatteryStack
///返回数组本身（非分页对象）
const batteryStackList = [
  {
    "stackId": 101,
    "stackSn": "HIFLY-20260615-001",
    "stackName": "米兰社区 1号堆",
    "label": "STACK-001",
    "modelName": "PowerNest 10",
    "firmwareVersion": "v2.2.1",
    "clusterCount": 3,
    "sysMode": 2,
    "commStatus": "ONLINE",
    "runStatus": "CHARGING",
    "siteId": 201,
    "bound": true,
  },
  {
    "stackId": 102,
    "stackSn": "HIFLY-20260615-002",
    "stackName": "米兰社区 2号堆",
    "label": "STACK-002",
    "modelName": "PowerNest 10",
    "firmwareVersion": "v2.1.8",
    "clusterCount": 2,
    "sysMode": 2,
    "commStatus": "ONLINE",
    "runStatus": "ALARM",
    "siteId": 201,
    "bound": true,
  },
];
