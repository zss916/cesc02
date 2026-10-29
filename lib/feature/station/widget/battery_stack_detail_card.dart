import 'package:cesc01/core/helper/device_status.dart';
import 'package:cesc01/core/network/bean/stack_and_cluster_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

const Color _blue = Color(0xFF2F6BE4);
const Color _textPrimary = Color(0xFF2C3E50);
const Color _textSecondary = Color(0xFF8C9AA8);
const Color _textTertiary = Color(0xFF6B7785);
const Color _divider = Color(0xFFEDF0F4);

/// 电池堆详情卡片
///
/// 对应原型：顶部「温压极值 / 系统信息」两个 Tab
/// - 温压极值：最高/最低单体电压、最高/最低温度 2×2 数据卡片
/// - 系统信息：堆 SN、软件/硬件/Boot 版本、设计容量、簇数量、系统模式
class BatteryStackDetailCard extends StatefulWidget {
  final StackAndClusterSystemInfo systemInfo;
  final StackAndClusterExtrema extrema;
  final StackDetailTab initialTab;
  final String clusterCount;
  const BatteryStackDetailCard({
    super.key,
    this.initialTab = StackDetailTab.extreme,
    required this.systemInfo,
    required this.extrema,
    required this.clusterCount,
  });

  @override
  State<BatteryStackDetailCard> createState() => _BatteryStackDetailCardState();
}

enum StackDetailTab { extreme, system }

class _BatteryStackDetailCardState extends State<BatteryStackDetailCard> {
  late StackDetailTab _tab = widget.initialTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(16, 2, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFECEFF3), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B2A4A).withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: const Color(0xFF1B2A4A).withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 顶部下划线 Tab
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(height: 1, color: _divider),
              ),
              Row(
                children: [
                  _TabItem(
                    label: LKey.extremeTempeAndPressure.tr,
                    active: _tab == StackDetailTab.extreme,
                    onTap: () => setState(() => _tab = StackDetailTab.extreme),
                  ),
                  const SizedBox(width: 28),
                  _TabItem(
                    label: LKey.systemInfo.tr,
                    active: _tab == StackDetailTab.system,
                    onTap: () => setState(() => _tab = StackDetailTab.system),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 内容区（切换时淡入 + 轻微上移）
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              final slide = Tween<Offset>(
                begin: const Offset(0, 0.02),
                end: Offset.zero,
              ).animate(animation);
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(position: slide, child: child),
              );
            },
            child: _tab == StackDetailTab.extreme
                ? _ExtremePanel(
                    key: const ValueKey('extreme'),
                    data: widget.extrema,
                  )
                : _SystemInfoPanel(
                    key: const ValueKey('system'),
                    data: widget.systemInfo,
                    clusterCount: widget.clusterCount,
                  ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── Tab 项 ───────────────────────────

class _TabItem extends StatelessWidget {
  const _TabItem({
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
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.fromLTRB(2, 12, 2, 12),
        decoration: BoxDecoration(
          // 常驻 3px 边框，未选中时透明，避免切换时抖动
          border: Border(
            bottom: BorderSide(
              color: active ? _blue : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 180),
          style: TextStyle(
            fontSize: 15,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            color: active ? _blue : _textSecondary,
            height: 1.2,
          ),
          child: Text(label),
        ),
      ),
    );
  }
}

// ─────────────────────────── 温压极值面板 ───────────────────────────

class _ExtremePanel extends StatelessWidget {
  final StackAndClusterExtrema data;
  const _ExtremePanel({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        _ExtremeCard(
          data: ExtremeValue(
            label: LKey.maxCellVoltage.tr,
            value: data.showMaxCellVoltage,
            unit: 'V',
            location: data.showMaxCellVoltageTitle,
            icon: Icons.bolt_rounded,
            isMax: true,
          ),
        ),

        _ExtremeCard(
          data: ExtremeValue(
            label: LKey.minCellVoltage.tr,
            value: data.showMinCellVoltage,
            unit: 'V',
            location: data.showMinCellVoltageTitle,
            icon: Icons.bolt_rounded,
            isMax: false,
          ),
        ),

        _ExtremeCard(
          data: ExtremeValue(
            label: LKey.maxTemp.tr,
            value: data.showMaxTemperature,
            unit: '°C',
            location: data.showMaxTemperatureTitle,
            icon: Icons.thermostat_rounded,
            isMax: true,
          ),
        ),

        _ExtremeCard(
          data: ExtremeValue(
            label: LKey.minTemp.tr,
            value: data.showMinTemperature,
            unit: '°C',
            location: data.showMinTemperatureTitle,
            icon: Icons.thermostat_rounded,
            isMax: false,
          ),
        ),
      ],
    );
  }
}

class _ExtremeCard extends StatelessWidget {
  const _ExtremeCard({required this.data});

  final ExtremeValue data;

  @override
  Widget build(BuildContext context) {
    // 极大值用暖色，极小值用冷色
    final accent = data.isMax
        ? const Color(0xFFE09A2D)
        : const Color(0xFF3D7BEA);
    final border = data.isMax
        ? const Color(0xFFF3E4C9)
        : const Color(0xFFDEE8F8);
    final gradient = data.isMax
        ? const [Color(0xFFFFFCF5), Color(0xFFFFF6E8)]
        : const [Color(0xFFF8FBFF), Color(0xFFEFF5FE)];

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border, width: 1),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  data.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: _textSecondary,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(data.icon, size: 16, color: accent),
              ),
            ],
          ),
          Divider(height: 5, color: Colors.transparent),
          // 数值 + 单位
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: data.value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: _textPrimary,
                    height: 1.05,
                    letterSpacing: -0.4,
                  ),
                ),
                if (false)
                  TextSpan(
                    text: ' ${data.unit}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _textTertiary,
                      height: 1.05,
                    ),
                  ),
              ],
            ),
          ),
          Divider(height: 10, color: Colors.transparent),
          // 位置信息
          Text(
            data.location,
            style: const TextStyle(
              fontSize: 11,
              color: _textSecondary,
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

// ─────────────────────────── 系统信息面板 ───────────────────────────

class _SystemInfoPanel extends StatelessWidget {
  final StackAndClusterSystemInfo data;
  final String clusterCount;
  const _SystemInfoPanel({
    super.key,
    required this.data,
    required this.clusterCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SystemInfoRow(
          entry: SystemInfoEntry(
            label: LKey.stackSnLabel.tr,
            value: data.showStackSn,
            icon: Icons.qr_code_rounded,
            color: Color(0xFF4C6EF5),
          ),
        ),
        _SystemInfoRow(
          entry: SystemInfoEntry(
            label: LKey.stackSoftware.tr,
            value: data.showSoftwareVersion,
            icon: Icons.developer_mode_rounded,
            color: Color(0xFF7C5CFF),
          ),
        ),
        _SystemInfoRow(
          entry: SystemInfoEntry(
            label: LKey.stackHardware.tr,
            value: data.showHardwareVersion,
            icon: Icons.memory_rounded,
            color: Color(0xFF9B59B6),
          ),
        ),
        _SystemInfoRow(
          entry: SystemInfoEntry(
            label: LKey.stackBoot.tr,
            value: data.showBootVersion,
            icon: Icons.play_circle_outline_rounded,
            color: Color(0xFFFF9F0A),
          ),
        ),
        _SystemInfoRow(
          entry: SystemInfoEntry(
            label: LKey.designCapacity.tr,
            value: data.showDesignCapacity,
            icon: Icons.battery_std_rounded,
            color: Color(0xFF34C759),
          ),
        ),
        _SystemInfoRow(
          entry: SystemInfoEntry(
            label: LKey.clusterCountLabel.tr,
            value: clusterCount,
            icon: Icons.grid_view_rounded,
            color: Color(0xFF12B0C6),
          ),
        ),
        _SystemInfoRow(
          entry: SystemInfoEntry(
            label: LKey.systemMode.tr,
            value: data.showMode.modeTitle,
            icon: Icons.bolt_rounded,
            color: Color(0xFFFF7A45),
          ),
        ),
      ],
    );
  }
}

class _SystemInfoRow extends StatelessWidget {
  const _SystemInfoRow({required this.entry});

  final SystemInfoEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F8FC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEDF1F7), width: 1),
      ),
      child: Row(
        children: [
          // 图标徽章
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: entry.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(entry.icon, size: 17, color: entry.color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: _textSecondary,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  entry.value,
                  style: TextStyle(
                    fontSize: 14,
                    color: _textPrimary,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── 数据模型 ───────────────────────────

class ExtremeValue {
  const ExtremeValue({
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

  /// 是否为极大值（决定暖色 / 冷色配色）
  final bool isMax;
}

class SystemInfoEntry {
  const SystemInfoEntry({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
}
