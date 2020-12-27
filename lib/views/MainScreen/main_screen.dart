import 'package:codm/konstants.dart';
import 'package:codm/views/MainScreen/main_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../animations/menu_bar_translate_animation.dart';
import '../customPaints/main_screen_custom_paint.dart';
import 'package:codm/views/loadingScreens/hanging_light.dart';

class MainScreen extends StatelessWidget {
  final double height;
  final double width;
  final toggle;

  MainScreen({this.height, this.width, this.toggle});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<FetchData>(builder: (context, value, child) {
          return value.getLoadingStatus ? HangingLight() : Container();
        }),
        Container(
          child: CustomPaint(
            size: MediaQuery.of(context).size,
            painter: MainScreenCustomPaint(),
          ),
        ),
        Positioned(
          top: height * 0.05,
          width: width * 0.17,
          child: GestureDetector(
            onTap: toggle,
            child: MenuBarTranslateAnimation(
              width: width,
              height: height,
            ),
          ),
        ),
        MainScreenContent(
          height: height,
          width: width,
        ),
      ],
    );
  }
}
