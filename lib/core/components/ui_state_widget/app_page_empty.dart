import 'package:cesc01/core/event/app_event_bus.dart';
import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AppPageEmpty extends StatelessWidget {
  const AppPageEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        GestureDetector(
          onTap: () {
            AppEventBus.eventBus.fire(NetWorkRefresh());
          },
          child: Container(
            padding: EdgeInsetsDirectional.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.icon.empty.image(
                  color: Color(0xFF3978F6),
                  width: 80,
                  height: 80,
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsetsDirectional.only(
                    start: 12,
                    end: 12,
                    top: 2,
                    bottom: 2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 2, color: Color(0xFF3978F6)),
                  ),
                  child: Text(
                    LKey.refresh.tr,
                    style: TextStyle(fontSize: 16, color: Color(0xFF3978F6)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
