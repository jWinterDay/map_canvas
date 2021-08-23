import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:map_canvas/src/figures/canvas_figure.dart';
import 'package:map_canvas/src/models/figure_ui.dart';

class CanvasArrow implements CanvasFigure {
  CanvasArrow({
    required this.from,
    required this.to,
  });

  @override
  double width = 100;

  @override
  double height = 100;

  FigureUi from;

  FigureUi to;

  static const double _radius = 5;

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
    final Offset fromOffset = Offset(
      from.xPos + offset.dx + from.canvasFigure.width,
      from.yPos + offset.dy + from.canvasFigure.height / 2,
    );

    // line
    final Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..moveTo(fromOffset.dx, fromOffset.dy)
      ..lineTo(to.xPos + offset.dx, to.yPos + to.canvasFigure.height / 2 + offset.dy);
    canvas.drawPath(path, paint);

    // circle
    final Paint circlePaint = Paint()..color = Colors.green;
    canvas.drawCircle(
      fromOffset,
      _radius,
      circlePaint,
    );
  }
}
