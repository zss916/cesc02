import 'package:flutter/material.dart';

mixin TextEditCtrlHelper {
  final accountCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  bool get canSubmit =>
      accountCtrl.text.trim().isNotEmpty && passwordCtrl.text.isNotEmpty;

  void disposeTextEditHelper() {
    accountCtrl.dispose();
    passwordCtrl.dispose();
  }
}
