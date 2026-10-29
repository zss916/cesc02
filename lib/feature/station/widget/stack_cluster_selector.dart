import 'package:cesc01/core/helper/device_status.dart';
import 'package:cesc01/core/helper/tools.dart';
import 'package:cesc01/core/network/bean/options_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 电池堆 / 电池簇 级联选择器
///
/// 对应原型 `v2-battery-toolbar v2-linked-battery-toolbar`：
/// - 堆选择卡片 + 簇选择卡片（选中簇数据 Tab 时出现）
/// - 点击卡片展开下拉：搜索框 + 列表 + 底部统计
/// - 底部「堆数据 / 簇数据」分段 Tab
class StackClusterSelector extends StatefulWidget {
  const StackClusterSelector({
    super.key,
    required this.stacks,
    this.initialStackSn,
    this.initialClusterSn,
    this.initialTab = SelectorTab.stack,
    this.onChanged,
  });

  final List<OptionsStacks> stacks;
  final String? initialStackSn;
  final String? initialClusterSn;
  final SelectorTab initialTab;
  final void Function(
    OptionsStacks stack,
    OptionsStacksClusters? cluster,
    SelectorTab tab,
  )?
  onChanged;

  @override
  State<StackClusterSelector> createState() => _StackClusterSelectorState();
}

enum SelectorTab { stack, cluster }

class _StackClusterSelectorState extends State<StackClusterSelector> {
  late SelectorTab _tab = widget.initialTab;
  late OptionsStacks _stack;
  OptionsStacksClusters? _cluster;
  OverlayEntry? _overlay;
  // 下拉面板锚定整个卡片行，保证宽度与选择器一致
  final LayerLink _containerLink = LayerLink();
  final GlobalKey _containerKey = GlobalKey();

  /// 安全地初始化 / 重置选中项，处理 clusters 为空的情况
  void _initSelection() {
    if (widget.stacks.isEmpty) return;
    _stack = widget.stacks.firstWhere(
      (s) => s.stackSn == widget.initialStackSn,
      orElse: () => widget.stacks.first,
    );
    final clusters = _stack.clusters ?? [];
    if (clusters.isEmpty) {
      _cluster = null;
      return;
    }
    _cluster = clusters.firstWhere(
      (c) => c.clusterSn == widget.initialClusterSn,
      orElse: () => clusters.first,
    );
  }

  @override
  void initState() {
    super.initState();
    _initSelection();
  }

  @override
  void didUpdateWidget(covariant StackClusterSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 切换站点后 stacks 列表引用变化，重新初始化选中项
    if (oldWidget.stacks != widget.stacks) {
      _removeOverlay();
      _initSelection();
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _emit() {
    widget.onChanged?.call(
      _stack,
      _tab == SelectorTab.cluster ? _cluster : null,
      _tab,
    );
  }

  void _removeOverlay() {
    _overlay?.remove();
    _overlay = null;
  }

  void _toggleStackOverlay() {
    if (_overlay != null) {
      _removeOverlay();
      return;
    }
    _showOverlay(
      title: LKey.searchStackHint.tr,
      items: (_stack.clusters ?? []).isEmpty
          ? const []
          : widget.stacks
                .map(
                  (s) => _PickerItem(
                    title: s.showStackName,
                    subtitle: s.showStackSn,
                    meta: LKey.clusterCountUnit.trArgs(['${s.clusterCount}']),
                    status: s.showCommStatus,
                    selected: s.stackSn == _stack.stackSn,
                    keywords: '${s.showStackName} ${s.showStackSn}',
                    onTap: () {
                      setState(() {
                        _stack = s;
                        _cluster = (s.clusters ?? []).first;
                      });
                      _removeOverlay();
                      _emit();
                    },
                  ),
                )
                .toList(),
      footer: LKey.totalStacksHint.trArgs(['${widget.stacks.length}']),
    );
  }

  void _toggleClusterOverlay() {
    if (_overlay != null) {
      _removeOverlay();
      return;
    }
    _showOverlay(
      title: LKey.searchClusterHint.tr,
      items: (_stack.clusters ?? [])
          .map(
            (c) => _PickerItem(
              title: c.showClusterName,
              subtitle: c.showClusterSn,
              meta: LKey.packCountUnit.trArgs(['${c.showPackCount}']),
              status: c.showCommStatus,
              selected: c.clusterSn == _cluster?.clusterSn,
              keywords: '${c.showClusterName} ${c.showClusterSn}',
              onTap: () {
                setState(() => _cluster = c);
                _removeOverlay();
                _emit();
              },
            ),
          )
          .toList(),
      footer: LKey.totalClustersHint.trArgs([
        '${(_stack.clusters ?? []).length}',
      ]),
    );
  }

  void _showOverlay({
    required String title,
    required List<_PickerItem> items,
    required String footer,
  }) {
    final renderBox =
        _containerKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlay = OverlayEntry(
      builder: (ctx) => Stack(
        children: [
          // 背景点击关闭
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _removeOverlay,
            ),
          ),
          CompositedTransformFollower(
            link: _containerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 8),
            child: SizedBox(
              width: size.width,
              child: _PickerPanel(hint: title, items: items, footer: footer),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context).insert(_overlay!);
  }

  @override
  Widget build(BuildContext context) {
    final withCluster = _tab == SelectorTab.cluster;

    return Container(
      padding: const EdgeInsets.all(12),
      margin: EdgeInsetsDirectional.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFECEFF3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 选择卡片行（下拉面板锚定整行，宽度与选择器一致）
          CompositedTransformTarget(
            key: _containerKey,
            link: _containerLink,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _SelectorCard(
                    label: Get.isZh ? LKey.batteryStack.tr : "",
                    count: LKey.totalStacks.trArgs(['${widget.stacks.length}']),
                    title: _stack.showStackName,
                    subtitle: LKey.clusterCountUnit.trArgs([
                      '${_stack.clusterCount}',
                    ]),
                    status: _stack.showCommStatus,
                    onTap: _toggleStackOverlay,
                  ),
                ),
                if (withCluster) ...[
                  const SizedBox(width: 10),
                  Expanded(
                    child: _SelectorCard(
                      label: Get.isZh ? LKey.batteryCluster.tr : "",
                      count: LKey.totalClusters.trArgs([
                        '${_stack.clusterCount}',
                      ]),
                      title: _cluster?.showClusterName ?? "-",
                      subtitle: LKey.packCountUnit.trArgs([
                        '${_cluster?.showPackCount ?? 0}',
                      ]),
                      status: _cluster?.showCommStatus ?? '-',
                      onTap: _toggleClusterOverlay,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
          // 堆数据 / 簇数据 分段 Tab
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F2F7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                _SegmentButton(
                  label: LKey.stackData.tr,
                  active: _tab == SelectorTab.stack,
                  onTap: () {
                    setState(() => _tab = SelectorTab.stack);
                    _emit();
                  },
                ),
                _SegmentButton(
                  label: LKey.clusterData.tr,
                  active: _tab == SelectorTab.cluster,
                  onTap: () {
                    setState(() => _tab = SelectorTab.cluster);
                    _emit();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────── 选择卡片 ───────────────────────────

class _SelectorCard extends StatelessWidget {
  const _SelectorCard({
    required this.label,
    required this.count,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.onTap,
  });

  final String label;
  final String count;
  final String title;
  final String subtitle;
  final String status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 顶部标签行
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF8C9AA8),
                fontWeight: FontWeight.w400,
                letterSpacing: 0.2,
              ),
            ),
            const Spacer(),
            Text(
              count,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF8C9AA8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // 选择卡片
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFD9DEE6), width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF2C3E50),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Text(
                              subtitle,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF8C9AA8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: status.colorValue,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              status.title,
                              style: TextStyle(
                                fontSize: 11,
                                color: status.colorValue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: Color(0xFF8C9AA8),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────── 分段按钮 ───────────────────────────

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
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
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              color: active ? const Color(0xFF4C6EF5) : const Color(0xFF6B7785),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────── 下拉面板 ───────────────────────────

class _PickerPanel extends StatefulWidget {
  const _PickerPanel({
    required this.hint,
    required this.items,
    required this.footer,
  });

  final String hint;
  final List<_PickerItem> items;
  final String footer;

  @override
  State<_PickerPanel> createState() => _PickerPanelState();
}

class _PickerPanelState extends State<_PickerPanel> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = _query.isEmpty
        ? widget.items
        : widget.items
              .where(
                (e) => e.keywords.toLowerCase().contains(_query.toLowerCase()),
              )
              .toList();

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFECEFF3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 搜索框
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 6),
              child: TextField(
                autofocus: false,
                onChanged: (v) => setState(() => _query = v),
                style: const TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFFA8B2C0),
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    size: 18,
                    color: Color(0xFFA8B2C0),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF7F9FC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFFD9DEE6),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFFD9DEE6),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF4C6EF5),
                      width: 1.2,
                    ),
                  ),
                ),
              ),
            ),
            // 列表
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 240),
              child: filtered.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: Text(
                          LKey.noMatchResult.tr,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF8C9AA8),
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      itemCount: filtered.length,
                      itemBuilder: (ctx, i) => filtered[i],
                    ),
            ),
            // 底部统计
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: Color(0xFFF7F9FC),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
                border: Border(top: BorderSide(color: Color(0xFFECEFF3))),
              ),
              child: Text(
                widget.footer,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF8C9AA8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PickerItem extends StatelessWidget {
  const _PickerItem({
    required this.title,
    required this.subtitle,
    required this.meta,
    required this.status,
    required this.selected,
    required this.keywords,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String meta;
  final String status;
  final bool selected;
  final String keywords;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final statusColor = status.colorValue;
    return InkWell(
      onTap: onTap,
      child: Container(
        color: selected ? const Color(0xFFEFF3FF) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: selected
                          ? const Color(0xFF4C6EF5)
                          : const Color(0xFF2C3E50),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF8C9AA8),
                      fontFamily: 'SF Mono',
                      fontFamilyFallback: ['Roboto Mono', 'monospace'],
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              meta,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF6B7785),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 3),
            Text(
              status.title,
              style: TextStyle(
                fontSize: 11,
                color: statusColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (selected) ...[
              const SizedBox(width: 6),
              const Icon(
                Icons.check_rounded,
                size: 16,
                color: Color(0xFF4C6EF5),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
