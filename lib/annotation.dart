import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:collection/collection.dart';
import 'package:zoom_widget/zoom_widget.dart';

Function deepEq = const DeepCollectionEquality().equals;

class AnnotationPage extends StatefulWidget {
  @override
  _AnnotationPageState createState() => _AnnotationPageState();
}

List colors = [
  Colors.red,
  Colors.green,
  Colors.yellow,
  Colors.purple,
  Colors.pink,
  Colors.orange,
  Colors.blue,
  Colors.brown,
  Colors.lightGreen,
  Colors.lightBlue
];
Random random = new Random();

int colorIndex = random.nextInt(10);
String dropdownValue = 'One';

List<int> labelColors = [0];
List<String> labelNames=[];

class _AnnotationPageState extends State<AnnotationPage> {
  List<List<Offset>> points = <List<Offset>>[];
  //List<Offset> current = <Offset>[];
  int ind = 0;
  double wid, hei;
  double topDown,side;
  void changeIndex() {
    setState(() => colorIndex = random.nextInt(10));
  }

  @override
  Widget build(BuildContext context) {
    wid = MediaQuery.of(context).size.width;
    hei = MediaQuery.of(context).size.height;

    FittedSizes sizes = applyBoxFit(BoxFit.contain, Size(845,450),  Size(0.8 * wid, hei));
    print(sizes.destination);
    topDown=(hei-sizes.destination.height)/2;
    side=(0.8*wid-sizes.destination.width)/2;
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    final Container sketchArea = Container(

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/doggy.jpg"),
          fit: BoxFit.contain,
          //alignment: Alignment(0, 1),
        ),
      ),
      //margin: EdgeInsets.all(1.0),
      alignment: Alignment.topLeft,
      //color: Colors.blueGrey[50],
      child: CustomPaint(
        painter: Sketcher(points, Size(0.8 * wid, hei),topDown,side),
      ),
    );


    return Scaffold(
//      appBar: AppBar(
//        title: Text('Sketcher'),
//      ),
      //backgroundColor: Image.asset("./assets/images/forest.jpg").color,
      body: Row(children: <Widget>[
        Expanded(
          flex: 8,
          child: GestureDetector(
            onPanUpdate: (DragUpdateDetails details) {
              setState(() {
                RenderBox box = context.findRenderObject();
                Offset point = box.globalToLocal(details.globalPosition);
                point = point.translate(0.0, 0);
                if (points == null || points.length < (ind + 1)) {
                  //print("adding");
                  points.add(<Offset>[]);
                  //print(points);
                  //print(point);
                }
                if (points[ind] != null && points[ind].length >= 2) {
                  points[ind][1] = point;
                } else {
                  points[ind].add(point);
                }
                //print(points);
              });
            },
            onPanEnd: (DragEndDetails details) {
              setState(() {
                if(points[ind].length<3) {
                  points[ind].add(null);
                  labelNames.add(dropdownValue);
                }
                else{
                  labelNames[ind]=dropdownValue;
                }
              });
            },
            child: sketchArea,
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: <Widget>[
              RaisedButton(
                shape: StadiumBorder(),
                onPressed: () {
                setState(() {
                  print("save ind was "+ind.toString());
                  changeIndex();
                  labelColors.add(colorIndex);
                  if (points[ind] != null && points[ind].length >= 2) {
                    ind += 1;
                    //current.clear();
                    points.add(<Offset>[]);
                    points[ind] = <Offset>[];
                    if (points[ind] != null) {
                      points[ind].clear();
                    }
                    //points[ind]=current;
                  } else if (points[ind] != null && points[ind].length == 1) {
                    //current.clear();
                    points[ind].clear();
                  }
                  print("save ind is "+ind.toString());
                });

                },
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(21.0),
                  child: const Text('SAVE',
                      style: TextStyle(fontSize: 15, color: Colors.blue)),
                ),
              ),
              RaisedButton(
                shape: StadiumBorder(),
                onPressed: () {},
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(21.0),
                  child: const Text('NEXT',
                      style: TextStyle(fontSize: 15, color: Colors.blue)),
                ),
              ),
              DropdownButton<String>(
                value: dropdownValue,
                //icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    if(ind<labelNames.length && labelNames[ind]!=null) {
                      labelNames[ind] = dropdownValue;
                    }
                  });
                },
                items: <String>[
                  'One',
                  'Two',
                  'Three',
                  'Four',
                  'Five'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        tooltip: 'clear Screen',
        backgroundColor: Colors.red,
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            print("undo ind was "+ind.toString());
            if(ind==points.length && ind>0){
              points.removeLast();
              labelNames.removeLast();
              ind--;
            }
            else if(ind==0 && points.length==1){
              points.removeLast();
              labelNames.removeLast();
            }
            else {
              while (ind > points.length) {
                ind--;
              }
              if(ind!=0) {
                if (points[ind] == null || points[ind].length == 0) {
                  points.removeLast();
                  points.removeLast();
                  labelNames.removeLast();
                  ind--;
                  if (ind < 0) {
                    ind = 0;
                  }
                } else {
                  points.removeLast();
                  labelNames.removeLast();
//                  ind--;
//                  if (ind < 0) {
//                    ind = 0;
//                  }
                }
              }
            }
            print("undo ind is "+ind.toString());
          });
          //setState(() => points[ind]=[]);
        },
      ),
    );
  }
}

class Sketcher extends CustomPainter {
  final List<List<Offset>> points;
  Size sz;
  double topDown,side;
  Sketcher(this.points, this.sz,this.topDown,this.side);
  @override
  bool shouldRepaint(Sketcher oldDelegate) {
    return deepEq(oldDelegate.points, points);
    //return oldDelegate.points != points;
  }

  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = colors[colorIndex].withOpacity(0.3)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

//    for (int i = 0; i < points.length - 1; i++) {
//      if (points[i] != null && points[i + 1] != null) {
//        canvas.drawLine(points[i], points[i + 1], paint);
//      }
//    }
    if (points != null) {
      //print(ind);
      print("points length " + (points.length).toString());
      print(points);
      print(labelNames);
      for (int i = 0; i < points.length; i++) {
        paint.color = colors[labelColors[i]].withOpacity(0.3);
        if (points[i] != null && points[i].length >= 2) {
          print("points " +
              i.toString() +
              " length" +
              (points[i].length).toString());
          //canvas.drawLine(points[0], points[points.length - 1], paint);
          int last = points[i].length - 1;
          while (last >= 1 && points[i][last] == null) {
            last--;
          }
          double x1, x2, y1, y2;
          Rect r;
          x1 = points[i][0].dx;
          y1 = points[i][0].dy;
          x2 = points[i][last].dx;
          y2 = points[i][last].dy;

          if (x1 > sz.width) {
            points[i][0]=Offset(sz.width,y1);
            x1 = sz.width;
          }
          if (x2 > sz.width) {
            points[i][last]=Offset(sz.width,y2);
            x2 = sz.width;
          }
          print("side "+side.toString());
          print("topDown "+topDown.toString());
          print("height "+sz.height.toString());
          print("width "+sz.width.toString());
          if(side!=0){
            if (x1 < side) {
              points[i][0]=Offset(side,y1);
              x1 = side;
            }
            if (x2 < side) {
              points[i][last]=Offset(side,y2);
              x2 = side;
            }
            if (x1 > sz.width-side) {
              points[i][0]=Offset(sz.width-side,y1);
              x1 = sz.width-side;
            }
            if (x2 > sz.width-side) {
              points[i][last]=Offset(sz.width-side,y2);
              x2 = sz.width-side;
            }
          }

          if(topDown!=0){
            if (y1 < topDown) {
              points[i][0]=Offset(x1,topDown);
              y1 = topDown;
            }
            if (y2 < topDown) {
              points[i][last]=Offset(x2,topDown);
              y2 = topDown;
            }
            if (y1 > sz.height-topDown) {
              points[i][0]=Offset(x1,sz.height-topDown);
              y1 = sz.height-topDown;
            }
            if (y2 > sz.height-topDown) {
              points[i][last]=Offset(x2,sz.height-topDown);
              y2 = sz.height-topDown;
            }
          }


          //if(y1<sz)
          Offset a=new Offset(x1,y1 );
          Offset b=new Offset(x2,y1);
          Offset c=new Offset(x2,y2);
          Offset d=new Offset(x1,y2);


          Offset o = new Offset(min(x1, x2),
              min(y1, y2)); //we determine the top left point this way
          r = o &
          Size(
              (x1 - x2).abs(),
              (y1 - y2)
                  .abs()); //creates rectangle using top left point and size
          canvas.drawRect(r, paint);
          paint.color=colors[labelColors[i]];
          canvas.drawLine(a,b,paint);
          canvas.drawLine(c,b,paint);
          canvas.drawLine(c,d,paint);
          canvas.drawLine(a,d,paint);
          if (points[i].length >= 3) {
            TextSpan span = new TextSpan(
                style: new TextStyle(
                    color: Colors.white, fontSize: 12.0, fontFamily: 'Roboto'),
                text: labelNames[i]);
            TextPainter tp = new TextPainter(
                textDirection: TextDirection.ltr,
                text: span,
                textAlign: TextAlign.left);
            tp.layout();
            tp.paint(canvas, o);
          }
        }
      }
    }
  }
}
