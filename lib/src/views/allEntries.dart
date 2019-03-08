import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_permissions/simple_permissions.dart' as pm;
import 'package:path_provider/path_provider.dart';
import 'package:fourybyoffline/data/database.dart';
import 'package:fourybyoffline/data/userDataModel.dart';
import 'package:fourybyoffline/data/responseModel.dart';

class AllEntries extends StatefulWidget {
  @override
  _AllEntriesState createState() => _AllEntriesState();
}

class _AllEntriesState extends State<AllEntries> {
  var db = new DatabaseHelper();

  List<Map> entries;
  List<UserData> userDatas = [];
  List<Map> data = [];
  TextEditingController textController = TextEditingController();
  String searchWord = '';
  bool notNull(Object o) => o != null;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> questions = [
    {
      'name': 'Study ID',
      'key': 'studyID',
    },
    {
      'name': 'What is your First name?',
      'key': 'firstName',
    },
    {
      'name': 'What is your Last name?',
      'key': 'lastName',
    },
    {
      'name': 'What is your Email?',
      'key': 'email',
    },
    {
      'name': 'What is your Phone?',
      'key': 'phone',
    },
    {
      'name': 'What is your gender?',
      'key': 'gender',
    },
    {
      'name': 'What is your age?',
      'key': 'age',
    },
    {
      'name': 'What is your religion?',
      'key': 'religion',
    },
    {
      'name': 'What is your ethnicity?',
      'key': 'eth',
    },
    {
      'name': 'What is your highest education level?',
      'key': 'eLevel',
    },
    {
      'name': 'What is your employment status?',
      'key': 'empStatus',
    },
    {
      'name': 'What is your relationship status?',
      'key': 'rStatus',
    },
    {
      'name': 'Have you ever had sex (including oral sex) in your lifetime?',
      'key': 'eHS',
    },
    {
      'name': 'At what age did you first have sex?',
      'key': 'sexAge',
    },
    {
      'name': 'In the last 6 months, have you ever had sex without condom?',
      'key': 'sWC',
    },
    {
      'name': 'Have you ever tested for HIV?',
      'key': 'testHIV',
    },
    {
      'name': 'How many times have you ever tested for HIV?',
      'key': 'timesTestedHIV',
    },
    {
      'name': 'How long ago was your most recent HIV test?',
      'key': 'recentHIVTest',
    },
    {
      'name': 'What was your most recent HIV test result?',
      'key': 'recentHIVTestResult',
    },
    {
      'name': 'Where did you get your most result HIV test?',
      'key': 'hIVTestLoc',
    },
    {
      'name':
          'If never tested, please indicate reasons for not testing (please check all that apply)?',
      'key': 'neverTested',
    },
    {
      'name': 'Have you ever used HIV self-testing in the past?',
      'key': 'hIVSelfTesting',
    },
  ];

  @override
  void initState() {
    getResponses();
    super.initState();
  }

  @override
  void dispose() {
    db.close();
    super.dispose();
  }

  getResponses() async {
    List<Map> getEnt = [];
    try {
      getEnt = await db.getEntries();
    } catch (e) {
      print(e.message);
    } finally {
      getEnt.forEach((Map ent) async {
        Response response = Response.fromMap(ent);
        String firstName;
        String lastName;
        String email;
        String phone;
        String gender;
        String age;
        String religion;
        String eth;
        String eLevel;
        String empStatus;
        String rStatus;
        String eHS;
        String sexAge;
        String sWC;
        String testHIV;
        String timesTestedHIV;
        String recentHIVTest;
        String recentHIVTestResult;
        String hIVTestLoc;
        String neverTested;
        String hIVSelfTesting;
        // List<Map> ru = await db.getAnswer('Have you ever used HIV self-testing in the past?', response.studyID);
        // print('JBJB $ru');
        for (int i = 0; i < questions.length; i++) {
          List<Map> result;
          try {
            result = await db.getAnswer(questions[i]['name'], response.studyID);
          } catch (e) {
            print(e.message);
          } finally {
            if (result.length > 0) {
              Response realAnswer = Response.fromMap(result.first);
              if (i == 1) {
                firstName = realAnswer.answer;
              } else if (i == 2) {
                lastName = realAnswer.answer;
              } else if (i == 3) {
                email = realAnswer.answer;
              } else if (i == 4) {
                phone = realAnswer.answer;
              } else if (i == 5) {
                gender = realAnswer.answer;
              } else if (i == 6) {
                age = realAnswer.answer;
              } else if (i == 7) {
                religion = realAnswer.answer;
              } else if (i == 8) {
                eth = realAnswer.answer;
              } else if (i == 9) {
                eLevel = realAnswer.answer;
              } else if (i == 10) {
                empStatus = realAnswer.answer;
              } else if (i == 11) {
                rStatus = realAnswer.answer;
              } else if (i == 12) {
                eHS = realAnswer.answer;
              } else if (i == 13) {
                sexAge = realAnswer.answer;
              } else if (i == 14) {
                sWC = realAnswer.answer;
              } else if (i == 15) {
                testHIV = realAnswer.answer;
              } else if (i == 16) {
                timesTestedHIV = realAnswer.answer;
              } else if (i == 17) {
                recentHIVTest = realAnswer.answer;
              } else if (i == 18) {
                recentHIVTestResult = realAnswer.answer;
              } else if (i == 19) {
                hIVTestLoc = realAnswer.answer;
              } else if (i == 20) {
                neverTested = realAnswer.answer;
              } else if (i == 21) {
                hIVSelfTesting = realAnswer.answer;
              }
            }
          }
        }
        Map myData = {
          "firstName": firstName ?? '-',
          "lastName": lastName ?? '-',
          "studyID": response.studyID ?? '-',
          "email": email ?? '-',
          "phone": phone ?? '-',
          "gender": gender ?? '-',
          "age": age ?? '-',
          "religion": religion ?? '-',
          "eth": eth ?? '-',
          "eLevel": eLevel ?? '-',
          "empStatus": empStatus ?? '-',
          "rStatus": rStatus ?? '-',
          "eHS": eHS ?? '-',
          "sexAge": sexAge ?? '-',
          "sWC": sWC ?? '-',
          "testHIV": testHIV ?? '-',
          "timesTestedHIV": timesTestedHIV ?? '-',
          "recentHIVTest": recentHIVTest ?? '-',
          "recentHIVTestResult": recentHIVTestResult ?? '-',
          "hIVTestLoc": hIVTestLoc ?? '-',
          "neverTested": neverTested ?? '-',
          "hIVSelfTesting": hIVSelfTesting ?? '-',
        };
        String myJson = jsonEncode(myData);
        print(myJson);
        UserData mUData = UserData.fromJson(jsonDecode(myJson));
        mUData.studyID = response.studyID;
        setState(() {
          userDatas.add(mUData);
        });
      });
    }
  }

  // void checkSMSPermission() async {
  //   PermissionStatus permissionCheck;
  //   Map<PermissionGroup, PermissionStatus> pName;
  //   try {
  //     permissionCheck =
  //         await PermissionHandler().checkPermissionStatus(PermissionGroup.sms);
  //   } catch (e) {
  //     print(e.message);
  //   } finally {
  //     if (permissionCheck == PermissionStatus.granted) {
  //       sendSMS();
  //     } else if (permissionCheck == PermissionStatus.denied) {
  //       await PermissionHandler()
  //           .requestPermissions([PermissionGroup.sms]).then((res) {
  //         print("HELL");
  //         print("MVSHVSBHS $res");
  //         if (pName[PermissionGroup.sms] == PermissionStatus.granted) {
  //           sendSMS();
  //         } else {
  //           permErrorDialog();
  //         }
  //       });
  //       // try {
  //       //   pName = await PermissionHandler()
  //       //       .requestPermissions([PermissionGroup.sms]);
  //       // } catch (e) {
  //       //   print(e.message);
  //       // } finally {
  //       //   print(pName);
  //       //   if (pName[PermissionGroup.sms] == PermissionStatus.granted) {
  //       //     sendSMS();
  //       //   } else {
  //       //     permErrorDialog();
  //       //   }
  //       // }
  //     } else if (permissionCheck == PermissionStatus.unknown) {
  //       permErrorDialog();
  //     } else if (permissionCheck == PermissionStatus.disabled) {
  //       permErrorDialog();
  //     }
  //   }
  // }

  getCsv() async {
    //create an element rows of type list of list. All the above data set are stored in associate list
//Let associate be a model class with attributes name,gender and age and associateList be a list of associate model class.

    List<List<dynamic>> rows = List<List<dynamic>>();
    List<dynamic> tempRow = List();
    for (int i = 0; i < questions.length; i++) {
//row refer to each column of a row in csv file and rows refer to each row in a file
      tempRow.add(questions[i]['name']);
    }
    rows.add(tempRow);
    for (int i = 0; i < userDatas.length; i++) {
//row refer to each column of a row in csv file and rows refer to each row in a file
      List<dynamic> row = List();
      row.add(userDatas[i].studyID);
      row.add(userDatas[i].firstName);
      row.add(userDatas[i].lastName);
      row.add(userDatas[i].email);
      row.add(userDatas[i].phone);
      row.add(userDatas[i].gender);
      row.add(userDatas[i].age);
      row.add(userDatas[i].religion);
      row.add(userDatas[i].eth);
      row.add(userDatas[i].eLevel);
      row.add(userDatas[i].empStatus);
      row.add(userDatas[i].rStatus);
      row.add(userDatas[i].eHS);
      row.add(userDatas[i].sexAge);
      row.add(userDatas[i].sWC);
      row.add(userDatas[i].testHIV);
      row.add(userDatas[i].timesTestedHIV);
      row.add(userDatas[i].recentHIVTest);
      row.add(userDatas[i].recentHIVTestResult);
      row.add(userDatas[i].hIVTestLoc);
      row.add(userDatas[i].neverTested);
      row.add(userDatas[i].hIVSelfTesting);
      rows.add(row);
    }

    await pm.SimplePermissions.requestPermission(
        pm.Permission.WriteExternalStorage);
    bool checkPermission = await pm.SimplePermissions.checkPermission(
        pm.Permission.WriteExternalStorage);
    if (checkPermission) {
//store file in documents folder

      String dir = (await getExternalStorageDirectory()).absolute.path + "/";
      File f = new File(dir + "data.csv");

// convert rows to String and write as csv file

      String csv = const ListToCsvConverter().convert(rows);
      File output = await f.writeAsString(csv);
      bool fileExists = await output.exists();
      if (fileExists) {
        final Email email = Email(
          body: 'Find the data results in the attachment',
          subject: 'Data results',
          recipients: ['rstomotayo@gmail.com'],
          attachmentPath: output.path,
        );

        String platformResponse;

        try {
          await FlutterEmailSender.send(email);
          platformResponse = 'Message sent successfully';
        } catch (error) {
          platformResponse = error.toString();
        }

        if (!mounted) return;

        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(platformResponse),
        ));
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Could not locate exported file.'),
        ));
      }
    } else {
      permErrorDialog();
    }
  }

  void permErrorDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              content: Container(
                child: Text(
                    '4YBY needs permission to write storage file, please enable it in the app Settings.'),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => PermissionHandler().openAppSettings(),
                  child: Text(
                    'OPEN SETTINGS',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.teal,
                ),
              ],
            ));
  }

  buildResultsWidget() {
    if (searchWord.length > 0) {
      List<UserData> tempList = List();
      for (int i = 0; i < userDatas.length; i++) {
        if (userDatas[i]
                .firstName
                .toLowerCase()
                .contains(searchWord.toLowerCase()) ||
            userDatas[i]
                .lastName
                .toLowerCase()
                .contains(searchWord.toLowerCase()) ||
            userDatas[i]
                .studyID
                .toString()
                .contains(searchWord.toLowerCase())) {
          tempList.add(userDatas[i]);
        }
      }
      return buildResults(tempList);
    } else {
      return buildResults(userDatas);
    }
  }

  buildResults(List<UserData> resultData) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: resultData.length,
        itemBuilder: (BuildContext context, int i) {
          double screenSize = MediaQuery.of(context).size.width;
          return Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: screenSize * 0.20,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                      child: Text(resultData[i].studyID.toString()),
                      decoration: BoxDecoration(
                        color: (i%2 == 0) ? Colors.grey[300] : Colors.grey[200],
                      ),
                    ),
                    Container(
                      height: 46,
                      width: 1,
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: screenSize * 0.80,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                        child: Text(
                          '${resultData[i].firstName} ${resultData[i].lastName}',
                          overflow: TextOverflow.ellipsis,
                        ),
                        decoration: BoxDecoration(
                          color: (i%2 == 0) ? Colors.grey[300] : Colors.grey[200],
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: Container(
                    //     width: screenSize*0.30,
                    //     margin: EdgeInsets.symmetric(horizontal: 5),
                    //     padding: EdgeInsets.symmetric(vertical: 6),
                    //     child: Center(
                    //       child: Text(
                    //         'Export',
                    //         style: TextStyle(
                    //           color: Colors.white
                    //         ),
                    //         ),
                    //     ),
                    //     decoration: BoxDecoration(
                    //       color: Colors.red,
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                width: screenSize,
                height: 1,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  clearEntries() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            child: Text('Are you sure you want to clear data entires? This process can not be undone.'),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'No',
              style: TextStyle(
                color: Colors.grey[400],
              ),
              ),
            ),
            FlatButton(
              onPressed: () async {
                await db.truncate();
                Navigator.of(context).pop();
              },
              child: Text('Yes',
              style: TextStyle(
                color: Color.fromRGBO(0, 154, 158, 1),
              ),
              ),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          child: Text('All Entries'),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Export',
            icon: Icon(
              Icons.email,
              color: Colors.white,
            ),
            onPressed: getCsv,
          ),
          IconButton(
            tooltip: 'Clear Entries',
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: clearEntries,
          ),
        ],
      ),
      body: Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(
                left: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 5,),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey[400],
                          size: 18,
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: textController,
                          onChanged: (String value) {
                            setState(() {
                              searchWord = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search for entries',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      textController.text.length > 0
                          ? Container(
                            alignment: Alignment.center,
                              child: IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.grey[400],
                                  size: 18,
                                ),
                                onPressed: () {
                                  setState(() {
                                    textController.clear();
                                    searchWord = '';
                                  });
                                },
                              ),
                            )
                          : null,
                    ].where(notNull).toList(),
                  ),
                ),
              ),
            ),
            buildResultsWidget(),
          ],
        ),
      ),
    );
  }
}
