
import 'package:flutter/material.dart';
import 'package:fourybyoffline/common/colors.dart';
import 'package:fourybyoffline/dashboard/questions/questions_widget.dart';

class IntroductionWidget extends StatefulWidget {
  @override
  _IntroductionWidgetState createState() => _IntroductionWidgetState();
}

class _IntroductionWidgetState extends State<IntroductionWidget> {
  bool hasCompleted = false;

  @override
  void initState() {
    initHasCompleted();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          const SizedBox(height: 20.0),
          new _TextWidget(
            text: 'This App allows you to share photos from your HIV '
                'self-testing result to a trained professional for confirmation. \n'
                '\nThe '
                'study is run by Saint Louis University School for Public Health and '
                'Social Justice in collaboration with the Nigerian Institute for Medical '
                'Research and the University of North Carolina, Chapel Hill. It is paid '
                'for by the National Institutes of Health (NIH). Please note that all '
                'your responses and information will be kept confidential',
            sideColor: Color(0xFF050505),
            height: 210.0,
          ),
          const SizedBox(height: 20.0),
          new _TextWidget(
            text:
                'Before you begin, we will ask some questions about yourself, your hiv testing history, and what you think about hiv self-testing. After completing the test, we will ask you to share the photo of the result and what you think about this Hiv self-testing App',
            sideColor: Color(0xFFc72e23),
            height: 130.0,
          ),
          const SizedBox(height: 30.0),
          new Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: new RaisedButton(
              onPressed: hasCompleted ? null : showInfoDialog,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              textColor: Colors.white,
              child: new Text(hasCompleted ? 'You\'ve already tested' : 'START'),
              color: MyColors.orange,
              shape: const RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(const Radius.circular(50.0))),
            ),
          )
        ],
      ),
    );
  }

  void showInfoDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return new Material(
              type: MaterialType.transparency,
              child: new Container(
                alignment: Alignment.center,
                child: new Card(
                  color: MyColors.green,
                  margin: const EdgeInsets.symmetric(horizontal: 40.0),
                  shape: const RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(const Radius.circular(5))),
                  child: new Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(
                          Icons.insert_emoticon,
                          color: Colors.white,
                          size: 80,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'HELLO THERE',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        new Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: new RichText(
                            textAlign: TextAlign.center,
                            text: new TextSpan(
                              text: 'This typically takes about ',
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .copyWith(color: Colors.white),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: '10',
                                    style: new TextStyle(fontWeight: FontWeight.bold)),
                                new TextSpan(text: ' Minutes to complete'),
                              ],
                            ),
                          ),
                        ),
                        new RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (_) => new QuestionsWidget()));
                          },
                          color: Colors.white,
                          textColor: Colors.black87,
                          padding:
                              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: const Text('Continue'),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(const Radius.circular(30))),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  void initHasCompleted() async {
    // var user = await FirebaseAuth.instance.currentUser();
    // var userRef = FirebaseDatabase.instance
    //     .reference()
    //     .child('users')
    //     .child(user.uid)
    //     .child(Constants.HAS_USER_COMPLETED);

    // userRef.keepSynced(true);
    // completedSubscription = userRef.onValue.listen((Event event) => setState(() {
    //       var completed = event.snapshot.value;
    //       completed ??= false;
    //       print('Has completed = $completed');
    //       return hasCompleted = completed;
    //     }));
  }
}

class _TextWidget extends StatelessWidget {
  final String text;
  final Color sideColor;
  final double height;

  _TextWidget({@required this.text, @required this.sideColor, @required this.height});

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Row(
        children: <Widget>[
          new Container(
            color: sideColor,
            width: 6.0,
            height: height,
          ),
          new Expanded(
              child: new Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: new Text(text),
          ))
        ],
      ),
    );
  }
}
