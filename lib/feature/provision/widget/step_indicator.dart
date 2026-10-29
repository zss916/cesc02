import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/provision/widget/step_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

// ---------- 步进指示器 ----------
class StepIndicator extends StatelessWidget {
  final int step;
  const StepIndicator({super.key, required this.step});

  List<String> get steps => [
    LKey.openBlue.tr,
    LKey.connectDevice.tr,
    LKey.setWifi.tr,
    LKey.createSite.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: IntrinsicHeight(
        child: Row(
          children: List.generate(steps.length, (i) {
            final done = i < step;
            final active = i == step;
            return Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 2.5,
                          color: i == 0
                              ? Colors.transparent
                              : (done
                                    ? const Color(0xFF34C759)
                                    : const Color(0xFFE3E9F2)),
                        ),
                      ),
                      StepCircle(index: i + 1, done: done, active: active),
                      Expanded(
                        child: Container(
                          height: 2.5,
                          color: i == steps.length - 1
                              ? Colors.transparent
                              : (i < step
                                    ? const Color(0xFF34C759)
                                    : const Color(0xFFE3E9F2)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    margin: EdgeInsetsDirectional.symmetric(horizontal: 2),
                    child: Text(
                      steps[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                        color: active
                            ? const Color(0xFF3978F6)
                            : (done
                                  ? const Color(0xFF34C759)
                                  : const Color(0xFFA8B4C8)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
