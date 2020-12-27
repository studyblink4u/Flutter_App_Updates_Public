import 'package:flutter/material.dart';

class HangingLightCustomPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final offset = Offset(size.width / 2, size.height / 2);

    Paint hangingWirePaint = Paint();
    hangingWirePaint.color = Colors.blue;
    hangingWirePaint.style = PaintingStyle.stroke;
    hangingWirePaint.strokeWidth = 10.0;
    Path hangingWirePath = Path();

    hangingWirePath.moveTo(size.width / 2, 0);
    hangingWirePath.lineTo(size.width / 2, size.height * 0.25);

    canvas.drawPath(hangingWirePath, hangingWirePaint);

    Paint lightFramePaint = Paint();
    lightFramePaint.color = Colors.orangeAccent;
    lightFramePaint.style = PaintingStyle.fill;
    lightFramePaint.strokeWidth = 5.0;
    Path lightFramePath = Path();

    lightFramePath.addPolygon([
      Offset((size.width / 2 - 20.0), size.height * 0.25),
      Offset((size.width / 2 + 20.0), size.height * 0.25),
      Offset((size.width / 2 + 40.0), (size.height * 0.25 + 40.0)),
      Offset((size.width / 2 - 40.0), (size.height * 0.25 + 40.0)),
    ], true);

    canvas.drawPath(lightFramePath, lightFramePaint);

    Paint lightPaint = Paint();
    lightPaint.style = PaintingStyle.fill;
    lightPaint.color = Colors.yellow;

    lightPaint.maskFilter = MaskFilter.blur(BlurStyle.inner, 0.0);
    Path lightPath = Path();

    lightPath.moveTo((size.width / 2 - 40.0), (size.height * 0.25 + 40.0));
    lightPath.lineTo(size.width / 2 - 80.0, size.height * 0.8);
    lightPath.quadraticBezierTo(size.width / 2, size.height * 0.85,
        size.width / 2 + 80.0, size.height * 0.8);
    lightPath.lineTo((size.width / 2 + 40.0), (size.height * 0.25 + 40.0));

    canvas.drawPath(lightPath, lightPaint);
    // textPainter.paint(canvas, offset);

    Paint bulpPaint = Paint();
    bulpPaint.color = Colors.deepOrange;
    bulpPaint.style = PaintingStyle.fill;
    bulpPaint.maskFilter = MaskFilter.blur(BlurStyle.inner, 5.0);

    Path bulpPath = Path();
    bulpPath.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height * 0.25 + 45.0),
        radius: 10.0));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
