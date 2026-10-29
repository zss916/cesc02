import 'package:cesc01/core/network/bean/stack_and_cluster_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

enum LineChartType { loading, success, empty }

class LineChartCard extends StatelessWidget {
  final StackAndClusterTrend trend;
  const LineChartCard({super.key, required this.trend});

  @override
  Widget build(BuildContext context) {
    return buildBodyUI(
      state: LineChartType.success,
      data: (trend.points ?? []),
    );
  }

  Widget buildBodyUI({
    required LineChartType state,
    required List<StackAndClusterTrendPoints> data,
  }) {
    return switch (state) {
      _ when state == LineChartType.loading => buildLoading(),
      _ when state == LineChartType.empty => buildEmpty(),
      _ when state == LineChartType.success =>
        data.isEmpty ? buildEmpty() : buildContent(data),
      _ => SizedBox.shrink(),
    };
  }

  Widget buildLoading() => Container(
    width: double.maxFinite,
    height: 220,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.all(14),
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
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Center(
          child: CircularProgressIndicator(
            strokeCap: StrokeCap.round,
            color: Colors.blue,
          ),
        ),
        PositionedDirectional(
          top: 0,
          start: 0,
          child: Text(
            LKey.realTimeOperationCurve.tr,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF172033),
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildContent(List<StackAndClusterTrendPoints> data) => Container(
    width: double.maxFinite,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.all(14),
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              LKey.realTimeOperationCurve.tr,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF172033),
              ),
            ),
            Spacer(),
            Text(
              LKey.curveDuration.tr,
              style: TextStyle(fontSize: 12, color: Color(0xFF6F7D92)),
            ),
          ],
        ),

        // BaseLineChart(source: data),
      ],
    ),
  );

  Widget buildEmpty() => Container(
    width: double.maxFinite,
    height: 220,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.all(14),
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
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Center(
          child: Text(LKey.emptyTip.tr, style: TextStyle(color: Colors.black)),
        ),
        PositionedDirectional(
          top: 0,
          start: 0,
          child: Text(
            LKey.realTimeOperationCurve.tr,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF172033),
            ),
          ),
        ),
      ],
    ),
  );
}

class _LineChartPainter extends CustomPainter {
  final List<double> socData = const [
    30,
    30,
    32,
    35,
    40,
    45,
    50,
    54,
    58,
    60,
    61,
    62,
    63,
    64,
    65,
    66,
    67,
    67,
    68,
    69,
    70,
    70,
    71,
    72,
  ];
  final List<String> xLabels = const ['0', '6', '12', '18', '24'];

  @override
  void paint(Canvas canvas, Size size) {
    const padL = 26.0, padR = 6.0, padT = 8.0, padB = 18.0;
    final chartW = size.width - padL - padR;
    final chartH = size.height - padT - padB;

    final gridPaint = Paint()
      ..color = const Color(0xFFEAEef5)
      ..strokeWidth = 1;
    for (int i = 0; i <= 3; i++) {
      final y = padT + chartH * i / 3;
      _drawDashed(canvas, Offset(padL, y), Offset(padL + chartW, y), gridPaint);
    }

    // Y 轴标签
    final yLabels = const ['100', '67', '33', '0'];
    final tp = const TextStyle(fontSize: 9, color: Color(0xFFA8B4C8));
    for (int i = 0; i < yLabels.length; i++) {
      final y = padT + chartH * i / 3 + 3;
      final tbp = TextPainter(
        text: TextSpan(text: yLabels[i], style: tp),
        textDirection: TextDirection.ltr,
      );
      tbp.layout();
      tbp.paint(canvas, Offset(2, y));
    }

    final List<Offset> points = [];
    for (int i = 0; i < socData.length; i++) {
      final x = padL + chartW * i / (socData.length - 1);
      final y = padT + chartH * (1 - socData[i] / 100.0);
      points.add(Offset(x, y));
    }

    // 渐变填充
    final path = Path()
      ..moveTo(points.first.dx, padT + chartH)
      ..lineTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++)
      path.lineTo(points[i].dx, points[i].dy);
    //path.lineTo(points.last.dx, padT + chartH)..close();

    canvas.drawPath(
      path,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0x333978F6), const Color(0x053978F6)],
        ).createShader(Rect.fromLTWH(0, padT, size.width, chartH)),
    );

    // 折线
    canvas.drawPath(
      Path()..moveTo(points.first.dx, points.first.dy),
      //..addPoints(points.sublist(1)),
      Paint()
        ..color = const Color(0xFF3978F6)
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    // 起点圆点
    canvas.drawCircle(
      points.first,
      3.5,
      Paint()..color = const Color(0xFF3978F6),
    );
    canvas.drawCircle(points.first, 1.5, Paint()..color = Colors.white);

    // X 轴标签
    for (int i = 0; i < xLabels.length; i++) {
      final x = padL + chartW * i / (xLabels.length - 1);
      final tbp = TextPainter(
        text: TextSpan(text: xLabels[i], style: tp),
        textDirection: TextDirection.ltr,
      );
      tbp.layout();
      tbp.paint(canvas, Offset(x - tbp.width / 2, size.height - 12));
    }
  }

  void _drawDashed(Canvas canvas, Offset from, Offset to, Paint paint) {
    const dashW = 4.0;
    const gapW = 3.0;
    final dist = (to - from).distance;
    final dir = (to - from) / dist;
    double d = 0;
    while (d < dist) {
      final endD = (d + dashW).clamp(0.0, dist);
      canvas.drawLine(from + dir * d, from + dir * endD, paint);
      d += dashW + gapW;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
