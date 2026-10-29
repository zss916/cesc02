import 'package:flutter/material.dart';

/*enum AlarmStatus2 {
  ///严重
  severe(value: 1, symbol: LKey.serious, color: Color(0xFFE75252)),

  ///重要
  important(value: 2, symbol: LKey.important, color: Color(0xFFEF8F32)),

  ///一般
  general(value: 3, symbol: LKey.general, color: Color(0xFF3978F6));

  final int value;
  final String symbol;
  final Color color;

  const AlarmStatus2({
    required this.value,
    required this.symbol,
    required this.color,
  });

  static String getSymbol(int value) =>
      AlarmStatus2.values.firstWhere((e) => e.value == value).symbol;
}*/

class AlarmStatusWidget extends StatelessWidget {
  final Color color;
  final String title;
  const AlarmStatusWidget({
    super.key,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
