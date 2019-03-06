import 'package:flutter/material.dart';
import 'package:fourybyoffline/src/views/home.dart';
import 'package:fourybyoffline/src/views/login.dart';
import 'package:fourybyoffline/utils/color_utils.dart';
import 'package:fourybyoffline/utils/margin_utils.dart';

class Chooser extends StatefulWidget {
  @override
  _ChooserState createState() => _ChooserState();
}

class _ChooserState extends State<Chooser> {
  final _formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    final logo = Image.asset('assets/appicons/logo.png', scale: 10);

    return Material(
        child: Padding(
      padding: const EdgeInsets.all(50.0),
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Step 1",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.w300)),
              MarginUtils.mg40,
              Text("Choose a category that applies to you",
              textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w300)),
              MarginUtils.mg140,
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ButtonTheme(
                  minWidth: 220.0,
                  height: 60.0,
                  child: FlatButton(
                    onPressed: () {
                      /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      ); */
                    },
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text('Tester'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ButtonTheme(
                  minWidth: 220.0,
                  height: 60.0,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    color: Color.fromRGBO(212, 160, 0, 1),
                    textColor: Colors.white,
                    child: Text('Administrator'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}