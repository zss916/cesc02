part of 'index.dart';

/// 电池堆版本信息页面
///
/// 展示电池堆主控/硬件/Boot 版本，以及下属簇的版本信息。
class VersionInfoPage extends StatelessWidget {
  const VersionInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: appBarColor,
        backgroundColor: appBarColor,
        centerTitle: true,
        title: AppBarTitleWidget(title: LKey.versionDetail.tr),
      ),
      backgroundColor: appPageColor,
      body: GetBuilder<VersionInfoLogic>(
        init: VersionInfoLogic(),
        builder: (logic) => buildViewUI(state: logic.state),
      ),
    );
  }

  Widget buildViewUI({required UiState state}) {
    return switch (state) {
      Loading() => buildLoading(),
      Success(:final data) => buildBody(data),
      Empty() => Center(child: buildEmpty()),
      Offline() => Center(child: buildOffline()),
      Failure() => SizedBox.shrink(),
    };
  }

  Widget buildBody(VersionDataEntity data) => SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _StackVersionSection(
            stackName: data.showStackName,
            stackId: data.showStackSn,
            mainControlVersion: data.showSoftwareVersion,
            hardwareVersion: data.showHardwareVersion,
            bootVersion: data.showBootVersion,
          ),
          const SizedBox(height: 16),
          _SubClustersSection(
            clusters: [
              ...data.showClusterList.map(
                (e) => _ClusterData(
                  name: e.showClusterName,
                  code: e.showClusterSn,
                  packCount: e.showPackCount,
                  softwareVersion: e.showSoftwareVersion,
                  hardwareVersion: e.showHardwareVersion,
                  bootVersion: e.showBootVersion,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _StackVersionSection extends StatelessWidget {
  const _StackVersionSection({
    required this.stackName,
    required this.stackId,
    required this.mainControlVersion,
    required this.hardwareVersion,
    required this.bootVersion,
  });

  final String stackName;
  final String stackId;
  final String mainControlVersion;
  final String hardwareVersion;
  final String bootVersion;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFECEFF3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 顶部：图标 + 堆名 + 编号
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF4C6EF5), Color(0xFF3B5BDB)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4C6EF5).withValues(alpha: 0.30),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.memory_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            stackName,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2C3E50),
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stackId,
                        style: TextStyle(
                          fontSize: 11,
                          color: const Color(0xFF8C9AA8),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SF Mono',
                          fontFamilyFallback: const [
                            'Roboto Mono',
                            'monospace',
                          ],
                          letterSpacing: 0.4,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            _VersionCard(
              label: LKey.stackSoftwareVersion.tr,
              value: mainControlVersion,
              accentColor: const Color(0xFF4C6EF5),
              icon: Icons.developer_mode_rounded,
            ),
            const SizedBox(height: 10),
            _VersionCard(
              label: LKey.stackHardwareVersion.tr,
              value: hardwareVersion,
              accentColor: const Color(0xFF9B59B6),
              icon: Icons.memory_rounded,
              mono: true,
            ),

            // 三个版本卡片：2+1 布局
            /* IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _VersionCard(
                      label: '堆主控软件版本',
                      value: mainControlVersion,
                      accentColor: const Color(0xFF4C6EF5),
                      icon: Icons.developer_mode_rounded,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _VersionCard(
                      label: '堆硬件版本',
                      value: hardwareVersion,
                      accentColor: const Color(0xFF9B59B6),
                      icon: Icons.memory_rounded,
                      mono: true,
                    ),
                  ),
                ],
              ),
            ),*/
            const SizedBox(height: 10),
            _VersionCard(
              label: LKey.stackBootVersion.tr,
              value: bootVersion,
              accentColor: const Color(0xFFFF9F0A),
              icon: Icons.play_circle_outline_rounded,
              mono: true,
              fullWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _SubClustersSection extends StatelessWidget {
  const _SubClustersSection({required this.clusters});

  final List<_ClusterData> clusters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 区块标题：左侧竖条 + 文字 + 右侧细分隔线
        Row(
          children: [
            Container(
              width: 3,
              height: 14,
              decoration: BoxDecoration(
                color: const Color(0xFF4C6EF5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              LKey.subClusterVersion.tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
                height: 1.2,
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(child: Divider(height: 1, color: Color(0xFFEDF0F4))),
            const SizedBox(width: 6),
            Text(
              LKey.totalClusters.trArgs(['${clusters.length}']),
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF8C9AA8),
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < clusters.length; i++) ...[
              _ClusterCard(data: clusters[i]),
              if (i != clusters.length - 1) const SizedBox(height: 10),
            ],
          ],
        ),
      ],
    );
  }
}

class _ClusterCard extends StatelessWidget {
  const _ClusterCard({required this.data});

  final _ClusterData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFECEFF3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 顶部：簇名 + 编号 + Pack 标签
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF34C759).withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(
                    Icons.battery_charging_full_rounded,
                    color: Color(0xFF34C759),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2C3E50),
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        data.code,
                        style: TextStyle(
                          fontSize: 11,
                          color: const Color(0xFF8C9AA8),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SF Mono',
                          fontFamilyFallback: const [
                            'Roboto Mono',
                            'monospace',
                          ],
                          letterSpacing: 0.3,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF34C759).withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${data.packCount} Pack',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF34C759),
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 底部：3 个版本 mini cell
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F9FC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _MiniVersionCell(
                      label: '软件',
                      value: data.softwareVersion,
                      accentColor: const Color(0xFF4C6EF5),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 28,
                    color: const Color(0xFFE6EAF0),
                  ),
                  Expanded(
                    child: _MiniVersionCell(
                      label: '硬件',
                      value: data.hardwareVersion,
                      accentColor: const Color(0xFF9B59B6),
                      mono: true,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 28,
                    color: const Color(0xFFE6EAF0),
                  ),
                  Expanded(
                    child: _MiniVersionCell(
                      label: 'Boot',
                      value: data.bootVersion,
                      accentColor: const Color(0xFFFF9F0A),
                      mono: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VersionCard extends StatelessWidget {
  const _VersionCard({
    required this.label,
    required this.value,
    required this.accentColor,
    required this.icon,
    this.mono = false,
    this.fullWidth = false,
  });

  final String label;
  final String value;
  final Color accentColor;
  final IconData icon;
  final bool mono;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.10),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: accentColor, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF8C9AA8),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF2C3E50),
                    fontWeight: FontWeight.w700,
                    fontFamily: mono ? 'SF Mono' : null,
                    fontFamilyFallback: mono
                        ? const ['Roboto Mono', 'monospace']
                        : null,
                    letterSpacing: mono ? 0.3 : 0,
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

class _MiniVersionCell extends StatelessWidget {
  const _MiniVersionCell({
    required this.label,
    required this.value,
    required this.accentColor,
    this.mono = false,
  });

  final String label;
  final String value;
  final Color accentColor;
  final bool mono;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 3,
                height: 9,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF8C9AA8),
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                  height: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: const Color(0xFF2C3E50),
              fontWeight: FontWeight.w600,
              fontFamily: mono ? 'SF Mono' : null,
              fontFamilyFallback: mono
                  ? const ['Roboto Mono', 'monospace']
                  : null,
              letterSpacing: mono ? 0.3 : 0,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ClusterData {
  const _ClusterData({
    required this.name,
    required this.code,
    required this.packCount,
    required this.softwareVersion,
    required this.hardwareVersion,
    required this.bootVersion,
  });

  final String name;
  final String code;
  final int packCount;
  final String softwareVersion;
  final String hardwareVersion;
  final String bootVersion;
}
