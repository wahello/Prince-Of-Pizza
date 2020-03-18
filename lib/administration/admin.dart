import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:prince_of_pizza/UI/home_screen.dart';
import 'package:prince_of_pizza/administration/basic/basicInfo.dart';
import 'package:prince_of_pizza/administration/catagories/listCatagories.dart';
import 'package:prince_of_pizza/administration/extras/listExtras.dart';
import 'package:prince_of_pizza/administration/pizza/listCatagories.dart';

class AdminPanal extends StatefulWidget {
  @override
  _AdminPanalState createState() => _AdminPanalState();
}

class _AdminPanalState extends State<AdminPanal> {
  @override
  void initState() {
    super.initState();
  }

  fun() {
    setState(() {});
  }

  Widget _buildTile(Widget child, Function() onTap) {
    return Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Colors.red,
        child: InkWell(onTap: onTap, child: child));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25),
      child: Container(
        color: Colors.redAccent,
        child: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
          children: <Widget>[
            _buildTile(
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("WellCome To",
                            style: TextStyle(color: Colors.blueAccent)),
                        Text("Admin Panal",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 22.0)),
                        InkWell(
                            child: Text("Planet of Pizza",
                                style: TextStyle(color: Colors.black26)),
                            onTap: () {}),
                      ],
                    ),
                  ),
                  new Spacer(),
                  Material(
                    borderRadius: BorderRadius.circular(17.0),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 5.0, right: 15.0, bottom: 5.0, top: 5.0),
                        child: Container(
                          height: 100.0,
                          width: 100.0,
                          child: Icon(Icons.supervised_user_circle,
                              size: 80, color: Colors.redAccent),
                        ),
                      ),
                    ),
                  ),
                ]),
                () => null),
            _buildTile(
                Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                              child: Material(
                                  color: Colors.redAccent,
                                  shape: CircleBorder(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Icon(Icons.edit,
                                        color: Colors.white, size: 30.0),
                                  ))),
                          Padding(padding: EdgeInsets.only(bottom: 10.0)),
                          Center(
                              child: Text('Basic Info',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.0))),
                        ])), () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new BasicInfo()));
            }),
            _buildTile(
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Material(
                          color: Colors.redAccent,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(Icons.local_pizza,
                                color: Colors.white, size: 30.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                      ),
                      Center(
                        child: Text(
                          'Add Pizza',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ), () {
              Navigator.of(context).push(
                  PageRouteBuilder(pageBuilder: (_, __, ___) => new ListCatagoriesForPizza()));
            }),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Material(
                        color: Colors.redAccent,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(Icons.fastfood,
                              color: Colors.white, size: 30.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                    ),
                    Center(
                      child: Text(
                        'Add Extras',
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new ListExtras()));
              },
            ),
            _buildTile(
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Material(
                          color: Colors.redAccent,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(Icons.format_list_bulleted,
                                color: Colors.white, size: 30.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                      ),
                      Center(
                        child: Text(
                          'Catagories',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ), () {
              Navigator.of(context).push(
                  PageRouteBuilder(pageBuilder: (_, __, ___) => new ListCatagories()));
            }),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: Material(
                            color: Colors.redAccent,
                            shape: CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(Icons.exit_to_app,
                                  color: Colors.white, size: 30.0),
                            ))),
                    Padding(padding: EdgeInsets.only(bottom: 10.0)),
                    Center(
                        child: Text('LogOut',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 12.0))),
                  ],
                ),
              ),
              () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new HomeScreen(),
                  ),
                );
              },
            ),
            _buildTile(
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: Material(
                            color: Colors.redAccent,
                            shape: CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(Icons.settings_power,
                                  color: Colors.white, size: 30.0),
                            ))),
                    Padding(padding: EdgeInsets.only(bottom: 10.0)),
                    Center(
                        child: Text('EXIT',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 12.0))),
                  ],
                ),
              ),
              () {
                Navigator.pop(context);
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),
          ],
          staggeredTiles: [
            StaggeredTile.extent(2, 110.0),
            StaggeredTile.extent(1, 110.0),
            StaggeredTile.extent(1, 110.0),
            StaggeredTile.extent(1, 110.0),
            StaggeredTile.extent(1, 110.0),
            StaggeredTile.extent(1, 110.0),
            StaggeredTile.extent(1, 110.0),
            StaggeredTile.extent(1, 110.0),
          ],
        ),
      ),
    );
  }
}
