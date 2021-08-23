import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:map_canvas/src/figures/canvas_arrow.dart';
import 'package:map_canvas/src/figures/canvas_case.dart';
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

    final FigureUi firstFigure = FigureUi(xPos: 50, yPos: 50, canvasFigure: CanvasCase());
    final FigureUi secondFigure = FigureUi(xPos: 250, yPos: 150, canvasFigure: CanvasCase());
    final FigureUi relationFS = FigureUi(
      canvasFigure: CanvasArrow(
        from: firstFigure,
        to: secondFigure,
      ),
    );

    final FigureUi thirdFigure = FigureUi(xPos: 100, yPos: 250, canvasFigure: CanvasCase());
    final FigureUi relationFT = FigureUi(
      canvasFigure: CanvasArrow(
        from: firstFigure,
        to: thirdFigure,
      ),
    );

    _figuresSet = <FigureUi>{
      // f - s
      firstFigure,
      secondFigure,
      relationFS,

      // f - t
      thirdFigure,
      relationFT,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // settings
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _offset = Offset.zero;
                    });
                  },
                  icon: const Icon(Icons.center_focus_strong),
                  label: const Text('Center'),
                ),
              ),
            ),
          ],
        ),

        // canvas
        Expanded(
          child: GestureDetector(
            onPanStart: (DragStartDetails details) {
              for (final FigureUi figure in _figuresSet) {
                figure.isDragging = figure.calcIsDragging(
                  cursorPositionX: details.localPosition.dx,
                  cursorPositionY: details.localPosition.dy,
                  offset: _offset,
                );
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
            child: ColoredBox(
              color: Colors.white,
              child: CustomPaint(
                painter: _FiguresPainter(
                  figuresSet: _figuresSet,
                  offset: _offset,
                ),
                child: const SizedBox.expand(),
              ),
            ),
          ),
        ),
      ],
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
      figure.paint(
        canvas: canvas,
        size: size,
        offset: offset,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
