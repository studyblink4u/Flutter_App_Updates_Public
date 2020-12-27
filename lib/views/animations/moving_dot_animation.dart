import 'package:codm/screenSize.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class MovingDot {
  List<Widget> dots = [];

  List<Widget> getDots({int dotCount}) {
    if (dots.isNotEmpty) {
      return dots;
    } else {
      for (var i = 0; i < dotCount; i++) {
        dots.add(Dots(dx: math.Random().nextInt(ScreenSize.width.toInt()) + 1));
      }
      return dots;
    }
  }
}

class Dots extends StatefulWidget {
  final dx;
  Dots({this.dx});
  @override
  _DotsState createState() => _DotsState();
}

class _DotsState extends State<Dots> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double rt;

  Color randomColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(1.0);
  }

  Duration randomDuration() {
    return Duration(
      seconds: math.Random().nextInt(100) + 20,
    );
  }

  double randomSize() {
    return math.Random().nextInt(4).toDouble();
  }

  @override
  void initState() {
    super.initState();
    rt = randomSize();

    _controller = AnimationController(
      value: math.Random().nextInt(ScreenSize.height.toInt()).toDouble(),
      vsync: this,
      duration: randomDuration(),
      lowerBound: 0.0,
      upperBound: ScreenSize.height,
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.dx.toDouble(),
      top: _controller.value,
      child: Container(
        color: randomColor(),
        height: rt,
        width: rt,
      ),
    );
  }
}
