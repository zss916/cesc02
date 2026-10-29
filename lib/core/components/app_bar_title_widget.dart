import 'package:flutter/material.dart';

class AppBarTitleWidget extends StatelessWidget {
  final String title;
  const AppBarTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(color: Colors.black, fontSize: 18));
  }
}
