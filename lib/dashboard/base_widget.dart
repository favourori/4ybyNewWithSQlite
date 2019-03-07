
import 'package:flutter/material.dart';
import 'package:fourybyoffline/common/colors.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  var scaffoldKey = new GlobalKey<ScaffoldState>();
  final String title;

  @override
  void initState() {
    initUserId();
    super.initState();
  }

  BaseState(this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        backgroundColor: MyColors.green,
        title: new Text(title),
        centerTitle: true,
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context);

  void initUserId() async {
    // var user = await FirebaseAuth.instance.currentUser();
    // setState(() => this.user = user);
  }
}
