import 'package:flutter/material.dart';

class AppPageLoading extends StatelessWidget {
  const AppPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeCap: StrokeCap.round,
        color: Color(0xFF3978F6),
      ),
    );
  }
}
