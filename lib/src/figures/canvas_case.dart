// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:map_canvas/src/figures/canvas_figure.dart';

class CanvasCase implements CanvasFigure {
  @override
  double width = 100;

  @override
  double height = 150;

  static const double _radius = 25;
  static const double _headerOffset = 50;

  @override
  void paint({
    required Canvas canvas,
    required Size size,
    required double xPos,
    required double yPos,
    required double width,
    required double height,
    required Offset offset,
  }) {
    // 1
    // final Rect rect = Rect.fromLTWH(
    //   xPos + offset.dx,
    //   yPos + offset.dy,
    //   width,
    //   height,
    // );

    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke;

    // canvas.drawRect(rect, paint1);

    //
    // final path = Path()
    //   ..moveTo(offset.dx, offset.dy)
    //   ..lineTo(width + offset.dx, offset.dy)
    //   ..lineTo(width + offset.dx, height + offset.dy)
    //   ..lineTo(offset.dx, height + offset.dy)
    //   ..lineTo(offset.dx, offset.dy);
    // canvas.drawPath(path, paint1);

    //
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          xPos + offset.dx,
          yPos + offset.dy,
          width,
          height,
        ),
        const Radius.circular(_radius),
      ),
      paint,
    );

    canvas.drawLine(
      Offset(xPos + offset.dx, yPos + offset.dy + _headerOffset),
      Offset(xPos + offset.dx + width, yPos + offset.dy + _headerOffset),
      paint,
    );

    // 3
    // final Path path = Path();
    // var roundnessFactor = 30.0;

    // path.moveTo(offset.dx, height * 0.33);
    // path.lineTo(offset.dx, height - roundnessFactor);
    // path.quadraticBezierTo(offset.dx, height, roundnessFactor, height);
    // path.lineTo(width + offset.dx - roundnessFactor, height);
    // path.quadraticBezierTo(width, height, width, height - roundnessFactor);
    // path.lineTo(width, roundnessFactor * 2);
    // path.quadraticBezierTo(width - 10, roundnessFactor, width - roundnessFactor * 1.5, roundnessFactor * 1.5);
    // path.lineTo(roundnessFactor * 0.6, height * 0.33 - roundnessFactor * 0.3);
    // path.quadraticBezierTo(0, height * 0.33, 0, height * 0.33 + roundnessFactor);

    // canvas.drawPath(path, Paint()..color = Colors.red);
    // clipPath(path);
  }
}
