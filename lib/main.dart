import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InfiniteCanvasPage(),
    );
  }
}

enum CanvasState { pan, draw }

class InfiniteCanvasPage extends StatefulWidget {
  @override
  _InfiniteCanvasPageState createState() => _InfiniteCanvasPageState();
}

class _InfiniteCanvasPageState extends State<InfiniteCanvasPage> {
  List<Offset> points = <Offset>[];
  CanvasState canvasState = CanvasState.draw;
  Offset offset = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text(canvasState == CanvasState.draw ? 'Draw' : 'Pan'),
        backgroundColor: canvasState == CanvasState.draw ? Colors.red : Colors.blue,
        onPressed: () {
          this.setState(() {
            canvasState = canvasState == CanvasState.draw ? CanvasState.pan : CanvasState.draw;
          });
        },
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: CustomPaint(
            painter: MyCanvasView(),
            size: Size(width, height * 2),
          ),
        ),
      ),
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
    );
  }
}

class MyCanvasView extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    paint.shader = const LinearGradient(
      colors: [Colors.yellow, Colors.redAccent],
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
    ).createShader(const Offset(0, 0) & size);

    canvas.drawRect(const Offset(0, 0) & size, paint);
    final Path path = Path();

    path.moveTo(0, size.height);
    path.lineTo(1 * size.width / 4, 0 * size.height / 4);
    path.lineTo(2 * size.width / 4, 2 * size.height / 4);
    path.lineTo(3 * size.width / 4, 0 * size.height / 4);
    path.lineTo(4 * size.width / 4, 4 * size.height / 4);
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.yellow
        ..strokeWidth = 4.0
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MapCustomPainter extends CustomPainter {
  MapCustomPainter({
    required this.points,
    required this.offset,
    required this.canvasState,
  });

  List<Offset> points;
  Offset offset;
  CanvasState canvasState;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint background = Paint()..color = Colors.white70;

    //define canvas size
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height - 20);

    canvas.drawRect(rect, background);
    canvas.clipRect(rect);

    //define the paint properties to be used for drawing
    final Paint drawingPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..color = Colors.black
      ..strokeWidth = 1;

    //a single line is defined as a series of points followed by a null at the end
    for (int x = 0; x < points.length - 1; x++) {
      //drawing line between the points to form a continuous line
      // if (points[x]&& points[x + 1] != null) {
      canvas.drawLine(points[x] + offset, points[x + 1] + offset, drawingPaint);
      // }
      //if next point is null, means the line ends here
      // else if (points[x] != null && points[x + 1] == null) {
      //   canvas.drawPoints(PointMode.points, [points[x] + offset], drawingPaint);
      // }
    }

    // final Paint paint = Paint();
    // paint.shader = const LinearGradient(
    //   colors: [Colors.yellow, Colors.redAccent],
    //   begin: Alignment.centerRight,
    //   end: Alignment.centerLeft,
    // ).createShader(new Offset(0.0, 0.0) & size);

    // canvas.drawRect(new Offset(0.0, 0.0) & size, paint);

    // var path = new Path();

    // path.moveTo(0.0, size.height);
    // path.lineTo(1 * size.width / 4, 0 * size.height / 4);
    // path.lineTo(2 * size.width / 4, 2 * size.height / 4);
    // path.lineTo(3 * size.width / 4, 0 * size.height / 4);
    // path.lineTo(4 * size.width / 4, 4 * size.height / 4);
    // canvas.drawPath(
    //   path,
    //   Paint()
    //     ..color = Colors.yellow
    //     ..strokeWidth = 4.0
    //     ..style = PaintingStyle.stroke,
    // );
  }

  @override
  bool shouldRepaint(MapCustomPainter oldDelegate) {
    return true;
  }
}
