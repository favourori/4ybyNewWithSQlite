import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fourybyoffline/src/views/chooser.dart';
import 'package:fourybyoffline/common/colors.dart';
import 'package:fourybyoffline/common/constants.dart';
import 'package:fourybyoffline/dashboard/contact_support.dart';
import 'package:fourybyoffline/dashboard/introduction.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class DashboardWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final drawerItems = [
    // new DrawerItem("Upload Photos", Icons.cloud_upload),
    // new DrawerItem("Survey", Icons.assignment),
    new DrawerItem("Contact support", Icons.message),
    // new DrawerItem("Sign out", Icons.exit_to_app),
  ];

  var scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences prefs;
  int currentUser;

  // int _selectedDrawerIndex = -1;
  bool hasCompleted = false;

  @override
  void initState() {
    initCurrentUser();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(title: new Text('INTRODUCTION'), centerTitle: true),
      drawer: _getDrawerWidget(),
      body: new IntroductionWidget(),
    );
  }

  Drawer _getDrawerWidget() {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(new Container(
        margin: const EdgeInsets.only(
            top: 8.0, bottom: 8.0, right: 20.0, left: 10.0),
        child: new FlatButton(
            onPressed: () => _onSelectItem(i),
            color: _canCheckItem(i) ? Colors.white : Colors.transparent,
            splashColor: MyColors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 17.0),
            child: new Row(
              children: <Widget>[
                new Icon(
                  d.icon,
                  color: _canCheckItem(i) ? MyColors.orange : Colors.white,
                ),
                new SizedBox(
                  width: 30.0,
                ),
                new Text(
                  d.title,
                  style: new TextStyle(
                      fontSize: 16,
                      color: _canCheckItem(i) ? MyColors.orange : Colors.white,
                      fontWeight: _canCheckItem(i)
                          ? FontWeight.bold
                          : FontWeight.normal),
                )
              ],
            )),
      ));
    }

    const textStyle =
        const TextStyle(color: Colors.white, fontWeight: FontWeight.normal);
    return new Drawer(
      child: new Container(
        color: MyColors.green,
        child: new Column(
          children: <Widget>[
            new DrawerHeader(
              decoration: new BoxDecoration(
                color: MyColors.green,
              ),
              margin: const EdgeInsets.only(bottom: 0.0),
              padding: const EdgeInsetsDirectional.only(top: 16.0),
              child: new SafeArea(
                bottom: false,
                child: new Container(
                  width: double.infinity,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        width: 75.0,
                        height: 75.0,
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                        padding: const EdgeInsets.all(5.0),
                        child: new Icon(
                          Icons.person,
                          size: 50.0,
                          color: MyColors.green,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      new Text('Study ID: $currentUser', style: textStyle),
                      // new Text(user == null ? '' : user.email, style: textStyle),
                      const SizedBox(height: 15.0),
                      new Container(
                        color: Colors.white,
                        height: 1.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
            new Expanded(
                child: new Container(
              color: MyColors.green,
              child: new ListView(
                children: drawerOptions,
              ),
            )),
            // new Container(
            //   width: double.infinity,
            //   decoration: const BoxDecoration(
            //       border:
            //           const Border(top: const BorderSide(color: Colors.white))),
            //   child: new FlatButton(
            //       textColor: Colors.white,
            //       onPressed: openPrivacyPolicy,
            //       child: const Text(
            //         'Terms & Conditions',
            //         style: textStyle,
            //       )),
            // )
          ],
        ),
      ),
    );
  }

  bool _canCheckItem(int i) {
    // return _selectedDrawerIndex == i;
    return false;
  }

  _onSelectItem(int index) async {
    Navigator.of(context).pop(); // close the drawer
//    setState(() {
//      _selectedDrawerIndex = index;
//    });
    _startDrawerItemWidget(index);
  }

  _startDrawerItemWidget(int pos) {
    Widget widget;
    switch (pos) {
      // case 0:
      //   if (hasCompleted) {
      //     widget = new ContactSupport();
      //   } else {
      //     widget = new UploadWidget();
      //   }
      //   break;
      // case 1:
      //   if (hasCompleted) {
      //     signOut();
      //   } else {
      //     widget = new SurveysWidget();
      //   }
      //   break;
      case 0:
        widget = new ContactSupport();
        break;
      case 3:
        signOut();
        break;
    }

    if (widget != null) {
      Navigator.push(context, new MaterialPageRoute(builder: (_) => widget));
    }
  }

  void signOut() async {
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) {
      return new Chooser();
    }), (Route<dynamic> route) => false);
  }

  void initCurrentUser() async {
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print(e.message);
    } finally {
      setState(() {
        currentUser = prefs.getInt('currentUser');
      });
    }
  }

  void openPrivacyPolicy() async {
    const url = 'http://4yby.org/t&c.php';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      scaffoldKey.currentState.showSnackBar(
          new SnackBar(content: const Text('Something went wrong')));
    }
  }
}
