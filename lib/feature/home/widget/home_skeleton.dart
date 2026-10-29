import 'package:flutter/material.dart';

/// 首页骨架屏
/// 布局对齐 HomeOverviewWidget + HomeSiteCardList，使用 ShaderMask 做微光扫过动画
class HomeSkeleton extends StatefulWidget {
  const HomeSkeleton({super.key, this.siteCount = 10});

  /// 骨架站点卡片数量
  final int siteCount;

  @override
  State<HomeSkeleton> createState() => _HomeSkeletonState();
}

class _HomeSkeletonState extends State<HomeSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const Divider(height: 6, color: Colors.transparent),
        _OverviewSkeleton(animation: _controller),
        const Divider(height: 5, color: Colors.transparent),
        _SectionTitleSkeleton(animation: _controller),
        for (int i = 0; i < widget.siteCount; i++) ...[
          if (i != 0) const Divider(height: 14, color: Colors.transparent),
          _SiteCardSkeleton(animation: _controller),
        ],
        const SizedBox(height: 30),
      ],
    );
  }
}

/// 概览四宫格骨架：对齐 HomeOverviewWidget
class _OverviewSkeleton extends StatelessWidget {
  const _OverviewSkeleton({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 10),
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 2.2,
      children: List.generate(4, (i) {
        return Container(
          padding: EdgeInsetsDirectional.all(10),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: _Shimmer(
            animation: animation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _Bar(width: 88, height: 14),
                SizedBox(height: 8),
                _Bar(width: 44, height: 18),
              ],
            ),
          ),
        );
      }),
    );
  }
}

/// 分区标题骨架：对齐 SectionTitle
class _SectionTitleSkeleton extends StatelessWidget {
  const _SectionTitleSkeleton({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Shimmer(
            animation: animation,
            child: const _Bar(width: 80, height: 15),
          ),
          _Shimmer(
            animation: animation,
            child: const _Bar(width: 40, height: 12),
          ),
        ],
      ),
    );
  }
}

/// 站点卡片骨架：对齐 HomeSiteItem
class _SiteCardSkeleton extends StatelessWidget {
  const _SiteCardSkeleton({required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF102346).withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _Shimmer(
              animation: animation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  /// 站点名称
                  _Bar(width: 140, height: 16),
                  SizedBox(height: 7),

                  /// 站点副标题（堆数 · 地区）
                  _Bar(width: 96, height: 11),
                ],
              ),
            ),
          ),

          /// 状态徽章
          _Shimmer(
            animation: animation,
            child: const _Bar(width: 56, height: 22, radius: 6),
          ),
          const SizedBox(width: 8),

          /// 右侧箭头
          _Shimmer(
            animation: animation,
            child: const _Bar(width: 22, height: 22, radius: 11),
          ),
        ],
      ),
    );
  }
}

/// 微光扫过包装：blendMode.srcIn 用渐变替换子节点颜色，只保留 alpha
class _Shimmer extends StatelessWidget {
  const _Shimmer({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final t = animation.value;
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) => LinearGradient(
            begin: Alignment(-3.0 + 4.0 * t, 0),
            end: Alignment(-1.0 + 4.0 * t, 0),
            colors: const [
              Color(0xFFE9EDF3),
              Color(0xFFF9FBFD),
              Color(0xFFE9EDF3),
            ],
            stops: const [0.0, 0.5, 1.0],
          ).createShader(bounds),
          child: child,
        );
      },
      child: child,
    );
  }
}

/// 骨架条：颜色由外层 ShaderMask 覆盖，这里只需保证 alpha
class _Bar extends StatelessWidget {
  const _Bar({required this.width, required this.height, this.radius = 4});

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
