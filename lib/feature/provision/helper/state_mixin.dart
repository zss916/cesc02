import 'package:flutter/material.dart';

mixin AppStateMixin<T extends StatefulWidget> on State<T> {
  void safeSetState(VoidCallback fn) {
    if (mounted) setState(fn);
  }
}
