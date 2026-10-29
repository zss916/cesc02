import 'package:flutter/material.dart';

class AppBarAction extends StatelessWidget {
  final bool isShow;
  final VoidCallback onTap;
  const AppBarAction({super.key, required this.isShow, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          margin: EdgeInsetsDirectional.only(end: 10, bottom: 5),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              onTap.call();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4FB),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                color: Color(0xFF5B6B85),
                size: 20,
              ),
            ),
          ),
        ),
        if (isShow)
          Positioned(
            top: 0,
            right: 4,
            child: Container(
              width: 13,
              height: 13,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFE75252),
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
