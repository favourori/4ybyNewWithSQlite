import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fourybyoffline/common/colors.dart';
import 'package:fourybyoffline/dashboard/dashboard.dart';
import 'package:fourybyoffline/dashboard/base_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinishTestWidget extends StatefulWidget {
  @override
  FinishTestWidgetState createState() {
    return new FinishTestWidgetState();
  }
}

class FinishTestWidgetState extends BaseState<FinishTestWidget> {
  FinishTestWidgetState() : super('FINISH TEST');

  @override
  Widget buildBody(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Card(
          margin: const EdgeInsets.symmetric(horizontal: 40.0),
          shape: const RoundedRectangleBorder(
              borderRadius:
                  const BorderRadius.all(const Radius.circular(10.0))),
          child: new Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
            child: new Column(
              children: <Widget>[
                new Icon(
                  Icons.check_circle,
                  color: MyColors.green,
                  size: 60.0,
                ),
                const SizedBox(height: 20),
                const Text('Thanks for your submission'),
              ],
            ),
          ),
        ),
        new Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 40, right: 40, top: 60),
          child: new RaisedButton(
            onPressed: () async {
              SharedPreferences prefs;
              var rand = new Random();
              int randID = rand.nextInt(100000);
              try {
                prefs = await SharedPreferences.getInstance();
              } catch (e) {
                print(e.message);
              } finally {
                prefs.clear().then((isCleared) {
                  if (isCleared) {
                    prefs.setInt('currentUser', randID).then((bool res) {
                      if (res) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardWidget(),
                          ),
                        );
                      }
                    });
                  }
                });
              }
            },
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            textColor: Colors.white,
            child: const Text('START NEW ENTRY'),
            color: MyColors.orange,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    const BorderRadius.all(const Radius.circular(50.0))),
          ),
        )
      ],
    );
  }
}
