import 'package:flutter/material.dart';

class AppPageTitle extends StatelessWidget {
  final String title;
  final String? subTitle;
  const AppPageTitle({super.key, required this.title, this.subTitle});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF172033),
            ),
          ),
          if ((subTitle ?? "").isNotEmpty) SizedBox(height: 4),
          if ((subTitle ?? "").isNotEmpty)
            Text(
              subTitle ?? "",
              style: TextStyle(fontSize: 13, color: Color(0xFF6F7D92)),
            ),
        ],
      ),
    );
  }
}
