import 'package:flutter/material.dart';

/// 消息列表骨架屏
/// 纯 Flutter 实现（无第三方依赖），使用 ShaderMask 做微光扫过动画
class MessageSkeleton extends StatefulWidget {
  const MessageSkeleton({super.key, this.itemCount = 20});

  /// 骨架卡片数量
  final int itemCount;

  @override
  State<MessageSkeleton> createState() => _MessageSkeletonState();
}

class _MessageSkeletonState extends State<MessageSkeleton>
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
    return ListView.separated(
      padding: const EdgeInsetsDirectional.only(
        start: 16,
        end: 16,
        top: 16,
        bottom: 40,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.itemCount,
      separatorBuilder: (_, i) =>
          const Divider(height: 12, color: Colors.transparent),
      itemBuilder: (ctx, i) =>
          _SkeletonCard(animation: _controller, showChevron: i.isEven),
    );
  }
}

/// 单张骨架卡片：结构与 AlarmMessageItem / UpgradeMessageItem 保持一致
class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard({required this.animation, required this.showChevron});

  final Animation<double> animation;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          /// 微光从左向右扫过
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
        child: Row(
          children: [
            /// 等级徽章
            const _SkeletonBar(width: 40, height: 18, radius: 4),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 标题
                  const _SkeletonBar(width: double.infinity, height: 14),
                  const SizedBox(height: 6),

                  /// 副标题（站点 · 时间）
                  _SkeletonBar(width: showChevron ? 150 : 110, height: 12),
                ],
              ),
            ),
            if (showChevron) ...[
              const SizedBox(width: 8),
              const _SkeletonBar(width: 12, height: 12, radius: 6),
            ],
          ],
        ),
      ),
    );
  }
}

/// 骨架条：颜色由外层 ShaderMask 覆盖，这里只需保证 alpha
class _SkeletonBar extends StatelessWidget {
  const _SkeletonBar({
    required this.width,
    required this.height,
    this.radius = 4,
  });

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
