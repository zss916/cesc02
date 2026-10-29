import 'dart:math' as math;

import 'package:cesc01/core/network/bean/stack_and_cluster_entity.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

const Color _kTitleText = Color(0xFF2C3E50);
const Color _kSecondaryText = Color(0xFF8C9AA8);
const Color _kCardBorder = Color(0xFFECEFF3);
const Color _kSocColor = Color(0xFF3D7BEA);
const Color _kVoltageColor = Color(0xFF2FA36B);
const Color _kCurrentColor = Color(0xFFE0912D);

/// 曲线数据点（由 [StackAndClusterTrendPoints] 转换而来）
class TrendChartPoint {
  const TrendChartPoint({
    required this.label,
    required this.soc,
    required this.voltage,
    required this.current,
  });

  /// X 轴标签（HH:mm）
  final String label;
  final double soc;
  final double voltage;
  final double current;
}

/// 实时运行曲线卡片
///
/// 数据模型：[StackAndClusterTrend]
/// - 三曲线：SOC（左轴 %）、电压（右轴 V）、电流（右轴 A）
/// - 顶部图例、时间范围与采样间隔说明、底部时区说明
class BatteryTrendChartCard extends StatelessWidget {
  const BatteryTrendChartCard({
    super.key,
    required this.trend,
    this.title,
    this.chartHeight = 240,
    this.footerNote,
  });

  final StackAndClusterTrend trend;
  final String? title;
  final double chartHeight;
  final String? footerNote;

  @override
  Widget build(BuildContext context) {
    final title = this.title ?? LKey.realTimeOperationCurve.tr;
    final footerNote = this.footerNote ?? LKey.currentDirectionNote.tr;
    final points = _mapPoints(trend.points ?? const []);
    final timeRange = _timeRange(points);
    final intervalText = trend.intervalMinutes == null
        ? '--'
        : LKey.intervalMinutes.trArgs(['${trend.intervalMinutes}']);

    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kCardBorder, width: 1),
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
          // 标题
          Row(
            children: [
              Container(
                width: 3,
                height: 15,
                decoration: BoxDecoration(
                  color: _kSocColor,
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
                    color: _kTitleText,
                    height: 1.2,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              if (points.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F6FC),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    LKey.pointCount.trArgs(['${points.length}']),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7E93AB),
                      height: 1.2,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          if (points.isEmpty)
            SizedBox(
              width: double.maxFinite,
              height: chartHeight,
              child: Center(
                child: Text(
                  LKey.noTrendData.tr,
                  style: const TextStyle(fontSize: 12, color: _kSecondaryText),
                ),
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 自定义图例
                Wrap(
                  spacing: 16,
                  runSpacing: 6,
                  children: [
                    const _LegendItem(color: _kSocColor, label: 'SOC (%)'),
                    _LegendItem(
                      color: _kVoltageColor,
                      label: '${LKey.voltage.tr} (V)',
                    ),
                    _LegendItem(
                      color: _kCurrentColor,
                      label: '${LKey.current.tr} (A)',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // 时间范围与采样间隔
                Text(
                  '${timeRange ?? '--:--'} · $intervalText',
                  style: const TextStyle(
                    fontSize: 11,
                    color: _kSecondaryText,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 14),
                // 坐标轴单位标题
                Row(
                  children: [
                    const Text(
                      'SOC %',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: _kSocColor,
                        height: 1.2,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${LKey.voltage.tr} V',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: _kVoltageColor,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${LKey.current.tr} A',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: _kCurrentColor,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                SizedBox(
                  height: chartHeight,
                  child: _TrendChart(points: points),
                ),
                const SizedBox(height: 10),
                Container(height: 1, color: const Color(0xFFF1F4F8)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.public_rounded,
                      size: 12,
                      color: Color(0xFF9AA8B6),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${trend.timezone ?? '--'} · $footerNote',
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF9AA8B6),
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────── 图表 ───────────────────────────

class _TrendChart extends StatelessWidget {
  const _TrendChart({required this.points});

  final List<TrendChartPoint> points;

  @override
  Widget build(BuildContext context) {
    final voltValues = points.map((p) => p.voltage).toList();
    final currValues = points.map((p) => p.current).toList();

    final voltRange = _axisRange(voltValues);
    final currRange = _axisRange(currValues);

    // 让 X 轴展示约 5 个刻度
    final labelInterval = math.max(1, ((points.length - 1) / 4).round());

    return SfCartesianChart(
      plotAreaBorderColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      //缩放
      zoomPanBehavior: ZoomPanBehavior(
        zoomMode: ZoomMode.x,
        enablePinching: true,
        enablePanning: true,
        enableMouseWheelZooming: true,
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        shared: true,
        canShowMarker: true,
        color: const Color(0xFF243447),
        textStyle: const TextStyle(
          fontSize: 11,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        duration: 2000,
        borderColor: Colors.transparent,
      ),
      // 长按/拖动显示触摸跟踪线 + 三曲线数值提示
      trackballBehavior: TrackballBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap,
        lineType: TrackballLineType.vertical,
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        lineColor: const Color(0xFFB9C6D6),
        lineWidth: 1,
        markerSettings: const TrackballMarkerSettings(
          markerVisibility: TrackballVisibilityMode.visible,
          width: 8,
          height: 8,
        ),
        tooltipSettings: const InteractiveTooltip(
          enable: true,
          color: Color(0xFF243447),
          borderColor: Colors.transparent,
          textStyle: TextStyle(
            fontSize: 11,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      legend: const Legend(isVisible: false),
      primaryXAxis: CategoryAxis(
        labelStyle: const TextStyle(
          color: _kSecondaryText,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(width: 0),
        majorGridLines: const MajorGridLines(width: 0),
        labelIntersectAction: AxisLabelIntersectAction.hide,
        interval: labelInterval.toDouble(),
      ),
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: 100,
        interval: 25.0,
        isInversed: false,
        labelStyle: const TextStyle(
          color: _kSocColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(width: 0),
        majorGridLines: const MajorGridLines(
          width: 1,
          dashArray: <double>[4, 4],
          color: Color(0xFFEDF1F7),
        ),
      ),
      axes: <ChartAxis>[
        NumericAxis(
          name: 'voltageAxis',
          opposedPosition: true,
          minimum: voltRange.min,
          maximum: voltRange.max,
          interval: voltRange.interval,
          labelStyle: const TextStyle(
            color: _kVoltageColor,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(width: 0),
          majorGridLines: const MajorGridLines(width: 0),
        ),
        NumericAxis(
          name: 'currentAxis',
          opposedPosition: true,
          minimum: currRange.min,
          maximum: currRange.max,
          interval: currRange.interval,
          labelStyle: const TextStyle(
            color: _kCurrentColor,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(width: 0),
          majorGridLines: const MajorGridLines(width: 0),
        ),
      ],
      series: <CartesianSeries<TrendChartPoint, String>>[
        SplineSeries<TrendChartPoint, String>(
          name: 'SOC',
          dataSource: points,
          xValueMapper: (TrendChartPoint p, num i) => p.label,
          yValueMapper: (TrendChartPoint p, num i) => p.soc,
          color: _kSocColor,
          width: 2.4,
          splineType: SplineType.natural,
          animationDuration: 700,
          markerSettings: const MarkerSettings(isVisible: false),
        ),
        SplineSeries<TrendChartPoint, String>(
          name: LKey.voltage.tr,
          dataSource: points,
          xValueMapper: (TrendChartPoint p, num i) => p.label,
          yValueMapper: (TrendChartPoint p, num i) => p.voltage,
          yAxisName: 'voltageAxis',
          color: _kVoltageColor,
          width: 2.4,
          splineType: SplineType.natural,
          animationDuration: 700,
          markerSettings: const MarkerSettings(isVisible: false),
        ),
        SplineSeries<TrendChartPoint, String>(
          name: LKey.current.tr,
          dataSource: points,
          xValueMapper: (TrendChartPoint p, num i) => p.label,
          yValueMapper: (TrendChartPoint p, num i) => p.current,
          yAxisName: 'currentAxis',
          color: _kCurrentColor,
          width: 2.4,
          splineType: SplineType.natural,
          animationDuration: 700,
          markerSettings: const MarkerSettings(isVisible: false),
        ),
      ],
    );
  }
}

// ─────────────────────────── 图例 ───────────────────────────

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 3,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF6B7785),
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────── 数据转换 ───────────────────────────

/// 把实体趋势点转换为图表点
List<TrendChartPoint> _mapPoints(List<StackAndClusterTrendPoints> raw) {
  final list = raw.toList()
    ..sort((a, b) => (a.timestamp ?? 0).compareTo(b.timestamp ?? 0));
  final firstDay = list.isEmpty ? null : _toDateTime(list.first.timestamp);
  return [
    for (final p in list)
      TrendChartPoint(
        label: _formatTime(p.timestamp, firstDay),
        soc: (p.soc ?? 0).toDouble(),
        voltage: (p.voltage ?? 0).toDouble(),
        current: (p.current ?? 0).toDouble(),
      ),
  ];
}

DateTime? _toDateTime(int? timestamp) {
  if (timestamp == null) return null;
  // 兼容秒 / 毫秒时间戳
  final ms = timestamp > 100000000000 ? timestamp : timestamp * 1000;
  return DateTime.fromMillisecondsSinceEpoch(ms);
}

String _formatTime(int? timestamp, DateTime? firstDay) {
  final dt = _toDateTime(timestamp);
  if (dt == null) return '--:--';
  // 跨天的首个零点按 24:00 展示
  if (firstDay != null &&
      dt.day != firstDay.day &&
      dt.hour == 0 &&
      dt.minute == 0) {
    return '24:00';
  }
  final h = dt.hour.toString().padLeft(2, '0');
  final m = dt.minute.toString().padLeft(2, '0');
  return '$h:$m';
}

String? _timeRange(List<TrendChartPoint> points) {
  if (points.isEmpty) return null;
  return '${points.first.label}–${points.last.label}';
}

/// 计算坐标轴范围与间隔（上下留 50% 余量）
({double min, double max, double interval}) _axisRange(List<double> values) {
  final maxValue = values.reduce(math.max);
  final minValue = values.reduce(math.min);
  final span = (maxValue - minValue).abs();
  final pad = span == 0 ? 1.0 : span * 0.5;
  final min = minValue - pad;
  final max = maxValue + pad;
  return (min: min, max: max, interval: (max - min) / 4);
}
