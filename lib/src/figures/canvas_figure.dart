import 'dart:ui';

abstract class CanvasFigure {
  void paint({
    required Canvas canvas,
    required Size size,
    required double xPos,
    required double yPos,
    required double width,
    required double height,
    required Offset offset,
  });
}
