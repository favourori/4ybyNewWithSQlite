import 'package:flutter/material.dart';
import 'package:fourybyoffline/src/views/home.dart';
import 'package:fourybyoffline/utils/color_utils.dart';
import 'package:fourybyoffline/utils/margin_utils.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              logo,
              MarginUtils.mg40,
              Text("Admin Login",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w300)),
              MarginUtils.mg40,
              TextFormField(
                validator: (value) {
                  if (value == "admin") {
                    setState(() {
                      username = value;
                    });
                  } else if (value.isEmpty) {
                    return "This field can't be left empty";
                  } else {
                    return "Invalid Username";
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Username', labelStyle: TextStyle(fontSize: 18)),
              ),
              MarginUtils.mg20,
              TextFormField(
                validator: (value) {
                  if (value == "1234" || value == "Slu02" || value == "Slu03") {
                    setState(() {
                      password = value;
                    });
                  } else if (value.isEmpty) {
                    return "This field can't be left empty";
                  } else {
                    return "Please enter a valid Password";
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Password', labelStyle: TextStyle(fontSize: 18)),
                obscureText: true,
              ),
              MarginUtils.mg30,
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ButtonTheme(
                  minWidth: 220.0,
                  height: 50.0,
                  child: FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.pop(context, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      }
                    },
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text('Login'),
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
