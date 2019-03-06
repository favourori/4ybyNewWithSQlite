import 'package:flutter/material.dart';
import 'package:fourybyoffline/utils/margin_utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.2;
    var width2 = MediaQuery.of(context).size.width * 0.6;

    final _drawer = Drawer(
      child: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                  margin: const EdgeInsets.all(0.0),
                  currentAccountPicture: new Hero(
                      tag: "img",
                      child: Container(
                          width: 56.0,
                          height: 56.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      "http://medicumbrella.co.uk/wp-content/uploads/2014/09/icon_user_male.jpg"))))),
                  accountName: new Text('Administrator'),
                  accountEmail: new Text('')),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Divider(
                  color: Colors.white,
                ),
              ),
              Container(
                  margin: EdgeInsets.all(20),
                  color: Theme.of(context).primaryColor,
                  child: Column(children: <Widget>[
                    InkWell(
                      onTap: () {
                        /* Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlogMore(),
                          ),
                        ); */
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.library_books,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "All Entries",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60),
                    InkWell(
                      onTap: () {
                        /* Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoMore(),
                          ),
                        ); */
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.import_export,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Export Entries",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 60),
                    InkWell(
                        onTap: () {
                          /* Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Support(),
                            ),
                          ); */
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.settings_applications,
                              color: Colors.white,
                            ),
                            SizedBox(width: 20),
                            Text(
                              "Support",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )),
                  ]))
            ],
          )),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w300)),
      ),
      drawer: _drawer,
      body: ListView(
        children: <Widget>[
          MarginUtils.mg5,
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {},
              child: Card(
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        height: height,
                        //width: width2,
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("All Entries",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w200)),
                              MarginUtils.mg10,
                              Container(
                                width: 300,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text("500",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Card(
                                            elevation: 0,
                                            color: Colors.black12,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18.0,
                                                      vertical: 8),
                                              child: Text("40%",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {},
              child: Card(
                  color: Colors.redAccent,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        height: height,
                        //width: width2,
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text("Females",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w200)),
                                ],
                              ),
                              MarginUtils.mg10,
                              Container(
                                width: 300,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text("300",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Card(
                                            color: Colors.black12,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18.0,
                                                      vertical: 8),
                                              child: Text("60%",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {},
              child: Card(
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        height: height,
                        //width: width2,
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text("Males",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w200)),
                                ],
                              ),
                              MarginUtils.mg10,
                              Container(
                                width: 300,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text("200",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Card(
                                            color: Colors.black12,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18.0,
                                                      vertical: 8),
                                              child: Text("40%",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 20),
            child: ButtonTheme(
              minWidth: 90.0,
              height: 50.0,
              child: RaisedButton(
                onPressed: () => print('clicked'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text('View Entries'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0)),
              ),
            ),
          ),
          MarginUtils.mg10,
        ],
      ),
    );
  }
}
