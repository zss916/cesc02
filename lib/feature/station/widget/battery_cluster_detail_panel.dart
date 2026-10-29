import 'package:cesc01/core/helper/tools.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color _kBlue = Color(0xFF4C6EF5);
const Color _kPrimaryText = Color(0xFF2C3E50);
const Color _kSecondaryText = Color(0xFF8C9AA8);
const Color _kTertiaryText = Color(0xFF6B7785);
const Color _kCardBorder = Color(0xFFECEFF3);
const Color _kAmber = Color(0xFFE09A2D);
const Color _kViolet = Color(0xFF7C5CFF);

enum ClusterDetailTab { metrics, cells, alarm, system }

// ─────────────────────────── 数据模型 ───────────────────────────

/// 关键指标卡片数据
class ClusterMetricCardData {
  const ClusterMetricCardData({
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final String unit;
  final IconData icon;

  /// 数值与图标主色（卡片渐变底、边框均由它派生）
  final Color color;
}

/// 两列键值对数据
class ClusterKV {
  const ClusterKV(this.label, this.value, {this.mono = false});

  final String label;
  final String value;
  final bool mono;
}

/// 温压极值数据
class ClusterExtremeData {
  const ClusterExtremeData({
    required this.label,
    required this.value,
    required this.unit,
    required this.location,
    required this.icon,
    required this.isMax,
  });

  final String label;
  final String value;
  final String unit;
  final String location;
  final IconData icon;

  /// 极大值暖色 / 极小值冷色
  final bool isMax;
}

/// 单体读数（电压 / 温度）
class CellReading {
  const CellReading({this.label = '', required this.value, this.decimals = 3});

  /// 可选标签；单体电压网格的编号由组件按「Pack序号-单体序号」生成
  final String label;

  /// 数值；为 null 时 UI 显示 "--"（如单体电压缺失）
  final num? value;

  /// 显示保留小数位
  final int decimals;
}

/// 单个 Pack 的单体诊断数据
class PackCellData {
  const PackCellData({
    required this.packNo,
    required this.voltages,
    required this.probeTemps,
    this.environmentTemperature,
    this.heaterTemperature,
    this.soh,
    this.balance,
    this.balancingCells = const [],
    this.mosTemps = const [],
  });

  /// Pack 序号（1 起）
  final String packNo;
  final List<CellReading> voltages;
  final List<CellReading> probeTemps;

  /// 环境温度
  final String? environmentTemperature;

  /// 加热温度
  final String? heaterTemperature;

  /// SOH
  final String? soh;

  /// 均衡状态：1 均衡中 / 0 未均衡
  final int? balance;

  /// 均衡中的单体序号
  final List<int> balancingCells;

  /// MOS 温度（label 为 MOS 序号）
  final List<CellReading> mosTemps;

  String get balanceTitle {
    if (balance != 1) return LKey.notBalancing.tr;
    if (balancingCells.isEmpty) return LKey.balancing.tr;
    return '${LKey.balancing.tr}: ${balancingCells.join("、")}';
  }

  /// 热管理与均衡行
  List<ClusterKV> get thermalRows => [
    ClusterKV(LKey.environmentTemperature.tr, environmentTemperature ?? '-'),
    ClusterKV(LKey.heaterTemperature.tr, heaterTemperature ?? '-'),
    ClusterKV(LKey.balanceStatus.tr, balanceTitle),
    ClusterKV('SOH', soh ?? '-'),
    for (final t in mosTemps)
      ClusterKV(
        LKey.mosTemperature.trArgs([t.label]),
        '${t.value?.toStringAsFixed(t.decimals) ?? '--'} °C',
      ),
  ];
}

// ─────────────────────────── 组件 ───────────────────────────

/// 电池簇详情面板
///
/// 顶部「关键指标 / 单体诊断 / 告警信息 / 系统信息」胶囊 Tab：
/// - 关键指标：6 张彩色指标卡 + 运行与保护 + 电量与温差 + 温压极值与位置
/// - 单体诊断：Pack 切换 + 单体电压网格（最高/最低高亮）+ 温度探头 + 热管理与均衡
/// - 告警信息：簇告警概要
/// - 系统信息：簇 SN、版本、容量等参数
class BatteryClusterDetailPanel extends StatefulWidget {
  const BatteryClusterDetailPanel({
    super.key,
    this.initialTab = ClusterDetailTab.metrics,
    required this.metricCards,
    required this.runProtectRows,
    required this.energyRows,
    required this.extremes,
    required this.systemRows,
    required this.alarmRows,
    required this.breadcrumbPrefix,
    this.packs,
    this.onTabChanged,
  });
  //电池堆 1 / 簇1

  final ClusterDetailTab initialTab;
  final List<ClusterMetricCardData> metricCards;
  final List<ClusterKV> runProtectRows;
  final List<ClusterKV> energyRows;
  final List<ClusterExtremeData> extremes;
  final List<ClusterKV> alarmRows;
  final List<ClusterKV> systemRows;

  /// 单体诊断数据（每个 Pack 的单体电压、温度探头与热管理）；null 时展示空态
  final List<PackCellData>? packs;
  final String breadcrumbPrefix;
  final void Function(ClusterDetailTab tab)? onTabChanged;

  @override
  State<BatteryClusterDetailPanel> createState() =>
      _BatteryClusterDetailPanelState();
}

class _BatteryClusterDetailPanelState extends State<BatteryClusterDetailPanel> {
  late ClusterDetailTab _tab = widget.initialTab;
  List<PackCellData> get _packs => widget.packs ?? const [];
  int _selectedPack = 0;

  void _switch(ClusterDetailTab tab) {
    if (tab == _tab) return;
    setState(() => _tab = tab);
    widget.onTabChanged?.call(tab);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 16),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tab 卡片（关键指标时内嵌指标网格）
          if (Get.isZh)
            _TabCard(
              tab: _tab,
              onTabChanged: _switch,
              metricCards: widget.metricCards,
            )
          else
            _TabCard2(
              tab: _tab,
              onTabChanged: _switch,
              metricCards: widget.metricCards,
            ),
          const SizedBox(height: 12),
          // 面板卡片们（切换时淡入 + 上移过渡）
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 240),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              final slide = Tween<Offset>(
                begin: const Offset(0, 0.03),
                end: Offset.zero,
              ).animate(animation);
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(position: slide, child: child),
              );
            },
            layoutBuilder: (currentChild, previousChildren) => Stack(
              alignment: Alignment.topCenter,
              children: [...previousChildren, ?currentChild],
            ),
            child: KeyedSubtree(key: ValueKey(_tab), child: _buildPanelCards()),
          ),
        ],
      ),
    );
  }

  Widget _buildPanelCards() {
    switch (_tab) {
      case ClusterDetailTab.metrics:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SectionCard(
              title: LKey.keyMetrics.tr,
              accent: _kBlue,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.zero,
                //child: StackMetricsGrid(data: widget.metricCards)
                child: _MetricGrid(cards: widget.metricCards),
              ),
            ),

            const SizedBox(height: 12),
            _SectionCard(
              title: LKey.runAndProtection.tr,
              accent: _kBlue,
              child: _KVGrid(rows: widget.runProtectRows),
            ),
            const SizedBox(height: 12),
            _SectionCard(
              title: LKey.energyAndTempDiff.tr,
              accent: _kBlue,
              child: _KVGrid(rows: widget.energyRows),
            ),
            const SizedBox(height: 12),
            _SectionCard(
              title: LKey.extremeAndLocation.tr,
              accent: _kAmber,
              child: _ExtremeGrid(items: widget.extremes),
            ),
            const SizedBox(height: 30),
          ],
        );
      case ClusterDetailTab.cells:
        if (_packs.isEmpty) {
          return _SectionCard(
            title: LKey.singleDiagnosis.tr,
            accent: _kBlue,
            child: Text(
              LKey.noSingleDiagnosisData.tr,
              style: const TextStyle(
                fontSize: 13,
                color: _kSecondaryText,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          );
        }
        final index = _selectedPack < _packs.length ? _selectedPack : 0;
        final pack = _packs[index];
        final packNo = pack.packNo;
        final packLabel = 'Pack $packNo';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Pack 选择（胶囊按钮组，超宽自动换行）
            Text(
              LKey.selectPack.tr,
              style: const TextStyle(
                fontSize: 13,
                color: _kSecondaryText,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (int i = 0; i < _packs.length; i++)
                  _PackChip(
                    label: 'Pack ${_packs[i].packNo}',
                    cellCount: _packs[i].voltages.length,
                    selected: i == index,
                    onTap: () => setState(() => _selectedPack = i),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            // 面包屑
            Text(
              '${widget.breadcrumbPrefix} / $packLabel',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF7E93AB),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            // 单体电压网格
            _CellVoltageCard(packNo: packNo, pack: pack),
            const SizedBox(height: 12),
            // 温度探头
            _SectionCard(
              title: LKey.temperatureProbe.tr,
              accent: _kAmber,
              child: _KVGrid(
                rows: [
                  for (int j = 0; j < pack.probeTemps.length; j++)
                    ClusterKV(
                      LKey.packProbeTitle.trArgs([packNo, '${j + 1}']),
                      (pack.probeTemps[j].value?.toStringAsFixed(
                                pack.probeTemps[j].decimals,
                              )) ==
                              null
                          ? '--'
                          : '${pack.probeTemps[j].value?.toStringAsFixed(pack.probeTemps[j].decimals) ?? '0'} °C',
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // 热管理与均衡
            _SectionCard(
              title: LKey.thermalManagementBalance.tr,
              accent: _kAmber,
              child: _KVGrid(rows: pack.thermalRows),
            ),
            const SizedBox(height: 30),
          ],
        );
      case ClusterDetailTab.alarm:
        return _SectionCard(
          title: LKey.clusterAlarm.tr,
          accent: _kAmber,
          child: _KVGrid(rows: widget.alarmRows),
        );
      case ClusterDetailTab.system:
        return _SectionCard(
          title: LKey.clusterSystemInfo.tr,
          accent: _kViolet,
          child: _KVList(rows: widget.systemRows),
        );
    }
  }
}

// ─────────────────────────── Tab 卡片 ───────────────────────────

class _TabCard extends StatelessWidget {
  const _TabCard({
    required this.tab,
    required this.onTabChanged,
    required this.metricCards,
  });

  final ClusterDetailTab tab;
  final void Function(ClusterDetailTab) onTabChanged;
  final List<ClusterMetricCardData> metricCards;

  static Map<ClusterDetailTab, String> get _labels => {
    ClusterDetailTab.metrics: LKey.keyMetrics.tr,
    ClusterDetailTab.cells: LKey.singleDiagnosis.tr,
    ClusterDetailTab.alarm: LKey.alarmInfo.tr,
    ClusterDetailTab.system: LKey.systemInfo.tr,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: _cardDecoration(radius: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 胶囊 Tab
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F2F7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                ...ClusterDetailTab.values.map(
                  (t) => Expanded(
                    child: _TabPill(
                      label: _labels[t]!,
                      active: tab == t,
                      onTap: () => onTabChanged(t),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 关键指标网格（仅关键指标 Tab 展开，高度自动过渡）
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 240),
            sizeCurve: Curves.easeOut,
            crossFadeState: tab == ClusterDetailTab.metrics
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            /*firstChild: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: _MetricGrid(cards: metricCards),
            ),*/
            firstChild: const SizedBox(width: double.infinity),
            secondChild: const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

///非中文版本
class _TabCard2 extends StatefulWidget {
  const _TabCard2({
    required this.tab,
    required this.onTabChanged,
    required this.metricCards,
  });

  final ClusterDetailTab tab;
  final void Function(ClusterDetailTab) onTabChanged;
  final List<ClusterMetricCardData> metricCards;

  @override
  State<_TabCard2> createState() => _TabCardState();
}

class _TabCardState extends State<_TabCard2>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  Map<ClusterDetailTab, String> get _labels2 => {
    ClusterDetailTab.metrics: LKey.keyMetrics.tr,
    ClusterDetailTab.cells: LKey.singleDiagnosis.tr,
    ClusterDetailTab.alarm: LKey.alarmInfo.tr,
    ClusterDetailTab.system: LKey.systemInfo.tr,
  };

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: ClusterDetailTab.values.length,
      vsync: this,
      initialIndex: widget.tab.index,
    );
    _controller.addListener(_handleTabChanged);
  }

  void _handleTabChanged() {
    final tab = ClusterDetailTab.values[_controller.index];
    if (tab != widget.tab) {
      widget.onTabChanged.call(tab);
    }
  }

  @override
  void didUpdateWidget(covariant _TabCard2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tab != oldWidget.tab && _controller.index != widget.tab.index) {
      _controller.animateTo(widget.tab.index);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: _cardDecoration(radius: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 胶囊 Tab（Material TabBar：白色胶囊指示器，文案超宽自动等比缩小）
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F2F7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _controller,
              // labelPadding: EdgeInsets.zero,
              dividerColor: Colors.transparent,
              splashBorderRadius: BorderRadius.circular(9),
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              labelPadding: EdgeInsetsGeometry.symmetric(horizontal: 10),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: _kBlue,
              unselectedLabelColor: _kTertiaryText,
              labelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              tabs: [
                for (final t in ClusterDetailTab.values)
                  Tab(
                    height: 36,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(_labels2[t]!, maxLines: 1),
                    ),
                  ),
              ],
            ),
          ),
          // 关键指标网格（仅关键指标 Tab 展开，高度自动过渡）
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 240),
            sizeCurve: Curves.easeOut,
            crossFadeState: widget.tab == ClusterDetailTab.metrics
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            /*firstChild: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: _MetricGrid(cards: widget.metricCards),
            ),*/
            firstChild: const SizedBox(width: double.infinity),
            secondChild: const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

class _TabPill extends StatelessWidget {
  const _TabPill({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              color: active ? _kBlue : _kTertiaryText,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────── 关键指标 ───────────────────────────

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.cards});

  final List<ClusterMetricCardData> cards;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 16,
      childAspectRatio: 2.4,
      children: [for (final c in cards) _MetricCard(data: c)],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.data});

  final ClusterMetricCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        // color: Colors.white,
        color: Colors.grey.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF6F7D92)),
          ),
          const SizedBox(height: 3),
          FittedBox(
            child: Text(
              data.value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── 区块卡片 ───────────────────────────

Decoration _cardDecoration({double radius = 16}) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: _kCardBorder, width: 1),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.04),
        blurRadius: 16,
        offset: const Offset(0, 6),
      ),
    ],
  );
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.accent,
    required this.child,
    this.trailing,
  });

  final String title;
  final Color accent;
  final Widget child;

  /// 标题行右侧内容（如图例）
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 0),
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 彩色竖条 + 标题 + 右侧内容
          Row(
            children: [
              Container(
                width: 3,
                height: 14,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _kPrimaryText,
                    height: 1.2,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

// ─────────────────────────── 两列键值网格 ───────────────────────────

class _KVGrid extends StatelessWidget {
  const _KVGrid({required this.rows});

  final List<ClusterKV> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < rows.length; i += 1) ...[
          if (i > 0) const SizedBox(height: 14),
          SizedBox(
            width: double.maxFinite,
            child: _KVItem(row: rows[i]),
          ),
        ],
      ],
    );
  }
}

class _KVItem extends StatelessWidget {
  const _KVItem({required this.row});

  final ClusterKV row;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          row.label,
          style: const TextStyle(
            fontSize: 12,
            color: _kSecondaryText,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          row.value,
          style: TextStyle(
            fontSize: 16,
            color: _kPrimaryText,
            fontWeight: FontWeight.w500,
            height: 1.3,
            letterSpacing: row.mono ? 0.2 : 0,
            fontFamily: row.mono ? 'SF Mono' : null,
            fontFamilyFallback: row.mono
                ? const ['Roboto Mono', 'monospace']
                : null,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────── 单列键值列表 ───────────────────────────

class _KVList extends StatelessWidget {
  const _KVList({required this.rows});

  final List<ClusterKV> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < rows.length; i++) ...[
          if (i > 0) const SizedBox(height: 13),
          _KVItem(row: rows[i]),
        ],
      ],
    );
  }
}

// ─────────────────────────── 温压极值网格 ───────────────────────────

class _ExtremeGrid extends StatelessWidget {
  const _ExtremeGrid({required this.items});

  final List<ClusterExtremeData> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [...items.map((e) => _ExtremeCard(data: e))],
    );
  }
}

class _ExtremeCard extends StatelessWidget {
  const _ExtremeCard({required this.data});

  final ClusterExtremeData data;

  @override
  Widget build(BuildContext context) {
    final accent = data.isMax ? _kAmber : const Color(0xFF3D7BEA);
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: data.isMax ? const Color(0xFFFFF9EE) : const Color(0xFFF1F5FC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: data.isMax ? const Color(0xFFF0E4C8) : const Color(0xFFDCE5F2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  data.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: _kSecondaryText,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(data.icon, size: 12, color: accent),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: data.value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _kPrimaryText,
                    height: 1.1,
                    letterSpacing: -0.2,
                  ),
                ),
                if (false)
                  TextSpan(
                    text: ' ${data.unit}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _kTertiaryText,
                      height: 1.1,
                    ),
                  ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            data.location,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              color: _kSecondaryText,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── 单体诊断 ───────────────────────────

enum _CellHighlight { none, max, min }

/// Pack 选择胶囊
class _PackChip extends StatelessWidget {
  const _PackChip({
    required this.label,
    required this.cellCount,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final int cellCount;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF5F8FF) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? _kBlue : const Color(0xFFDCE3EC),
            width: 1.2,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: _kBlue.withValues(alpha: 0.10),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? _kBlue : const Color(0xFF4A5A6A),
                height: 1.2,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              LKey.cellCountUnit.trArgs(['$cellCount']),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: selected
                    ? const Color(0xFF93AAE8)
                    : const Color(0xFFA8B4C2),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 单体电压卡片（标题 + 最高/最低图例 + 3 列网格）
class _CellVoltageCard extends StatelessWidget {
  const _CellVoltageCard({required this.packNo, required this.pack});

  final String packNo;
  final PackCellData pack;

  @override
  Widget build(BuildContext context) {
    final volts = pack.voltages;
    if (volts.isEmpty) {
      return _SectionCard(
        title: LKey.packCellVoltage.trArgs([packNo]),
        accent: _kBlue,
        child: Text(
          LKey.noCellVoltageData.tr,
          style: const TextStyle(
            fontSize: 13,
            color: _kSecondaryText,
            fontWeight: FontWeight.w500,
            height: 1.3,
          ),
        ),
      );
    }
    final values = volts.map((e) => e.value).whereType<num>().toList();
    final maxValue = values.isNotEmpty
        ? values.reduce((a, b) => a > b ? a : b)
        : null;
    final minValue = values.isNotEmpty
        ? values.reduce((a, b) => a < b ? a : b)
        : null;

    _CellHighlight highlightOf(CellReading r) {
      if (r.value == null) return _CellHighlight.none;
      if (r.value == maxValue) return _CellHighlight.max;
      if (r.value == minValue) return _CellHighlight.min;
      return _CellHighlight.none;
    }

    return _SectionCard(
      title: LKey.packCellVoltage.trArgs([packNo]),
      accent: _kBlue,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LegendSquare(color: const Color(0xFFD9922E), label: LKey.highest.tr),
          const SizedBox(width: 12),
          _LegendSquare(color: const Color(0xFF3D7BEA), label: LKey.lowest.tr),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < volts.length; i += 3) ...[
            if (i > 0) const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _CellVoltageTile(
                    code: '$packNo-${i + 1}',
                    reading: volts[i],
                    highlight: highlightOf(volts[i]),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: i + 1 < volts.length
                      ? _CellVoltageTile(
                          code: '$packNo-${i + 2}',
                          reading: volts[i + 1],
                          highlight: highlightOf(volts[i + 1]),
                        )
                      : const SizedBox(),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: i + 2 < volts.length
                      ? _CellVoltageTile(
                          code: '$packNo-${i + 3}',
                          reading: volts[i + 2],
                          highlight: highlightOf(volts[i + 2]),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _CellVoltageTile extends StatelessWidget {
  const _CellVoltageTile({
    required this.code,
    required this.reading,
    required this.highlight,
  });

  final String code;
  final CellReading reading;
  final _CellHighlight highlight;

  @override
  Widget build(BuildContext context) {
    final (background, border, valueColor) = switch (highlight) {
      _CellHighlight.max => (
        const Color(0xFFFFF9EE),
        const Color(0xFFF0E0BC),
        const Color(0xFFD9922E),
      ),
      _CellHighlight.min => (
        const Color(0xFFF1F6FD),
        const Color(0xFFC9DCF5),
        const Color(0xFF3D7BEA),
      ),
      _CellHighlight.none => (
        Colors.white,
        const Color(0xFFE8EDF4),
        _kPrimaryText,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border, width: 1),
      ),
      child: Column(
        children: [
          Text(
            code,
            style: const TextStyle(
              fontSize: 11,
              color: _kSecondaryText,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            reading.value?.toStringAsFixed(reading.decimals) ?? '--',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: valueColor,
              height: 1.1,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            'V',
            style: TextStyle(
              fontSize: 10,
              color: _kSecondaryText,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

/// 图例（小方块 + 文字）
class _LegendSquare extends StatelessWidget {
  const _LegendSquare({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: _kSecondaryText,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
