import 'package:flutter/material.dart';

class KfontStyleModel {
  late String title;
  late TextStyle textStyle;
  late double left;
  late double top;
   double? scaleFactor;
   double? baseScaleFactor;
   double? rotation;
  KfontStyleModel({
    required this.title,
    required this.textStyle,
    required this.left,
    required this.top,
    this.scaleFactor = 1.0,
    this.baseScaleFactor = 1.0,
    this.rotation = 0.0
  });
}
