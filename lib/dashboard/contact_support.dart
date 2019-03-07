import 'package:flutter/material.dart';
import 'package:fourybyoffline/dashboard/base_widget.dart';

class ContactSupport extends StatefulWidget {

  ContactSupport();

  @override
  ContactSupportState createState() {
    return new ContactSupportState();
  }
}

class ContactSupportState extends BaseState<ContactSupport> {
  ContactSupportState() : super('CONTACT SUPPORT');

  @override
  Widget buildBody(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Card(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          shape: const RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(10.0))),
          child: new Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 20.0),
            child: new Column(
              children: <Widget>[
                new Icon(
                  Icons.chat,
                  size: 60.0,
                ),
                const SizedBox(height: 20),
                const Text('If you have issues using this App, feel free to contact '
                    'us', textAlign: TextAlign.center,),
                const SizedBox(height: 20),
                const Text('info@4yby.org', textAlign: TextAlign.center,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
