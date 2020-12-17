import 'package:flutter/material.dart';

class ScreenSize {
  static Size gotSize;
  ScreenSize({Size size}) {
    gotSize = size;
  }
  static double pp = gotSize.aspectRatio;
  static double height = gotSize.height * pp;
  static double width = gotSize.width * pp;
}
