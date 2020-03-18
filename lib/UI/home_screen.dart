import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prince_of_pizza/Extra/styles.dart';
import 'package:prince_of_pizza/UI/checkout_screen.dart';
import 'package:prince_of_pizza/UI/menu_screen.dart';
import 'package:prince_of_pizza/administration/admin.dart';
import 'package:prince_of_pizza/dataBase/Database.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: HomeScreenBody(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuScreen()),
              );
            },
            icon: Icon(Icons.local_pizza),
            label: Text('Order Here'),
            backgroundColor: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    FirebaseAuth.instance.currentUser().then((onValue) {
      //123qwe
      if (onValue != null && onValue.email == "prince@of.pizza") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminPanal()));
      }
    });

    List<Widget> discount(Map<String, Object> data) {
      List<Widget> lines = [];
      var list = data["details"].toString().split(',');
      for (String j in list) lines.add(SubTitleWidget(j, i: 1));
      return lines;
    }

    Firestore.instance.settings(persistenceEnabled: true);
    return ListView(
      children: <Widget>[
        StreamBuilder<QuerySnapshot>(
          stream: DataBase.getBasicInfo(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return new Text('Error: ${snapshot.error}');
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Container(
                      height: 45,
                      child: Center(
                          child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.redAccent),
                      )));
                default:
                  return HomeScreenCard(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        CachedNetworkImage(
                          width: 320,
                          height: 300,
                          fit: BoxFit.cover,
                          imageUrl: snapshot.data.documents[2].data["logo"],
                          placeholder: (context, url) => Container(
                              width: 45,
                              height: 45,
                              child: Center(
                                  child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.redAccent),
                              ))),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        TitleWidget(snapshot.data.documents[0].data["name"]),
                        SubTitleWidget(
                            snapshot.data.documents[0].data["address"]),
                        SubTitleWidget(snapshot.data.documents[0].data["line"]),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: discount(snapshot.data.documents[1].data),
                        ),
                        SizedBox(height: 8),
                        MySeparator(
                          color: Colors.grey,
                        ),
                        TitleWidget(snapshot.data.documents[0].data["timeing"]),
                      ],
                    ),
                  );
              }
            }
          },
        ),
        HomeScreenCard(Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(child: TitleWidget('Our Story')),
            Image.asset('assets/story.png'),
            SubTitleWidget(
                'Prince of Pizza is currently located at 763 Bergen Ave, Jersey City, NJ 07306. Order your favorite pizza, pasta, salad, and more, all with the click of a button.'),
            SubTitleWidget(
                'Prince of Pizza accepts orders online for pickup and delivery.'),
          ],
        )),
        HomeScreenCard(Column(
          children: <Widget>[
            Center(
              child: TitleWidget('Our Hours'),
            ),
            MySeparator(
              color: Colors.grey,
            ),
            SubTitleWidget('Delivery'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SubTitleWidget('Sunday'),
                    SubTitleWidget('Monday'),
                    SubTitleWidget('Tuesday'),
                    SubTitleWidget('Wednesday'),
                    SubTitleWidget('Thursday'),
                    SubTitleWidget('Friday'),
                    SubTitleWidget('Saturday'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SubTitleWidget('11:00 AM - 11:15 PM'),
                    SubTitleWidget('11:00 AM - 11:15 PM'),
                    SubTitleWidget('11:00 AM - 11:15 PM'),
                    SubTitleWidget('11:00 AM - 11:15 PM'),
                    SubTitleWidget('11:00 AM - 11:15 PM'),
                    SubTitleWidget('11:00 AM - 11:15 PM'),
                    SubTitleWidget('11:00 AM - 11:15 PM'),
                  ],
                ),
              ],
            ),
            MySeparator(
              color: Colors.grey,
            ),
            SubTitleWidget('Pickup'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SubTitleWidget('Sunday'),
                    SubTitleWidget('Monday'),
                    SubTitleWidget('Tuesday'),
                    SubTitleWidget('Wednesday'),
                    SubTitleWidget('Thursday'),
                    SubTitleWidget('Friday'),
                    SubTitleWidget('Saturday'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SubTitleWidget('11:00 AM - 11:15 PM'),
                    SubTitleWidget('11:00 AM - 11:15 PM'),
                    SubTitleWidget('11:00 AM - 11:15 PM'),
                    SubTitleWidget('11:00 AM - 11:15 PM'),
                    SubTitleWidget('11:00 AM - 11:15 PM'),
                    SubTitleWidget('11:00 AM - 11:15 PM'),
                    SubTitleWidget('11:00 AM - 11:15 PM'),
                  ],
                ),
              ],
            ),
            MySeparator(
              color: Colors.grey,
            ),
            Row(
              children: <Widget>[
                Spacer(),
                InkWell(
                    onTap: () {
                      signInAlert(context);
                    },
                    child: Text("Admin Login",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w800))),
              ],
            )
          ],
        )),
        SizedBox(
          height: 60,
        ),
      ],
    );
  }
}

class HomeScreenCard extends StatelessWidget {
  final column;

  HomeScreenCard(this.column);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: column,
    );
  }
}

class TitleWidget extends StatelessWidget {
  final string;

  TitleWidget(this.string);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(string, style: title),
    );
  }
}

class SubTitleWidget extends StatelessWidget {
  final string;
  final int i;
  SubTitleWidget(this.string, {this.i: 0});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: i != 0
          ? const EdgeInsets.symmetric(horizontal: 8, vertical: 3)
          : const EdgeInsets.all(5),
      child: i != 0
          ? Text(string,
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
          : Text(string, style: subtitle),
    );
  }
}
