// ---------- 通用样式工具 ----------
import 'package:cesc01/core/helper/tools.dart';
import 'package:flutter/material.dart';

InputDecoration inputDecoration({String? hint}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFA8B4C8)),
    filled: true,
    fillColor: const Color(0xFFF8FAFD),
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE3E9F2)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF3978F6)),
    ),
  );
}

InputDecoration inputScanDecoration({
  String? hint,
  BuildContext? context,
  Function(String)? onResult,
}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFA8B4C8)),
    filled: true,
    fillColor: const Color(0xFFF8FAFD),
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE3E9F2)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF3978F6)),
    ),
    suffixIcon: IconButton(
      icon: const Icon(Icons.qr_code_scanner_rounded),
      onPressed: () async {
        String value = await ScanTool.toScan(context: context!);
        onResult?.call(value);
      },
    ),
    // 可选：调整右侧图标的约束大小，避免图标过大或过小
    suffixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
  );
}

InputDecoration inputPsdDecoration({String? hint, Widget? suffixIcon}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFA8B4C8)),
    filled: true,
    fillColor: const Color(0xFFF8FAFD),
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE3E9F2)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF3978F6)),
    ),
    suffixIcon: suffixIcon,
  );
}
