import 'package:cesc01/core/translations/lan_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:radar_animation_widget/radar_animation_widget.dart';

Widget get loading => Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Container(
      margin: EdgeInsetsDirectional.only(bottom: 5, top: 60),
      width: 35,
      height: 35,
      child: CircularProgressIndicator(color: Colors.blue),
    ),
    Text(LKey.scanIng.tr, style: TextStyle(color: Colors.black)),
  ],
);

Widget get scanningWidget => Container(
  margin: EdgeInsetsDirectional.only(top: 10),
  alignment: AlignmentDirectional.center,
  width: 280,
  height: 280,
  child: RadarAnimationWidget(
    useLens: true,
    dimension: 300,
    backgroundColor: Colors.black,
    duration: const Duration(seconds: 10),
    numberPoints: 2,
    pointRadius: 5,
    pointColor: Colors.blue,
    sectorColor: Colors.green,
    paintSector: true,
    gridColor: Colors.green,
    gridStrokeWidth: 1,
    gridCircleCount: 6,
    gridCircleLinesCount: 12,
    waveStrokeWidth: 5,
    waveColor: Colors.green,
    waveCount: 3,
    radarLineStrokeWidth: 3,
    radarLineColor: Colors.green,
    centerDotRadius: 5,
    centerDotColor: Colors.green,
    lensColor: Colors.cyan,
    borderColor: Colors.white70,
    lensBlur: 0.4,
    lensGlow: true,
  ),
);
