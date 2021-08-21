import 'dart:ui';

class FigureUi {
  FigureUi({
    this.xPos = 0,
    this.yPos = 0,
    required this.width,
    required this.height,
    this.isDragging = false,
  });

  double xPos;
  double yPos;

  final double width;
  final double height;

  bool isDragging;

  bool calcIsDragging({
    required double cursorPositionX,
    required double cursorPositionY,
    required Offset offset,
  }) {
    return cursorPositionX >= (xPos + offset.dx) &&
        cursorPositionX <= (xPos + offset.dx) + width &&
        cursorPositionY >= (yPos + offset.dy) &&
        cursorPositionY <= (yPos + offset.dy) + height;
  }
}
