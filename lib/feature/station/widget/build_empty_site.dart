import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class BuildEmptySite extends StatelessWidget {
  const BuildEmptySite({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.icon.empty.image(
              color: Color(0xFF3978F6),
              width: 80,
              height: 80,
            ),
            SizedBox(height: 10),
            Text(
              LKey.emptyTip.tr,
              style: TextStyle(
                color: Color(0xFF3978F6),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
