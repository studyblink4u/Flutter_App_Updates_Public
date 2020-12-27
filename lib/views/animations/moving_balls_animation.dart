import 'package:codm/screenSize.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class MovingBalls {
  List<Widget> balls = [];

  List<Widget> getBalls({int ballCount}) {
    if (balls.isNotEmpty) {
      return balls;
    } else {
      for (var i = 0; i < ballCount / 2; i++) {
        balls.add(Balls(
            dx: math.Random().nextInt((ScreenSize.width * 0.15).toInt()) +
                (ScreenSize.width * 0.85).toInt()));
        balls.add(Balls(
            dx: math.Random().nextInt((ScreenSize.width * 0.07).toInt())));
      }
      return balls;
    }
  }
}

class Balls extends StatefulWidget {
  final dx;

  Balls({this.dx});

  @override
  _BallsState createState() => _BallsState();
}

class _BallsState extends State<Balls> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: randomDuration(),
        value: math.Random().nextInt(ScreenSize.height.toInt()).toDouble(),
        lowerBound: 0.0,
        upperBound: ScreenSize.height);
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Duration randomDuration() {
    return Duration(
      seconds: math.Random().nextInt(120) + 60,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) => Positioned(
        left: widget.dx.toDouble(),
        top: _animationController.value - 50.0,
        child: Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.pink.withOpacity(0.4),
                    offset: Offset(0.0, 5.0),
                    blurRadius: 5.0,
                    spreadRadius: 0.0),
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.3),
                  offset: Offset(0.0, -5.0),
                  blurRadius: 5.0,
                )
              ],
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.pinkAccent.withOpacity(0.5),
                  Colors.purpleAccent.withOpacity(0.5),
                  Colors.purple.withOpacity(0.5),
                  Colors.deepPurple.withOpacity(0.4),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )),
        ),
      ),
    );
  }
}
