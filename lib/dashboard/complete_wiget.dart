import 'package:flutter/material.dart';
import 'package:fourybyoffline/common/constants.dart';
import 'package:fourybyoffline/common/colors.dart';
import 'package:fourybyoffline/dashboard/base_widget.dart';

class CompleteWidget extends StatefulWidget {
  @override
  CompleteWidgetState createState() {
    return new CompleteWidgetState();
  }
}

class CompleteWidgetState extends BaseState<CompleteWidget> {
  CompleteWidgetState() : super('COMPLETE');

  @override
  Widget buildBody(BuildContext context) {
    userHasCompleted();

    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Card(
          margin: const EdgeInsets.symmetric(horizontal: 40.0),
          shape: const RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(10.0))),
          child: new Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
            child: new Column(
              children: <Widget>[
                new Icon(
                  Icons.check_circle,
                  color: MyColors.green,
                  size: 60.0,
                ),
                const SizedBox(height: 20),
                new Text('Thanks for participating'.toUpperCase()),
              ],
            ),
          ),
        ),
        new Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 40, right: 40, top: 60),
          child: new RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            textColor: Colors.white,
            child: const Text('COMPLETE'),
            color: MyColors.green,
            shape: const RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(const Radius.circular(50.0))),
          ),
        )
      ],
    );
  }

  void userHasCompleted() {
    // if (user == null) {
    //   return;
    // }
    // var userRef =
    // FirebaseDatabase.instance.reference().child('users').child(user.uid);
    // userRef.child(Constants.HAS_USER_COMPLETED).set(true);
  }
}
