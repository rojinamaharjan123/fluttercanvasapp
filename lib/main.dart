import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MyCanvas(),
      debugShowCheckedModeBanner: false,
    ));

class MyCanvas extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => Scaffold(body: BasicDrawing());
}

class BasicDrawing extends StatefulWidget {
  @override
  _BasicDrawingState createState() => _BasicDrawingState();
}

class _BasicDrawingState extends State<BasicDrawing> {
  List<Offset> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Canvas"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              RenderBox referenceBox = context.findRenderObject();
              Offset localPosition =
                  referenceBox.globalToLocal(details.globalPosition);
              _points = List.from(_points)..add(localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
          child: CustomPaint(
            painter: BasicDrawingEx(_points),
            size: Size.infinite,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(
          Icons.clear,
          color: Colors.white70,
        ),
        onPressed: () {
          _points.clear();
        },
      ),
    );
  }
}

class BasicDrawingEx extends CustomPainter {
  BasicDrawingEx(this.points);

  final List<Offset> points;

  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if ((points[i] != null) && (points[i + 1] != null))
        canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  bool shouldRepaint(BasicDrawingEx other) => other.points != points;
}
