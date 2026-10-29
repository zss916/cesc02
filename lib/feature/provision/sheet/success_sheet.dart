import 'package:cesc01/core/translations/lan_key.dart';
import 'package:cesc01/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void toSuccessfulSheet({required String title, Function? onNext}) {
  showSuccessSheet(
    title: title,
    content: "",
    name: "",
    onConfirm: () {
      onNext?.call();
    },
  );
}

// ---------- 成功弹层 ----------
void showSuccessSheet({
  required String name,
  required String title,
  required String content,
  Function? onConfirm,
}) {
  if (Get.isBottomSheetOpen == true && (Get.containName(name))) {
    return;
  }
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: Color(0xFFE7F8EE),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              size: 36,
              color: Color(0xFF34C759),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: Color(0xFF172033),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF6F7D92),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Get.back<void>();
                onConfirm?.call();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3978F6),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                LKey.confirm.tr,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
    settings: RouteSettings(name: name),
  );
}
