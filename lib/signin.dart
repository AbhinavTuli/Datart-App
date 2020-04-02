import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Sign in to Your Account",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Image(
              image: AssetImage("./assets/images/piggy.png"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 20, 50, 10),
              child: TextField(
                //style: TextStyle(color:Colors.white),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.lightBlueAccent,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(
                          color: Colors.blue,
                          width: 0,
                          style: BorderStyle.none)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(
                        //color: Colors.red,
                        width: 1,
                        //style: BorderStyle.none,
                      )),
                  hintText: 'USERNAME',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: TextField(
                //style: TextStyle(color:Colors.white),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.lightBlueAccent,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(
                          color: Colors.blue,
                          width: 0,
                          style: BorderStyle.none)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(
                        //color: Colors.red,
                        width: 1,
                        //style: BorderStyle.none,
                      )),
                  hintText: 'PASSWORD',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  shape: StadiumBorder(),
                  onPressed: () {},
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(21.0),
                    child: const Text('LOG IN',
                        style: TextStyle(fontSize: 15, color: Colors.blue)),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}