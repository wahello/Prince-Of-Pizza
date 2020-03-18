import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prince_of_pizza/administration/pizza/addPizza.dart';
import 'package:prince_of_pizza/dataBase/dataBase.dart';

class ListPizza extends StatelessWidget {
  final String documentID;
  final List<DocumentSnapshot> cata;
  ListPizza(this.documentID, this.cata);

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Pizza';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(appTitle),
        ),
        body: MyCustomForm(this.documentID),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPizza(cata)),
            );
          },
          icon: Icon(Icons.local_pizza),
          label: Text("Add Pizza"),
          backgroundColor: Colors.redAccent,
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  final String documentID;
  MyCustomForm(this.documentID);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DataBase.getPizza(widget.documentID),
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
                      return InkWell(
                        onTap: () {
                        },
                        child: Padding(
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
                                        .document(widget.documentID)
                                        .collection("List of Items")
                                        .document(snapshot
                                            .data.documents[index].documentID)
                                        .delete();
                                  },
                                )
                              ],
                            ),
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
