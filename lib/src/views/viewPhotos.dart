
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fourybyoffline/data/database.dart';

class ViewPhotos extends StatefulWidget {
  final int studyID;
  final String name;
  ViewPhotos({this.studyID, this.name});
  @override
  _ViewPhotosState createState() => _ViewPhotosState();
}

class _ViewPhotosState extends State<ViewPhotos> {
  var db = new DatabaseHelper();
  List<String> photos = [];

  @override
  void initState() {
    getPhotos();
    super.initState();
  }

  getPhotos() async {
    Map res;
    try {
      res = await db.getPhotos(widget.studyID);
    } catch (e) {
      print(e.message);
    } finally {
      setState(() {
        if (res['photo1'] != '') {
          photos.add(res['photo1']);
        }
        if (res['photo2'] != '') {
          photos.add(res['photo2']);
        }
        if (res['photo3'] != '') {
          photos.add(res['photo3']);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          child: Text(widget.name),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView.builder(
            itemCount: photos.length,
            itemBuilder: (BuildContext context, int i) {
              return Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Image.file(File(photos[i])),
              );
            },
          ),
          ),
    );
  }
}
