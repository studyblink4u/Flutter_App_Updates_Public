import 'package:codm/views/customPaints/hanging_light_custom_paint.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vmath;

class HangingLightAnimation extends StatefulWidget {
  @override
  _HangingLightAnimationState createState() => _HangingLightAnimationState();
}

class _HangingLightAnimationState extends State<HangingLightAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
      reverseDuration: Duration(seconds: 3),
      upperBound: 1,
      lowerBound: 0,
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: vmath.radians(animation.value * 60 - 30.0),
      origin: Offset(0, -MediaQuery.of(context).size.height / 2),
      child: Center(
        child: CustomPaint(
          size: MediaQuery.of(context).size,
          painter: HangingLightCustomPaint(),
        ),
      ),
    );
  }
}
