import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fourybyoffline/src/views/chooser.dart';
import 'package:fourybyoffline/src/views/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '4YBY',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: const Color.fromRGBO(0, 154, 158, 1)),
        home: new Splash(),
        routes: {
          '/home': (BuildContext context) => HomePage(),
        });
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

// SingleTickerProviderStateMixin is used for animation
class SplashState extends State<Splash> {
  Timer _timer;

//LOADING DATA FOR PROFILES

  SplashState() {
    _timer = new Timer(const Duration(milliseconds: 6500), () {
      setState(() {
          Navigator.pop(context);
       // Navigator.of(context).pushReplacementNamed('/home');
       Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chooser(),
                    ),
                  );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double scrollHeight = MediaQuery.of(context).size.height * 0.28;
    final logo = Image.asset('assets/appicons/logo.png', scale: 8
    );

    return new Scaffold(
      body: Container(
        color: Colors.white,
        child: new Center(
          
            child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: scrollHeight,
            ),

            logo,
            SizedBox(
              height: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
              height: 180,
            ),
                Text("4YBY",
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 10,
                ),
                Text("YOUTH DRIVEN • YOUTH INSPIRED",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                    )),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
