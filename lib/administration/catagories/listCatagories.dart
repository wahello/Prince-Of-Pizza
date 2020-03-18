import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prince_of_pizza/administration/catagories/addCatagory.dart';
import 'package:prince_of_pizza/dataBase/dataBase.dart';

class ListCatagories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Catagories';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddCatagory()),
            );
          },
          icon: Icon(Icons.format_list_bulleted),
          label: Text("Add Catagory"),
          backgroundColor: Colors.redAccent,
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DataBase.getCatagories(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  ),
                ),
              );
            default:
              return Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(3.0, 0, 3, 0),
                        child: Card(
                          margin: EdgeInsets.all(1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1.0)),
                          elevation: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  child: Text(snapshot
                                      .data.documents[index].documentID),
                                ),
                              ),
                              InkWell(
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text("Dell"),
                                ),
                                onTap: () {
                                  Firestore.instance
                                      .collection("categories")
                                      .document(snapshot
                                          .data.documents[index].documentID)
                                      .delete();
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
          }
        }
      },
    );
  }
}
