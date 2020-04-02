import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:zoom_widget/zoom_widget.dart';

class MyPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
class AnnotationPage extends StatefulWidget {
  @override
  _AnnotationPageState createState() => _AnnotationPageState();
}

class _AnnotationPageState extends State<AnnotationPage> {
//  @override
//  Widget build(BuildContext context) {
//    SystemChrome.setPreferredOrientations([
//      DeviceOrientation.landscapeLeft,
//      DeviceOrientation.landscapeRight,
//    ]);
//    return Scaffold(
//      backgroundColor: Colors.white,
//      body: Container(
//          child: Center(
//            child: SizedBox(
//              height: 100,
//              width: 100,
//              child: PhotoView(
//                imageProvider: AssetImage("./assets/images/forest.jpg"),
//              ),
//            ),
//          )
//      )
//    );
//  }
//}
  List<Offset> points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    final Container sketchArea = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/forest.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      margin: EdgeInsets.all(1.0),
      alignment: Alignment.topLeft,
      //color: Colors.blueGrey[50],
      child: CustomPaint(
        painter: Sketcher(points),
      ),
    );

    return Scaffold(
//      appBar: AppBar(
//        title: Text('Sketcher'),
//      ),
      //backgroundColor: Image.asset("./assets/images/forest.jpg").color,
      body: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            RenderBox box = context.findRenderObject();
            Offset point = box.globalToLocal(details.globalPosition);
            point = point.translate(0.0, 0);

            points = List.from(points)..add(point);
          });
        },
        onPanEnd: (DragEndDetails details) {
          points.add(null);
        },
        child: sketchArea,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'clear Screen',
        backgroundColor: Colors.red,
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() => points.clear());
        },
      ),
    );
  }
}

//void drawRect(Rect rect, Paint paint) {
//  assert(_rectIsValid(rect));
//  assert(paint != null);
//  _drawRect(rect.left, rect.top, rect.right, rect.bottom,
//      paint._objects, paint._data);
//}

class Sketcher extends CustomPainter {
  final List<Offset> points;

  Sketcher(this.points);

  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return oldDelegate.points != points;
  }


  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue.withOpacity(0.5)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

//    for (int i = 0; i < points.length - 1; i++) {
//      if (points[i] != null && points[i + 1] != null) {
//        canvas.drawLine(points[i], points[i + 1], paint);
//      }
//    }
    if(points.length>=2) {
      //canvas.drawLine(points[0], points[points.length - 1], paint);
        int last=points.length -1;
        while(last>=1 && points[last]==null){
          last--;
        }
        double x1, x2, y1, y2;
        Rect r;
        x1 = points[0].dx;
        y1 = points[0].dy;
        x2 = points[last].dx;
        y2 = points[last].dy;

        Offset o=new Offset(min(x1,x2),min(y1,y2));  //we determine the top left point this way
        r = o & Size((x1 - x2).abs(), (y1 - y2).abs()); //creates rectangle using top left point and size
        canvas.drawRect(r, paint);

//        if (y2 > y1 && x2 > x1) {
//          r = points[0] & Size((x1 - x2).abs(), (y1 - y2).abs());
//          //print(points[0]);
//          canvas.drawRect(r, paint);
//        }
//        if (y2 < y1 && x2 < x1) {
//          r = points[last] & Size((x1 - x2).abs(), (y1 - y2).abs());
//          canvas.drawRect(r, paint);
//        }
//        if (y2 > y1 && x2 < x1) {
//          Offset o=new Offset(x2,y1);
//
//          r = o & Size((x1 - x2).abs(), (y1 - y2).abs());
//          canvas.drawRect(r, paint);
//        }
//        if (y2 < y1 && x2 > x1) {
//          Offset o=new Offset(x1,y2);
//
//          r = o & Size((x1 - x2).abs(), (y1 - y2).abs());
//          canvas.drawRect(r, paint);
//        }
        //print("right");
       // print(points);



      //Offset t=points[0];

    }
  }
}
