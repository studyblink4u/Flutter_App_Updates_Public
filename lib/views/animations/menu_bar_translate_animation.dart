import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

class MenuBarTranslateAnimation extends StatefulWidget {
  final double height;
  final double width;

  MenuBarTranslateAnimation({
    this.width,
    this.height,
  });

  @override
  _MenuBarTranslateAnimationState createState() =>
      _MenuBarTranslateAnimationState();
}

class _MenuBarTranslateAnimationState extends State<MenuBarTranslateAnimation> {
  String flutterAnimation;
  final FlareControls controls = FlareControls();

  @override
  void initState() {
    super.initState();
    flutterAnimation = 'rotate left';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height * 0.05,
      width: widget.width * 0.1,
      child: FlareActor(
        'assets/flare/menu_bar_translate.flr',
        animation: flutterAnimation,
        controller: controls,
        callback: (string) {
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              flutterAnimation =
                  string == 'rotate right' ? 'rotate left' : 'rotate right';
            });
          });
        },
      ),
    );
  }
}
