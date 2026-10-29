import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/feature/provision/widget/field_label.dart';
import 'package:cesc01/feature/provision/widget/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class InputSn extends StatelessWidget {
  final TextEditingController snCtr;
  final Function(String) onNext;
  const InputSn({super.key, required this.snCtr, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FieldLabel(LKey.snTitle.tr),
        TextField(
          controller: snCtr,
          style: const TextStyle(fontSize: 14, color: Color(0xFF172033)),
          cursorColor: const Color(0xFF3978F6),
          decoration: inputScanDecoration(
            hint: LKey.snHint.tr,
            context: context,
            onResult: (value) {
              snCtr.text = value;
              onNext.call(value);
            },
          ),
          onTapOutside: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onSubmitted: (value) {
            onNext.call(value);
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onEditingComplete: () {
            onNext.call(snCtr.text.toString());
          },
          onChanged: (value) {
            onNext.call(value);
          },
        ),
        Divider(height: 16, color: Colors.transparent),
      ],
    );
  }
}
