import 'dart:ui';

import 'package:map_canvas/src/figures/canvas_figure.dart';
import 'package:map_canvas/src/models/figure_ui.dart';

class CanvasArrow extends CanvasFigure {
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
    final Rect rect = Rect.fromLTWH(
      xPos + offset.dx,
      yPos + offset.dy,
      width,
      height,
    );

    canvas.drawOval(rect, Paint());
  }
}
