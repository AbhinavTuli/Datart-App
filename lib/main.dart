import 'package:flutter/material.dart';
import 'signin.dart';
import 'annotation.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
        home: AnnotationPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.blue,
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
      body: Column(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0,50,20,20),
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("./assets/images/phone.jpg")),
                  ),
                  Text("Mobile Number",style: TextStyle(color: Colors.white,fontSize: 20),),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("We need to send an OTP to authenticate your number",style: TextStyle(color: Colors.white,fontSize: 10),),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 5,
              child:
//                Expanded(
//                  flex: 13,
//                  child: Container(color: Colors.white),
//                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30,0,30,0),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color.fromRGBO(173, 179, 191, 1),
                                          width: 0.5,
                                          style: BorderStyle.none)),
                                  hintText: 'Name'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color.fromRGBO(173, 179, 191, 1),
                                          width: 0.5,
                                          style: BorderStyle.none)),
                                  hintText: 'Mobile Number'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: RaisedButton(
                                  onPressed: () {},
                                  color: Colors.blue,
                                  child: const Text('Next',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
//                Expanded(
//                  flex: 13,
//                  child: Container(color: Colors.white),
//                ),
              ),
        ],
      ),
    );
  }
}
