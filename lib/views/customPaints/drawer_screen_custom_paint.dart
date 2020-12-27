import 'package:flutter/material.dart';

class DrawerScreenCustomPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var height = size.height;
    var width = size.width;

    Paint paint = Paint();
    Path path = Path();

    var gradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.topLeft,
      tileMode: TileMode.mirror,
      colors: [
        Colors.pink,
        Colors.purple,
        Colors.deepPurple,
      ],
    );

    var curveGradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      tileMode: TileMode.mirror,
      colors: [
        Colors.pink,
        Colors.purple,
        Colors.deepPurple,
        Colors.purple,
        Colors.pink,
      ],
    );
    var rect = Offset.zero & size;
    paint.shader = gradient.createShader(rect);

    path.moveTo(width, 0);
    path.lineTo(width, size.height * 0.10);
    path.quadraticBezierTo(size.width * 0.90, size.height * 0.20,
        size.width * 0.80, size.height * 0.07);
    path.quadraticBezierTo(size.width * 0.77, size.height * 0.04,
        size.width * 0.70, size.height * 0.07);
    path.quadraticBezierTo(size.width * 0.60, size.height * 0.10,
        size.width * 0.40, size.height * 0.07);
    path.quadraticBezierTo(
        size.width * 0.25, size.height * 0.05, size.width * 0.25, 0);
    path.close();
    canvas.drawPath(path, paint);

    var secondRect =
        Offset(0, height * 0.75) & Size(width * 0.75, height * 0.25);

    Paint prePaint = Paint();
    Path prePath = Path();

    prePath.moveTo(0, height * 0.7);
    prePath.cubicTo(
        0, height * 0.7, width * 0.25, height * 0.65, width * 0.75, height);
    prePath.lineTo(0, height);
    prePath.lineTo(0, height * 0.7);

    var preRect = Offset(0, height * 0.65) & Size(width * 0.75, height * 0.35);
    prePaint.shader = curveGradient.createShader(preRect);
    canvas.drawPath(prePath, prePaint);

    Paint secondPaint = Paint();
    Path secondPath = Path();

    secondPath.moveTo(0, height * 0.8);
    secondPath.cubicTo(
        0, height * 0.8, width * 0.25, height * 0.75, width * 0.75, height);

    secondPath.lineTo(0, height);
    secondPath.lineTo(0, height * 0.8);

    secondPaint.shader = curveGradient.createShader(secondRect);
    canvas.drawPath(secondPath, secondPaint);

    var thirdRect =
        Offset(0, height * 0.85) & Size(width * 0.75, height * 0.15);

    Paint thirdPaint = Paint();
    Path thirdPath = Path();

    thirdPath.moveTo(0, height * 0.9);
    thirdPath.cubicTo(
        0, height * 0.9, width * 0.25, height * 0.85, width * 0.75, height);
    thirdPath.lineTo(0, height);
    thirdPath.lineTo(0, height * 0.9);

    thirdPaint.shader = curveGradient.createShader(thirdRect);

    canvas.drawPath(thirdPath, thirdPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
