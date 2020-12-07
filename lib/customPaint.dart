import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreenTopCustomPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    var gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.topRight,
      tileMode: TileMode.mirror,
      colors: [
        Colors.pink,
        Colors.purple,
        Colors.deepPurple,
      ],
    );
    var rect = Offset.zero & size;
    paint.shader = gradient.createShader(rect);

    path.lineTo(0, size.height * 0.10);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.20,
        size.width * 0.20, size.height * 0.07);
    path.quadraticBezierTo(size.width * 0.23, size.height * 0.04,
        size.width * 0.30, size.height * 0.07);
    path.quadraticBezierTo(size.width * 0.40, size.height * 0.10,
        size.width * 0.60, size.height * 0.07);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.05, size.width * 0.75, 0);
    path.close();
    canvas.drawPath(path, paint);

    Path secondPath = Path();
    Paint secondPaint = Paint();
    var secondGradient = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.bottomRight,
      tileMode: TileMode.mirror,
      colors: [
        Colors.pink,
        Colors.purple,
        Colors.deepPurple,
      ],
    );
    secondPaint.color = Colors.red;
    secondPaint.style = PaintingStyle.fill;
    secondPaint.shader = secondGradient.createShader(rect);

    secondPath.moveTo(size.width, size.height * 0.30);
    secondPath.quadraticBezierTo(size.width * 0.90, size.height * 0.40,
        size.width * 0.95, size.height * 0.40);
    secondPath.quadraticBezierTo(
        size.width, size.height * 0.34, size.width * 0.97, size.height * 0.40);
    secondPath.quadraticBezierTo(size.width * 0.95, size.height * 0.45,
        size.width * 0.90, size.height * 0.55);
    secondPath.quadraticBezierTo(
        size.width * 0.85, size.height * 0.70, size.width, size.height * 0.70);

    canvas.drawPath(secondPath, secondPaint);

    Path thirdPath = Path();
    Paint thirdPaint = Paint();
    thirdPaint.color = Colors.red;

    thirdPath.moveTo(size.width * 0.80, 0);
    thirdPath.quadraticBezierTo(
        size.width * 0.90, size.height * 0.03, size.width * 0.98, 0);
    thirdPath.moveTo(size.width, 0);
    thirdPath.moveTo(size.width, size.height * 0.05);
    thirdPath.quadraticBezierTo(
        size.width * 0.94, size.height * 0.2, size.width, size.height * 0.2);
    thirdPaint.shader = secondGradient.createShader(rect);
    canvas.drawPath(thirdPath, thirdPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
