# CESC01 设备配网使用文档

> 适用版本：v1.0.0+1 · PowerNest 系列储能设备

---

## 目录

- [1. 前置条件](#1-前置条件)
- [2. 配网流程总览](#2-配网流程总览)
- [3. Step 0 — 输入 SN 与蓝牙准备](#3-step-0--输入-sn-与蓝牙准备)
- [4. Step 1 — 扫描连接设备](#4-step-1--扫描连接设备)
- [5. Step 2 — 配置 WiFi 下发](#5-step-2--配置-wifi-下发)
- [6. Step 3 — 绑定/创建站点](#6-step-3--绑定创建站点)
- [7. 异常处理](#7-异常处理)
- [8. 错误码对照表](#8-错误码对照表)
- [9. 常见问题 FAQ](#9-常见问题-faq)
- [10. 技术实现参考](#10-技术实现参考)

---

## 1. 前置条件

在开始配网前，请确保以下条件全部满足：

| # | 条件 | 说明 | 平台 |
|---|---|---|---|
| 1 | 设备已开机 | PowerNest 储能设备通电，电源指示灯常亮 | Android / iOS |
| 2 | 手机蓝牙已开启 | 系统设置 → 蓝牙 → 开启 | Android / iOS |
| 3 | 手机定位已开启 | 配网需定位权限辅助 BLE 扫描 | Android / iOS |
| 4 | 手机已连接 WiFi | 必须是 2.4GHz WiFi（5GHz 设备不支持） | Android / iOS |
| 5 | WiFi 信号良好 | 手机与设备距离 ≤ 5 米，无墙壁遮挡 | Android / iOS |
| 6 | WiFi SSID 不含中文/特殊字符 | 建议英文+数字，避免空格 | Android / iOS |
| 7 | 配网密码正确 | 区分大小写 | Android / iOS |

### 权限申请清单

| 权限 | 用途 | Android | iOS |
|---|---|---|---|
| 蓝牙扫描 | 发现附近待配网设备 | `BLUETOOTH_SCAN` | NSBluetoothAlwaysUsageDescription |
| 蓝牙连接 | 连接设备进行通信 | `BLUETOOTH_CONNECT` | NSBluetoothAlwaysUsageDescription |
| 定位 | BLE 扫描辅助（Android 12+） | `ACCESS_FINE_LOCATION` | NSLocationWhenInUseUsageDescription |
| 附近设备 | BLE 扫描（Android 13+） | `NEARBY_WIFI_DEVICES` | — |

> **iOS 特别说明**：iOS 首次扫描 BLE 时系统会弹窗请求「允许该 App 使用蓝牙」，必须点击「允许」。系统蓝牙开关关闭时 App 会弹出提示引导用户打开。

---

## 2. 配网流程总览

```
┌──────────────────────────────────────────────────────────────────────┐
│                         配网入口                                      │
│  首页 → 「+ 配网」快捷卡片  /  登录后自动引导                          │
└─────────────────────────────┬────────────────────────────────────────┘
                              │
                              ▼
┌──────────────┐   ┌──────────────┐   ┌──────────────┐   ┌──────────────┐
│   Step 0     │   │   Step 1     │   │   Step 2     │   │   Step 3     │
│  输入 SN      │──▶│  扫描连接     │──▶│  WiFi 下发    │──▶│  站点绑定     │
│  蓝牙检查     │   │  选择设备     │   │  进度/超时    │   │  或新建       │
└──────────────┘   └──────────────┘   └──────────────┘   └──────────────┘
     │                   │                   │                   │
     │                   │                   │                   │
     ▼                   ▼                   ▼                   ▼
  权限弹窗           重新扫描            超时 Sheet          成功 Sheet
  蓝牙开关           未发现设备          失败 Sheet          失败 Sheet
```

### 步骤流转条件

| 当前步骤 | 下一步条件 | 触发 |
|---|---|---|
| Step 0 → Step 1 | SN 非空 + 蓝牙已开启 + 权限已授权 | 点击「下一步」 |
| Step 1 → Step 2 | 已扫描到设备 + 已选择设备 | 点击「下一步」 |
| Step 2 → Step 3 | BLE 配网成功（SmartBleLink events.finished） | 自动跳转 |
| Step 3 → 完成 | 站点创建/绑定 API 返回成功 | 显示 SuccessSheet → 返回首页 |

---

## 3. Step 0 — 输入 SN 与蓝牙准备

### 界面元素

| 元素 | 类型 | 说明 |
|---|---|---|
| SN 输入框 | TextField | 设备序列号，支持扫码输入 |
| 扫码按钮 | IconButton | 调用 `ai_barcode_scanner` 扫描设备二维码 |
| 蓝牙状态指示器 | Container | 绿色 = 已开启，灰色 = 未开启 |
| 蓝牙开关按钮 | ElevatedButton | 引导用户打开系统蓝牙设置 |
| 下一步按钮 | PrimaryButton | 校验通过后进入 Step 1 |

### 操作流程

```
1. 进入页面 → 系统自动监听蓝牙状态变化
2. 输入 SN（手动或扫码）
3. 点击「下一步」
   ├── SN 为空 → Toast 提示「请输入 SN」
   ├── 蓝牙未开启 → 弹出 SystemBluetoothDialog → 引导打开蓝牙
   ├── 蓝牙权限未授权 → 弹出 BluePermissionTipDialog
   │     ├── 定位未授权 → 弹出 iOSLocationServiceDialog（iOS）
   │     ├── 蓝牙扫描未授权 → 弹出 BlePermissionTipDialog
   │     └── 点击「允许」→ 跳转系统设置页
   └── 全部就绪 → 进入 Step 1
```

### SN 输入规则

- **格式**：字母 + 数字组合，如 `HIFLY-20260615-001`
- **校验**：非空 + 长度 ≥ 6 位
- **扫码**：点击扫码按钮 → 摄像头扫描设备铭牌上的二维码 → 自动填入 SN

---

## 4. Step 1 — 扫描连接设备

### 界面元素

| 元素 | 类型 | 说明 |
|---|---|---|
| 扫描提示文本 | Text | 「正在发现附近设备...」 |
| 设备列表 | ListView | 扫描到的 BLE 设备卡片 |
| 设备卡片 | DeviceBlueCard | 设备名 + MAC + RSSI 信号强度 |
| 重新扫描按钮 | OutlineButton | 扫描超时后重新扫描 |
| 下一步按钮 | PrimaryButton | 已选设备后可点击 |

### 操作流程

```
1. 进入 Step 1 → 自动开始 BLE 扫描
   ├── flutter_blue_plus.startScan(timeout: 15s)
   └── 扫描结果实时更新列表

2. 扫描到设备 → 显示卡片列表
   ├── 匹配 SN 后缀的设备 → 高亮推荐
   └── 未匹配 → 灰色展示，需手动选择

3. 点击设备卡片 → 选中
   ├── 设备 SN 与 Step 0 输入不匹配 → Toast 提示
   └── 匹配成功 → 卡片变绿 + 下一步按钮可用

4. 扫描超时（15s）→ 显示「重新发现设备」按钮

5. 点击「下一步」→ 进入 Step 2
```

### 设备匹配规则

- 设备名包含 SN 后 6 位 → 自动推荐
- 无匹配设备 → 手动点击选择
- 选中设备后校验：`selectedDevice.name` 必须以 Step 0 的 SN 后缀结尾

---

## 5. Step 2 — 配置 WiFi 下发

### 界面元素

| 元素 | 类型 | 说明 |
|---|---|---|
| WiFi SSID 输入框 | TextField | 手机当前连接的 WiFi 名称（自动填充） |
| WiFi 密码输入框 | TextField | WiFi 密码，带显示/隐藏切换 |
| WiFi 状态 | Row | 是否已连接 + SSID 显示 |
| 配网进度条 | LinearProgressIndicator | 配网过程实时进度（0-100%） |
| 配网状态文本 | Text | 当前配网阶段（如「正在连接 AP...」） |
| 初始化按钮 | PrimaryButton | 点击开始配网流程 |
| 取消按钮 | OutlineButton | 中途取消配网 |

### 操作流程

```
1. 进入 Step 2 → 自动读取手机当前 WiFi 信息
   └── WiFi 未连接 → Toast 提示「请先连接 WiFi」

2. 确认 SSID 与密码 → 点击「设置网络初始化」

3. 校验输入
   ├── SSID 为空 → Toast 提示
   ├── 密码为空 → Toast 提示
   └── 通过 → 开始配网

4. 配网执行（SmartBleLinkTools.startLinking）
   ├── 调用原生插件 SmartBleLink.startLinking(
   │     ssid: WiFi 名称,
   │     password: WiFi 密码,
   │     bleName: 选中的设备名,
   │     timeoutSeconds: 50)
   └── 监听事件流 SmartBleLink.events

5. 事件驱动 UI 更新

6. 配网成功 → 自动进入 Step 3
   配网超时（50s）→ 弹出 TimeoutSheet
   配网失败 → 弹出 StateSheet（错误信息 + 重试按钮）
```

### BLE 配网事件状态机

| 事件 | SmartBleLinkEvent | 含义 | UI 表现 |
|---|---|---|---|
| 进度更新 | `isProgress` | 配网进度百分比 | 进度条更新 + 百分比文本 |
| 普通消息 | `isMessage` | 配网阶段提示 | 状态文本更新（如「正在连接 AP...」） |
| 设备发现 | `isLinked` | 设备进入 AP 模式 | 提示用户确认 |
| 配网超时 | `isTimeout` | 50s 内未完成 | 弹出 TimeoutSheet（重新配网 / 返回） |
| 配网失败 | `isError` | 原生返回错误码 | 弹出 StateSheet（错误文案 + 重试） |
| 配网完成 | `isFinished` | 设备连上路由器 | 自动进入 Step 3 |

### 配网阶段时序

```
时间轴 ──────────────────────────────────────────────────────────▶
                                                                 │
  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌─────┐
  │ 连接 BLE  │  │ 配置 BLE  │  │ 设备连 AP │  │ AP 配网   │  │ 完成 │
  │            │  │ 下发 WiFi │  │ 模式     │  │ 路由器   │  │     │
  └──────────┘  └──────────┘  └──────────┘  └──────────┘  └─────┘
   0-5s          5-15s        15-25s         25-40s        40-50s
                                                                 │
  isProgress   isMessage    isMessage    isMessage    isFinished
  0→20%        30%          50%          80%          100%
```

---

## 6. Step 3 — 绑定/创建站点

### 两种模式

进入 Step 3 后，根据「已注册站点列表」自动选择默认模式：

| 条件 | 默认模式 | 说明 |
|---|---|---|
| 已有站点 | 并入现有站点 | 下拉选择已注册站点 |
| 无站点 | 新建站点 | 填写站点信息 |

### 模式 A：并入现有站点

#### 界面元素

| 元素 | 类型 | 说明 |
|---|---|---|
| 站点下拉选择器 | DropdownButton | 已有站点列表 |
| 站点信息展示 | Column | 选中站点的名称/编码/地区 |
| 绑定提示 | Text | 「将设备绑定至此站点」 |
| 确认按钮 | PrimaryButton | 调用绑定 API |
| 切换到新建 | TextButton | 切换到模式 B |

#### 操作流程

```
1. 进入 Step 3 → 自动切换到「并入现有站点」Tab
2. 选择已有站点
3. 点击「确认绑定」
   ├── API: ProvisionAPI.postBindSite(siteId, stackSns: [sn])
   ├── 成功 → 弹出 SuccessSheet → Stop SmartBleLink → 返回首页
   └── 失败 → Toast 提示错误信息
```

### 模式 B：新建站点

#### 界面元素

| 元素 | 类型 | 说明 |
|---|---|---|
| 站点名称输入框 | TextField | 必填，如「巴塞罗那阳光公寓」 |
| 国家/地区选择器 | DropdownButton | country_state_city_selector 插件 |
| 时区选择器 | DropdownButton | 时区列表（Europe/Madrid 等） |
| 详细地址输入框 | TextField | 可选，如「Carrer de Balmes 123」 |
| 确认按钮 | PrimaryButton | 调用创建+绑定 API |
| 切换到并入 | TextButton | 切换到模式 A |

#### 操作流程

```
1. 点击「新建站点」Tab
2. 填写站点信息
   ├── siteName 非空校验
   ├── countryRegion 必填
   └── timezone 必填
3. 点击「确认创建」
   ├── API: ProvisionAPI.createAndBindingSite(
   │     siteName, countryRegion, timezone, address, stackSns: [sn])
   ├── 成功 → 弹出 SuccessSheet → Stop SmartBleLink → 返回首页
   └── 失败 → Toast 提示错误信息
```

### 成功 Sheet

配网完成后弹出底部 Sheet：

| 元素 | 说明 |
|---|---|
| 成功图标 | ✅ 绿色对勾动画 |
| 标题 | 「配网成功」 |
| 副标题 | 设备 SN + 站点名称 |
| 「完成」按钮 | 关闭 Sheet → Get.back(closeOverlays: true) → 返回首页 |

### 失败 Sheet

| 元素 | 说明 |
|---|---|
| 失败图标 | ❌ 红色叉号 |
| 标题 | 「配网失败」 |
| 错误描述 | SmartBleLinkTools 映射后的中文文案 |
| 「重试」按钮 | 重新执行 Step 2 配网 |
| 「返回」按钮 | 返回上一步 |

---

## 7. 异常处理

### 7.1 配网超时

| 项目 | 说明 |
|---|---|
| 触发条件 | `SmartBleLink.startLinking()` 超时（默认 50 秒） |
| UI 表现 | 弹出 TimeoutSheet |
| 原因 | 设备未在 AP 模式、WiFi 信号差、密码错误 |
| 解决 | 点击「重新配网」返回 Step 2 检查 WiFi 信息，或点击「返回」回到 Step 0 |

### 7.2 配网失败

| 项目 | 说明 |
|---|---|
| 触发条件 | `SmartBleLink.events.isError` 事件 |
| UI 表现 | 弹出 StateSheet（错误文案 + 重试 + 返回） |
| 常见原因 | 见第 8 章错误码对照表 |

### 7.3 BLE 权限被拒

| 项目 | 说明 |
|---|---|
| 触发条件 | Android/iOS 拒绝蓝牙/定位权限 |
| UI 表现 | BlePermissionTipDialog |
| 解决 | 点击「允许」跳转系统设置页开启权限 |

### 7.4 蓝牙未开启

| 项目 | 说明 |
|---|---|
| 触发条件 | 系统蓝牙开关关闭 |
| UI 表现 | SystemBluetoothDialog（iOS）/ Android 自动跳转设置 |
| 解决 | 打开系统蓝牙开关 |

### 7.5 WiFi 未连接

| 项目 | 说明 |
|---|---|
| 触发条件 | 手机未连接任何 WiFi |
| UI 表现 | Step 2 提示「请先连接 WiFi」 |
| 解决 | 前往系统设置连接 WiFi 后返回 |

### 7.6 中途取消配网

| 项目 | 说明 |
|---|---|
| 触发条件 | Step 2 点击「取消」/返回上一步 |
| 处理 | `SmartBleLinkTools.instance.stopLinking()` + `cancelEvent()` |
| 安全退出 | 确保 BLE 配网资源完全释放 |

---

## 8. 错误码对照表

配网失败时，SmartBleLink 原生插件返回错误码，App 映射为用户可读文案：

| 原生错误码 | 中文文案 | 英文文案 | 可能原因 |
|---|---|---|---|
| `ERROR` | 内部错误 | Internal error | 原生插件异常，建议重试 |
| `CANCEL` | 配网已取消 | BLE cancelled | 用户主动取消 |
| `BLUETOOTH_DISABLED` | 蓝牙未开启 | Bluetooth disabled | 系统蓝牙开关关闭 |
| `NO_VALID_WIFI_CONNECTION` | 未检测到有效的 WiFi 连接 | No valid WiFi connection | 手机未连接 WiFi |
| `BLE_NOT_FOUND` | 未发现设备 | BLE device not found | 设备未开机、距离远、设备名不匹配 |
| `CONNECT_BLE_FAILED` | 连接设备失败 | Failed to connect BLE | BLE 信号弱、设备已被其他手机连接 |
| `CONFIG_BLE_FAILED` | 配置设备失败 | Failed to configure BLE | BLE 通信不稳定 |
| `FIND_DEVICE_FAILED` | 未找到已配网设备 | Linked device not found | 设备未成功连上路由器 |
| `FIND_DEVICE_FAILED_AP_PASSWORD_ERROR` | WiFi 密码错误 | Incorrect WiFi password | SSID 正确但密码不对 |
| `FIND_DEVICE_FAILED_AP_NOT_EXIST` | WiFi 不存在 | WiFi network does not exist | 设备扫描不到该 SSID |
| 其他 | 未知错误 | Unknown error | 请联系客服 |

### 错误码排查建议

| 错误码 | 优先排查 | 解决步骤 |
|---|---|---|
| `AP_PASSWORD_ERROR` | WiFi 密码 | 重新输入密码 → 确认大小写 → 确认是 2.4GHz |
| `AP_NOT_EXIST` | WiFi SSID | 确认 SSID 无中文/空格 → 检查路由器是否隐藏 SSID |
| `BLE_NOT_FOUND` | 设备是否开机 | 确认电源灯亮 → 重启设备 → 靠近手机 |
| `CONNECT_BLE_FAILED` | 信号强度 | 手机靠近设备（≤ 1 米）→ 退出其他 BLE App |
| `BLUETOOTH_DISABLED` | 蓝牙开关 | 打开系统蓝牙 → 确认系统权限已授权 |

---

## 9. 常见问题 FAQ

### Q1：配网时进度条卡在哪里不动？

**排查步骤：**

1. 确认手机蓝牙和定位都已开启
2. 确认手机 WiFi 信号良好（建议 2 米内）
3. 退出 App 重新进入，重启设备
4. 如果卡在 50% 超过 30 秒 → 可能是设备未进入 AP 模式 → 手动长按设备 Reset 键 5 秒

### Q2：为什么配网需要定位权限？

Android 12+ 强制要求：BLE 扫描需要定位权限辅助识别附近设备。iOS 同样需要定位权限保证 BLE 扫描正常工作。

### Q3：iOS 蓝牙弹窗点了「不允许」怎么办？

1. 打开 iOS「设置」→「隐私与安全性」→「蓝牙」
2. 找到本 App → 开启蓝牙权限
3. 重新打开 App 配网

### Q4：同一台设备能重复配网吗？

可以。设备有 Reset 功能，长按 Reset 键 5 秒以上可恢复出厂配网状态。

### Q5：配网成功但首页没有显示设备？

1. 下拉刷新首页
2. 确认站点选择器选中了正确站点
3. 等待 10-30 秒让设备上报数据
4. 如果仍不显示 → 退出 App 重新登录

### Q6：5GHz WiFi 为什么配网失败？

PowerNest 设备只支持 2.4GHz WiFi，5GHz 无法连接。请在路由器设置中开启 2.4GHz 频段。

### Q7：WiFi SSID 有中文或空格怎么办？

建议修改路由器 SSID 为英文+数字（如 `HOME_WIFI`）。部分设备 AP 模式不支持非 ASCII 字符。

### Q8：一台手机能同时配多台设备吗？

可以。配完第一台后返回首页，再次点击「配网」即可开始配下一台。每台设备独立 SN，独立绑定站点。

### Q9：配网超时怎么办？

点击「重新配网」返回 Step 2：
1. 确认 WiFi 密码正确
2. 手机靠近设备
3. 设备长按 Reset 恢复出厂
4. 重新开始配网

### Q10：iOS 系统蓝牙开关关闭怎么处理？

App 会自动弹出提示对话框 → 点击「设置」→ 系统跳转蓝牙设置页 → 打开蓝牙 → 返回 App。

---

## 10. 技术实现参考

### 10.1 双通道 BLE 架构

```
┌──────────────────────────────────────────────────────────────┐
│                     ProvisionPage                            │
├────────────────────┬─────────────────────────────────────────┤
│  flutter_blue_plus  │    smart_ble_link (本地原生插件)          │
│  设备扫描展示        │    WiFi 下发 + 配网状态机                  │
│  跨平台 (iOS/Android)│  Hiflying BLELink (Android)             │
│                     │  JY_BlueSDK (iOS)                       │
└────────────────────┴─────────────────────────────────────────┘
```

### 10.2 SmartBleLinkTools 核心方法

```dart
// 开始配网
SmartBleLinkTools.instance.startLinking({
  required String ssid,
  required String password,
  required String bleName,
  VoidCallback? onError,
})
// 内部调用: SmartBleLink.startLinking(ssid:, password:, bleName:, timeoutSeconds: 50)

// 取消配网
SmartBleLinkTools.instance.stopLinking()
SmartBleLinkTools.instance.cancelEvent()

// 监听事件
SmartBleLinkTools.instance.onEventListen({
  void Function(SmartBleLinkEvent event)? onSSIDEvent,    // isProgress
  void Function()? onLinkedEvent,                         // isLinked
  void Function()? onTimeOutEvent,                       // isTimeout
  void Function(String)? onErrorEvent,                   // isError
  void Function()? onFinishEvent,                        // isFinished
  void Function(String)? onMessageEvent,                 // isMessage
})
```

### 10.3 API 接口清单

| 接口 | 方法 | 路径 | 参数 | 调用时机 |
|---|---|---|---|---|
| 站点列表 | GET | `/sites/options` | — | 进入 ProvisionPage 时 |
| 创建+绑定站点 | POST | `/sites` | siteName, countryRegion, timezone, address, stackSns: [sn] | Step 3 新建站点确认 |
| 绑定现有站点 | PUT | `/sites/{siteId}/bind-batteries` | stackSns: [sn] | Step 3 并入现有站点确认 |

### 10.4 本地插件路径

```
plugins/
  └── smart_ble_link/           ← Hiflying BLE 配网 SDK 原生封装
        ├── android/            ← BLELink SDK (Android)
        └── ios/                ← JY_BlueSDK (iOS)
```

> **注意**：`smart_ble_link` 是项目私有本地插件，不在 pub.dev 上发布。
> 首次构建前需确认插件目录完整，否则会出现 `pub get` 依赖解析失败。

---

## 附录：配网成功验证

配网完成后，可以在以下位置验证设备是否正常工作：

| 验证项 | 位置 | 预期 |
|---|---|---|
| 站点概览 | 首页 → 站点卡片 | 显示新绑定的堆数/簇数 |
| 实时运行 | 实时 Tab | 站点通信状态 ONLINE，SOC/电压/电流有数据 |
| 站点详情 | 站点 Tab | 堆卡片列表，堆状态 ONLINE |
| 告警中心 | 告警 Tab | 无未处理告警 |
| 电池数据 | 站点 → 电池数据 Tab | 堆/簇指标正常显示 |

设备首次配网后可能需要 1-3 分钟上报数据，如果 5 分钟后仍无数据显示，建议检查：
1. 设备 WiFi 指示灯是否常亮（表示已连上路由器）
2. 路由器是否允许设备 MAC 地址通过
3. 配网时输入的 WiFi 密码是否正确（长按设备 Reset 可重新配网）
