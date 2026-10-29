import 'package:cesc01/core/network/bean/options_entity.dart';
import 'package:cesc01/core/network/bean/stack_and_cluster_entity.dart';
import 'package:cesc01/feature/provision/helper/state_mixin.dart';
import 'package:cesc01/feature/station/widget/cluster_data_view.dart';
import 'package:cesc01/feature/station/widget/stack_cluster_selector.dart';
import 'package:cesc01/feature/station/widget/stack_data_view.dart';
import 'package:flutter/material.dart';

class BatteryData extends StatefulWidget {
  final String? siteId;
  final List<OptionsStacks> options;
  final StackAndClusterEntity? stackAndClusterData;
  final Function(String? stackId, String? clusterId) onSwitch;

  const BatteryData({
    super.key,
    required this.siteId,
    required this.options,
    required this.stackAndClusterData,
    required this.onSwitch,
  });

  @override
  State<BatteryData> createState() => _BatteryItem2State();
}

class _BatteryItem2State extends State<BatteryData> with AppStateMixin {
  int index = 0;
  String? stackId;
  String? stackName;
  String? clusterName;
  String? _lastSiteId;
  bool _needsReset = false;

  @override
  void initState() {
    super.initState();
    _lastSiteId = widget.siteId;
  }

  @override
  void didUpdateWidget(covariant BatteryData oldWidget) {
    super.didUpdateWidget(oldWidget);
    final siteId = widget.siteId;
    // 检测站点切换
    if (_lastSiteId != siteId) {
      _lastSiteId = siteId;
      _needsReset = true;
    }
    // options 就绪后执行重置（fetchData 异步，options 可能晚一帧到达）
    if (_needsReset && widget.options.isNotEmpty) {
      _needsReset = false;
      final stack = widget.options.first;
      stackId = stack.stackId;
      stackName = stack.showStackName;
      final clusters = stack.clusters ?? [];
      clusterName = clusters.isNotEmpty ? clusters.first.showClusterName : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          ///堆和簇的选择器
          if (widget.options.isNotEmpty)
            StackClusterSelector(
              stacks: widget.options,
              onChanged:
                  (
                    OptionsStacks stack,
                    OptionsStacksClusters? cluster,
                    SelectorTab tab,
                  ) {
                    safeSetState(() {
                      index = tab.index;
                      stackId = stack.stackId;
                      stackName = stack.showStackName;
                      clusterName = cluster?.showClusterName;
                      widget.onSwitch.call(stack.stackId, cluster?.clusterId);
                    });
                  },
            ),
          if (widget.stackAndClusterData != null)
            IndexedStack(
              index: index,
              children: [
                StackDataView(
                  data: widget.stackAndClusterData!,
                  stackId: stackId ?? (widget.siteId ?? ""),
                ),
                ClusterDataView(
                  data: widget.stackAndClusterData!,
                  breadcrumbPrefix: '$stackName / $clusterName',
                ),
              ],
            ),
        ],
      ),
    );
  }
}
