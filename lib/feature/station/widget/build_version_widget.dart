import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class BuildVersionWidget extends StatelessWidget {
  final String firmwareVersion;
  final String? stackId;
  const BuildVersionWidget({
    super.key,
    this.stackId,
    required this.firmwareVersion,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () {
        if (stackId != null) {
          PageTools.toVersion(stackId: stackId ?? '');
        }
      },
      child: Container(
        padding: EdgeInsetsDirectional.only(top: 6, bottom: 6),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "${LKey.stackFirmware.tr} $firmwareVersion",
                children: [
                  TextSpan(
                    style: TextStyle(color: Colors.blue, fontSize: 13),
                    text: " ${LKey.versionDetail.tr} →",
                  ),
                ],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
