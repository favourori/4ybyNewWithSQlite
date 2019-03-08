import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fourybyoffline/common/colors.dart';
import 'package:fourybyoffline/dashboard/base_widget.dart';
import 'package:fourybyoffline/dashboard/complete_wiget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fourybyoffline/data/database.dart';
import 'package:path/path.dart' hide context;

class UploadWidget extends StatefulWidget {
  @override
  _UploadWidgetState createState() => _UploadWidgetState();
}

class _UploadWidgetState extends BaseState<UploadWidget> {
  _UploadWidgetState() : super('UPLOAD PHOTOS');

  var selectedPhotos = <File>[];
  var loading = false;
  SharedPreferences prefs;
  int currentUser;
  var db = new DatabaseHelper();

  @override
  void initState() {
    initCurrentUser();
    super.initState();
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

  @override
  Widget buildBody(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: new BoxDecoration(
              color: MyColors.green.withOpacity(0.06),
              borderRadius: const BorderRadius.all(const Radius.circular(8))),
          child: const Text(
            'UPLOAD PHOTOS OF YOUR TEST RESULT',
            textAlign: TextAlign.center,
            style: const TextStyle(color: MyColors.green),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new RaisedButton(
                onPressed: !canAddAnotherImage()
                    ? null
                    : () => pickImage(ImageSource.camera),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                textColor: Colors.white,
                child: const Text('USE CAMERA'),
                color: MyColors.orange,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(50.0))),
              ),
              new RaisedButton(
                onPressed: !canAddAnotherImage()
                    ? null
                    : () => pickImage(ImageSource.gallery),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                textColor: Colors.white,
                child: new Text('SELECT FROM GALLERY'),
                color: MyColors.green,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(50.0))),
              )
            ],
          ),
        ),
        new Expanded(
            child: new Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: new ListView.builder(
            itemCount: selectedPhotos.length,
            itemBuilder: (_, index) => new _PhotoWidget(
                file: selectedPhotos[index],
                onDelete: () => setState(() {
                      selectedPhotos.removeAt(index);
                    })),
          ),
        )),
        selectedPhotos.length > 0
            ? new Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20.0),
                child: new RaisedButton(
                  onPressed: uploadImages,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  textColor: Colors.white,
                  child: const Text('SUBMIT PHOTOS'),
                  color: MyColors.red,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(50.0))),
                ),
              )
            : const SizedBox()
      ],
    );
  }

  pickImage(ImageSource source) async {
    var file = await ImagePicker.pickImage(source: source);
    if (file != null && await file.exists()) {
      setState(() => selectedPhotos.add(file));
    }
  }

  void uploadImages() async {
    setState(() => loading = true);
    List<String> imgPath = [];
    selectedPhotos.forEach((image) {
      imgPath.add(image.path);
    });
    if(imgPath.length == 1) {
      imgPath.add('');
      imgPath.add('');
    }
    if(imgPath.length == 2) {
      imgPath.add('');
    }
    await db.savePics(imgPath, currentUser);
    Navigator.pushReplacement(
        context, new MaterialPageRoute(builder: (_) => new CompleteWidget()));
  }

  bool canAddAnotherImage() {
    return selectedPhotos.length < 3;
  }
}

class _PhotoWidget extends StatelessWidget {
  final File file;
  final VoidCallback onDelete;

  _PhotoWidget({@required this.file, @required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Image.file(
            file,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 20),
          new RaisedButton(
            onPressed: onDelete,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            textColor: Colors.white,
            child: const Text('Delete'),
            color: MyColors.red,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    const BorderRadius.all(const Radius.circular(50.0))),
          )
        ],
      ),
    );
  }
}
