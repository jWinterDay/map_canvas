import 'dart:ui';

import 'package:map_canvas/src/figures/canvas_figure.dart';

class FigureUi {
  FigureUi({
    this.xPos = 0,
    this.yPos = 0,
    // required this.width,
    // required this.height,
    this.isDragging = false,
    required this.canvasFigure,
  });

  double xPos;
  double yPos;

  // final double width;
  // final double height;

  bool isDragging;

  CanvasFigure canvasFigure;

  void paint({
    required Canvas canvas,
    required Size size,
    required Offset offset,
  }) {
    canvasFigure.paint(
      canvas: canvas,
      size: size,
      xPos: xPos,
      yPos: yPos,
      width: canvasFigure.width,
      height: canvasFigure.height,
      offset: offset,
    );
  }

  bool calcIsDragging({
    required double cursorPositionX,
    required double cursorPositionY,
    required Offset offset,
  }) {
    return cursorPositionX >= (xPos + offset.dx) &&
        cursorPositionX <= (xPos + offset.dx) + canvasFigure.width &&
        cursorPositionY >= (yPos + offset.dy) &&
        cursorPositionY <= (yPos + offset.dy) + canvasFigure.height;
  }
}
