import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prince_of_pizza/Extra/styles.dart';
import 'package:prince_of_pizza/UI/home_screen.dart';
import 'package:prince_of_pizza/dataBase/Database.dart';
import 'item_screen.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MenuScreenBody(),
    );
  }
}

class MenuScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        HomeScreenCard(
          TextField(
            decoration: new InputDecoration(
              icon: Icon(Icons.search),
              hintText: 'Search Menu',
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: DataBase.getCatagories(),
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
                  return Column(children: catagories(snapshot.data.documents));
              }
            }
          },
        ),
      ],
    );
  }
}

List<Widget> catagories(List<DocumentSnapshot> documents) {
  List<Widget> lines = [];
  for (DocumentSnapshot i in documents) {
    lines.add(CatagoryTile(i));
  }
  return lines;
}

class CatagoryTile extends StatelessWidget {
  final DocumentSnapshot documents;
  const CatagoryTile(
    this.documents, {
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return HomeScreenCard(
      Column(
        children: <Widget>[
          Center(
            child: TitleWidget(documents.documentID),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: DataBase.getSubCatagories(documents.documentID),
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
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.redAccent),
                        ),
                      ),
                    );
                  default:
                    return Column(
                      children: subCatagories(
                          documents.documentID, snapshot.data.documents),
                    );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

class SubCatagoryTile extends StatelessWidget {
  final DocumentSnapshot data;
  final String name;
  const SubCatagoryTile(
    this.name,
    this.data, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemScreen(name, data),
          ),
        );
      }(),
      child: Column(
        children: <Widget>[
          MySeparator(
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MenuTitleWidget(data.documentID),
              SubTitleWidget(data.data["price"])
            ],
          ),
          SubTitleWidget(data.data["tag"]),
        ],
      ),
    );
  }
}

List<Widget> subCatagories(name, List<DocumentSnapshot> documents) {
  List<Widget> lines = [];
  if (documents.length == 0)
    lines.add(Text("No Product Available"));
  else
    for (DocumentSnapshot i in documents) {
      lines.add(SubCatagoryTile(name, i));
    }
  return lines;
}

class MenuTitleWidget extends StatelessWidget {
  final string;
  MenuTitleWidget(this.string);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(string,
          style: title.copyWith(
              fontStyle: FontStyle.normal,
              color: Colors.redAccent,
              fontSize: 18)),
    );
  }
}
