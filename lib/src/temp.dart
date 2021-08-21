  // List<Offset> points = <Offset>[];
  // CanvasState canvasState = CanvasState.draw;
  // Offset offset = const Offset(0, 0);

// body: Center(
      //   child: SingleChildScrollView(
      //     scrollDirection: Axis.vertical,
      //     child: CustomPaint(
      //       painter: MyCanvasView(),
      //       size: Size(width, height * 2),
      //     ),
      //   ),
      // ),
      // body: Center(
      //   child: SingleChildScrollView(
      //     scrollDirection: Axis.vertical,
      //     child: CustomPaint(
      //       painter: MyCanvasView(),
      //       size: Size(width, height * 2),
      //     ),
      //   ),
      // ),
      // body: GestureDetector(
      //   onPanDown: (DragDownDetails details) {
      //     this.setState(() {
      //       if (canvasState == CanvasState.draw) {
      //         points.add(details.localPosition - offset);
      //       }
      //     });
      //   },
      //   onPanUpdate: (DragUpdateDetails details) {
      //     this.setState(() {
      //       if (canvasState == CanvasState.pan) {
      //         offset += details.delta;
      //       } else {
      //         points.add(details.localPosition - offset);
      //       }
      //     });
      //   },
      //   onPanEnd: (DragEndDetails details) {
      //     this.setState(() {
      //       if (canvasState == CanvasState.draw) {
      //         // TODO
      //         // points.add(null);
      //       }
      //     });
      //   },
      //   child: SizedBox.expand(
      //     child: ClipRRect(
      //       child: CustomPaint(
      //         painter: MapCustomPainter(
      //           points: points,
      //           offset: offset,
      //           canvasState: canvasState,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
//     );
//   }
// }

// class MyCanvasView extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint();
//     paint.shader = const LinearGradient(
//       colors: [Colors.yellow, Colors.redAccent],
//       begin: Alignment.centerRight,
//       end: Alignment.centerLeft,
//     ).createShader(const Offset(0, 0) & size);

//     canvas.drawRect(const Offset(0, 0) & size, paint);
//     final Path path = Path();

//     path.moveTo(0, size.height);
//     path.lineTo(1 * size.width / 4, 0 * size.height / 4);
//     path.lineTo(2 * size.width / 4, 2 * size.height / 4);
//     path.lineTo(3 * size.width / 4, 0 * size.height / 4);
//     path.lineTo(4 * size.width / 4, 4 * size.height / 4);
//     canvas.drawPath(
//       path,
//       Paint()
//         ..color = Colors.yellow
//         ..strokeWidth = 4.0
//         ..style = PaintingStyle.stroke,
//     );
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

// class MapCustomPainter extends CustomPainter {
//   MapCustomPainter({
//     required this.points,
//     required this.offset,
//     required this.canvasState,
//   });

//   List<Offset> points;
//   Offset offset;
//   CanvasState canvasState;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint background = Paint()..color = Colors.white70;

//     //define canvas size
//     final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height - 20);

//     canvas.drawRect(rect, background);
//     canvas.clipRect(rect);

//     //define the paint properties to be used for drawing
//     final Paint drawingPaint = Paint()
//       ..strokeCap = StrokeCap.round
//       ..isAntiAlias = true
//       ..color = Colors.black
//       ..strokeWidth = 1;

//     //a single line is defined as a series of points followed by a null at the end
//     for (int x = 0; x < points.length - 1; x++) {
//       //drawing line between the points to form a continuous line
//       // if (points[x]&& points[x + 1] != null) {
//       canvas.drawLine(points[x] + offset, points[x + 1] + offset, drawingPaint);
//       // }
//       //if next point is null, means the line ends here
//       // else if (points[x] != null && points[x + 1] == null) {
//       //   canvas.drawPoints(PointMode.points, [points[x] + offset], drawingPaint);
//       // }
//     }

//     // final Paint paint = Paint();
//     // paint.shader = const LinearGradient(
//     //   colors: [Colors.yellow, Colors.redAccent],
//     //   begin: Alignment.centerRight,
//     //   end: Alignment.centerLeft,
//     // ).createShader(new Offset(0.0, 0.0) & size);

//     // canvas.drawRect(new Offset(0.0, 0.0) & size, paint);

//     // var path = new Path();

//     // path.moveTo(0.0, size.height);
//     // path.lineTo(1 * size.width / 4, 0 * size.height / 4);
//     // path.lineTo(2 * size.width / 4, 2 * size.height / 4);
//     // path.lineTo(3 * size.width / 4, 0 * size.height / 4);
//     // path.lineTo(4 * size.width / 4, 4 * size.height / 4);
//     // canvas.drawPath(
//     //   path,
//     //   Paint()
//     //     ..color = Colors.yellow
//     //     ..strokeWidth = 4.0
//     //     ..style = PaintingStyle.stroke,
//     // );
//   }

//   @override
//   bool shouldRepaint(MapCustomPainter oldDelegate) {
//     return true;
//   }
// }

// // ===========
// class CustomPainterDraggable extends StatefulWidget {
//   @override
//   _CustomPainterDraggableState createState() => _CustomPainterDraggableState();
// }

// class _CustomPainterDraggableState extends State<CustomPainterDraggable> {
//   double xPos = 0;
//   double yPos = 0;
//   final double width = 50;
//   final double height = 100;
//   bool _dragging = false;

//   /// Is the point (x, y) inside the rect?
//   bool _insideRect(double x, double y) {
//     return x >= xPos && x <= xPos + width && y >= yPos && y <= yPos + height;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onPanStart: (DragStartDetails details) {
//         _dragging = _insideRect(
//           details.globalPosition.dx,
//           details.globalPosition.dy,
//         );
//       },
//       onPanEnd: (DragEndDetails details) {
//         _dragging = false;
//       },
//       onPanUpdate: (DragUpdateDetails details) {
//         if (_dragging) {
//           setState(() {
//             xPos += details.delta.dx;
//             yPos += details.delta.dy;
//           });
//         }
//       },
//       child: Container(
//         color: Colors.white,
//         child: CustomPaint(
//           painter: RectanglePainter(Rect.fromLTWH(xPos, yPos, width, height)),
//           child: Container(),
//         ),
//       ),
//     );
//   }
// }

// class RectanglePainter extends CustomPainter {
//   RectanglePainter(this.rect);
//   final Rect rect;

//   @override
//   void paint(Canvas canvas, Size size) {
//     canvas.drawRect(rect, Paint());
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }
