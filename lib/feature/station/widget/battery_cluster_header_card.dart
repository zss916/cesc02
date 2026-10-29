import 'package:cesc01/core/helper/device_status.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

const Color _kTitleText = Color(0xFF1F3A56);
const Color _kSecondaryText = Color(0xFF8C9AA8);
const Color _kCardBorder = Color(0xFFECEFF3);
const Color _kExpandText = Color(0xFF4A7A96);
const Color _kValueBlue = Color(0xFF3D7BEA);

/// 簇头部信息卡片
///
/// 对应原型 `v2-cluster-header`：
/// - 簇名 + 状态胶囊 + 「所属堆 · Pack 数」副标题
/// - 可展开的「设备标识与数据时间」折叠区（SN / 平台接收时间等）
class BatteryClusterHeaderCard extends StatefulWidget {
  const BatteryClusterHeaderCard({
    super.key,
    required this.clusterName,
    required this.subtitle,
    required this.status,
    this.sectionTitle,
    required this.metaRows,
    this.initiallyExpanded = false,
    this.onChanged,
  });

  final String clusterName;
  final String subtitle;

  /// online / warning / offline / delayed
  final String status;
  final String? sectionTitle;
  final List<ClusterMetaRow> metaRows;
  final bool initiallyExpanded;
  final void Function(bool expanded)? onChanged;

  @override
  State<BatteryClusterHeaderCard> createState() =>
      _BatteryClusterHeaderCardState();
}

class _BatteryClusterHeaderCardState extends State<BatteryClusterHeaderCard> {
  late bool _expanded = widget.initiallyExpanded;

  void _toggle() {
    setState(() => _expanded = !_expanded);
    widget.onChanged?.call(_expanded);
  }

  @override
  Widget build(BuildContext context) {
    // final statusColor = _statusColor(widget.status);

    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 14),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kCardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头部：图标徽章 + 簇名/副标题 + 状态胶囊
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF4C6EF5), Color(0xFF3B5BDB)],
                  ),
                  borderRadius: BorderRadius.circular(11),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4C6EF5).withValues(alpha: 0.30),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.battery_charging_full_rounded,
                  color: Colors.white,
                  size: 19,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.clusterName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: _kTitleText,
                              height: 1.2,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _StatusBadge(
                          status: widget.status,
                          color: widget.status.colorValue,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: _kSecondaryText,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFEDF0F4)),
          // 可展开区块标题
          InkWell(
            onTap: _toggle,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  AnimatedRotation(
                    turns: _expanded ? 0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      size: 18,
                      color: _kExpandText,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.sectionTitle ?? LKey.deviceIdAndDataTime.tr,
                    style: const TextStyle(
                      fontSize: 13,
                      color: _kExpandText,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 展开内容：键值行
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 240),
            sizeCurve: Curves.easeOut,
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.only(left: 22, right: 2, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < widget.metaRows.length; i++) ...[
                    if (i > 0) const SizedBox(height: 8),
                    _MetaRowItem(row: widget.metaRows[i]),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── 状态胶囊 ───────────────────────────

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status, required this.color});

  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: color.withValues(alpha: 0.35), blurRadius: 4),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Text(
            status.title,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── 键值行 ───────────────────────────

class ClusterMetaRow {
  const ClusterMetaRow({
    required this.label,
    required this.value,
    this.mono = false,
  });

  final String label;
  final String value;
  final bool mono;
}

class _MetaRowItem extends StatelessWidget {
  const _MetaRowItem({required this.row});

  final ClusterMetaRow row;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${row.label}:',
          style: const TextStyle(
            fontSize: 12.5,
            color: _kSecondaryText,
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            row.value,
            style: TextStyle(
              fontSize: 12.5,
              color: _kValueBlue,
              fontWeight: FontWeight.w600,
              height: 1.4,
              letterSpacing: row.mono ? 0.3 : 0,
              fontFamily: row.mono ? 'SF Mono' : null,
              fontFamilyFallback: row.mono
                  ? const ['Roboto Mono', 'monospace']
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────── 状态工具 ───────────────────────────

/*Color _statusColor(String status) {
  switch (status) {
    case 'online':
      return const Color(0xFF34C759);
    case 'warning':
      return const Color(0xFFFF9F0A);
    case 'offline':
      return const Color(0xFF9AA4B2);
    case 'delayed':
      return const Color(0xFFFFCC00);
    default:
      return const Color(0xFF9AA4B2);
  }
}*/

/*String _statusLabel(String status) {
  switch (status) {
    case 'online':
      return '在线';
    case 'warning':
      return '告警';
    case 'offline':
      return '离线';
    case 'delayed':
      return '延迟';
    default:
      return '未知';
  }
}*/
