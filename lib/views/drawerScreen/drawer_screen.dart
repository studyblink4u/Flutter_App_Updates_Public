import 'package:codm/views/customPaints/drawer_screen_custom_paint.dart';
import 'package:codm/konstants.dart';
import 'package:codm/views/drawerScreen/drawer_content.dart';
import 'package:codm/views/drawerScreen/drawer_toggle_button.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  final double width;
  final double height;

  DrawerScreen({this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: width - 2.0,
                child: CustomPaint(
                  size: MediaQuery.of(context).size,
                  painter: DrawerScreenCustomPaint(),
                ),
              ),
              Container(
                padding: EdgeInsets.all(7.5),
                height: height * 0.65,
                width: width - 10.0,
                child: DrawerContent(height: height),
              ),
              Positioned(
                bottom: 10.0,
                left: width * 0.80,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: DrawerToggleButton(),
                ),
              )
            ],
          ),
          kFullHeightContainer,
        ],
      ),
    );
  }
}
