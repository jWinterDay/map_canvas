import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:map_canvas/src/models/figure_ui.dart';

const double kRectWidth = 100;
const double kRectHeight = 100;

class CustomPainterDraggable extends StatefulWidget {
  @override
  _CustomPainterDraggableState createState() => _CustomPainterDraggableState();
}

class _CustomPainterDraggableState extends State<CustomPainterDraggable> {
  Set<FigureUi> _figuresSet = <FigureUi>{};
  Offset _offset = const Offset(0, 0);

  FigureUi? get _figureDragged {
    for (final FigureUi figure in _figuresSet) {
      if (figure.isDragging) {
        return figure;
      }
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    _figuresSet = <FigureUi>{
      FigureUi(width: 50, height: 50, xPos: 50, yPos: 50),
      FigureUi(width: 100, height: 50, xPos: 250, yPos: 250),
      FigureUi(width: 50, height: 50, xPos: 150, yPos: 50),
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (DragStartDetails details) {
        for (final FigureUi figure in _figuresSet) {
          final bool isDragging = figure.calcIsDragging(
            cursorPositionX: details.localPosition.dx,
            cursorPositionY: details.localPosition.dy,
            offset: _offset,
          );
          figure.isDragging = isDragging;
        }
      },
      onPanEnd: (DragEndDetails details) {
        for (final FigureUi figure in _figuresSet) {
          figure.isDragging = false;
        }
      },
      onPanUpdate: (DragUpdateDetails details) {
        final FigureUi? draggedFigure = _figureDragged;

        if (draggedFigure == null) {
          _offset += details.delta;
          setState(() {});
          return;
        }

        setState(() {
          draggedFigure.xPos += details.delta.dx;
          draggedFigure.yPos += details.delta.dy;
        });
      },
      child: Container(
        color: Colors.white,
        child: CustomPaint(
          painter: _FiguresPainter(
            figuresSet: _figuresSet,
            offset: _offset,
          ),
          child: Container(),
        ),
      ),
    );
  }
}

class _FiguresPainter extends CustomPainter {
  _FiguresPainter({
    required this.figuresSet,
    required this.offset,
  });

  final Set<FigureUi> figuresSet;
  final Offset offset;

  @override
  void paint(Canvas canvas, Size size) {
    for (final FigureUi figure in figuresSet) {
      final Rect rect = Rect.fromLTWH(
        figure.xPos + offset.dx,
        figure.yPos + offset.dy,
        figure.width,
        figure.height,
      );

      canvas.drawRect(rect, Paint());
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
