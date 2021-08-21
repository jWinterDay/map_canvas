import 'package:flutter/material.dart';
import 'package:map_canvas/src/canvas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Map canvas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Map canvas'),
        ),
        body: CustomPainterDraggable(),
      ),
    );
  }
}
