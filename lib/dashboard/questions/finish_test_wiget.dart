import 'package:flutter/material.dart';
import 'package:fourybyoffline/common/colors.dart';
import 'package:fourybyoffline/dashboard/base_widget.dart';
import 'package:fourybyoffline/dashboard/upload/photo_upload.dart';

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
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 30),
        child: new Column(
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
              decoration: new BoxDecoration(
                  borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
                  color: Colors.black12.withOpacity(0.06)),
              child: new Text(
                'After you have completed your test, please upload photos of your test '
                    'result as shown in the sample below',
                style: const TextStyle(fontSize: 16.0),
              ),
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: new Image.asset('assets/images/test_kit.jpg'),
            ),
            new Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 40, right: 40, top: 50),
              child: new RaisedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      new MaterialPageRoute(builder: (_) => new UploadWidget()));
                },
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                textColor: Colors.white,
                child: const Text('UPLOAD PHOTOS'),
                color: MyColors.orange,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(50.0))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
