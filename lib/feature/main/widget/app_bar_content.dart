import 'package:cesc01/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class AppBarContent extends StatelessWidget {
  const AppBarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color(0x332C78F4),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
            color: Colors.white,
            //color: const Color(0xFFF0F4FB),
            /*gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF62D5BD), Color(0xFF2C78F4)],
            ),*/
            borderRadius: BorderRadius.circular(11),
            /* border: const GradientBoxBorder(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF62D5BD), Color(0xFF2C78F4)],
              ),
              width: 1.5,
            ),*/
          ),
          child: Assets.icon.icLauncher.image(width: 30, height: 30),
        ),
      ],
    );
  }
}
