import 'package:codm/views/animations/moving_balls_animation.dart';
import 'package:codm/views/animations/moving_dot_animation.dart';
import 'package:codm/konstants.dart';
import 'package:codm/screenSize.dart';
import 'package:codm/views/drawerScreen/drawer_screen.dart';
import 'file:///D:/Flutter/codm/lib/views/MainScreen/main_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ChangeModeProvider()),
      ChangeNotifierProvider(create: (context) => FetchData())
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize(size: WidgetsBinding.instance.window.physicalSize);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  MovingDot classMovingDots = MovingDot();
  List<Widget> dots;
  List<Widget> balls;
  AnimationController _animationController;
  bool _canBeDragged = false;
  double maxSlide = 300.0;

  @override
  void initState() {
    super.initState();
    dots = classMovingDots.getDots(dotCount: 300);
    balls = MovingBalls().getBalls(ballCount: 30);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        body: Container(
          child: GestureDetector(
            onHorizontalDragStart: _onDragStart,
            onHorizontalDragUpdate: _onDragUpdate,
            onHorizontalDragEnd: _onDragEnd,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, _) {
                return Stack(
                  children: [
                    Consumer<ChangeModeProvider>(
                        builder: (context, value, child) {
                      return Container(
                        color: value.getModeColor,
                        child: Stack(
                          children: value.mode ? dots : balls,
                        ),
                      );
                    }),
                    Transform.translate(
                      offset: Offset(
                          maxSlide * (_animationController.value - 1), 0),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(
                              math.pi / 2 * (1 - _animationController.value)),
                        alignment: Alignment.centerRight,
                        child: DrawerScreen(
                          width: maxSlide,
                          height: height,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset:
                          Offset(maxSlide * (_animationController.value), 0),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(
                              (-math.pi * 4 * _animationController.value / 9) +
                                  (0.0)),
                        alignment: Alignment.centerLeft,
                        child: MainScreen(
                          height: height,
                          width: width,
                          toggle: toggle,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed;
    bool isDragCloseFromRight = _animationController.isCompleted;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    //I have no idea what it means, copied from Drawer
    double _kMinFlingVelocity = 365.0;

    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }
}
