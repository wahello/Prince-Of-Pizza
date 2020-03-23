import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prince_of_pizza/Extra/styles.dart';
import 'package:prince_of_pizza/dataBase/dataBase.dart';

class MyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Orders';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
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
  List<Widget> extrasList(Map data) {
    List<Widget> lines = [];
    lines.add(Row(
      children: <Widget>[
        Text("Extra Items:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        Spacer(),
      ],
    ));
    if (data.isEmpty)
      lines.add(Text("No Extra Added"));
    else
      data.forEach((k, v) => lines.add(
            Text(k),
          ));
    return lines;
  }

  List<Widget> itemsList(Map data) {
    List<Widget> lines = [];
    data.forEach((k, v) => () {
          lines.add(
            Text("Item",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          );
          Map optional = v["optional"];
          lines.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Catagory"),
              Text(v["catagory"]),
            ],
          ));
          lines.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("subCatagory"),
              Text(v["subCatagory"]),
            ],
          ));
          lines.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Quantity"),
              Text(v["quantity"].toString()),
            ],
          ));
          lines.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Special Requirments"),
              Text(v["requirments"] == ""
                  ? "No Special Requirment"
                  : v["requirments"]),
            ],
          ));
          lines.add(
            Text("Requirments",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          );
          optional.forEach((sk, sv) => () {
                if (sv["null"] == "3") {
                } else if (sv.length > 0) {
                  List list = sv.values.toList();
                  lines.add(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(sk),
                        Text(list[0] == "0"
                            ? "Left Topping"
                            : list[0] == "1"
                                ? "Right Topping"
                                : list[0] == "2" ? "Full Topping" : ""),
                      ],
                    ),
                  );
                }
              }());
          lines.add(SizedBox(height: 8));
          lines.add(MySeparator(
            color: Colors.grey,
          ));
          lines.add(SizedBox(height: 8));
        }());
    return lines;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DataBase.getOrdersList(),
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
              List<DocumentSnapshot> list = snapshot.data.documents.reversed.toList();
              return Padding(
                padding: EdgeInsets.fromLTRB(0, 13, 0, 13),
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 10),
                      child: Card(
                        margin: EdgeInsets.all(1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.0)),
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text("Time: " +
                                        list[index].documentID.substring(
                                            0,
                                            list[index].documentID.length -
                                                12)),
                                  ),
                                  Text(
                                    list[index].data["status"] == "0"
                                        ? "Order Place"
                                        : list[index].data["status"] == "1"
                                            ? "Order Confirm"
                                            : list[index].data["status"] == "2"
                                                ? "Order reject"
                                                : "complete",
                                  )
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text("Amount "),
                                  ),
                                  Text(list[index].data["totalAmount"] ??
                                      "Not Given")
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text("Payment "),
                                  ),
                                  Text(list[index].data["paymentMethod"] == "1"
                                      ? "By Cash"
                                      : "Payment Done")
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text("Instrutions about Delivery:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                  ),
                                ],
                              ),
                              Text(
                                  list[index].data["instructions"] ??
                                      "Not Given ",
                                  textAlign: TextAlign.left,
                                  maxLines: 3,
                                  overflow: TextOverflow.clip),
                              Column(
                                children:
                                    extrasList(list[index].data["extrasList"]),
                              ),
                              SizedBox(height: 8),
                              MySeparator(
                                color: Colors.grey,
                              ),
                              SizedBox(height: 8),
                              Column(
                                children:
                                    itemsList(list[index].data["iteamsList"]),
                              ),
                              SizedBox(height: 15),
                              list[index].data["status"] == "0"
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          InkWell(
                                            child: Text(
                                              "Accept",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onTap: () {
                                              Firestore.instance
                                                  .collection("Orders")
                                                  .document(
                                                      list[index].documentID)
                                                  .updateData({"status": "1"});
                                              setState(() {});
                                            },
                                          ),
                                          InkWell(
                                            child: Text(
                                              "Reject",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onTap: () {
                                              Firestore.instance
                                                  .collection("Orders")
                                                  .document(
                                                      list[index].documentID)
                                                  .updateData({"status": "2"});
                                              setState(() {});
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  : list[index].data["status"] == "1"
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              InkWell(
                                                child: Text(
                                                  "Completed",
                                                  style: TextStyle(
                                                      color: Colors.greenAccent,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onTap: () {
                                                  Firestore.instance
                                                      .collection("Orders")
                                                      .document(list[index]
                                                          .documentID)
                                                      .updateData(
                                                          {"status": "3"});
                                                  setState(() {});
                                                },
                                              ),
                                            ],
                                          ),
                                        )
                                      : list[index].data["status"] == "3"
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  InkWell(
                                                    child: Text(
                                                      "Deleat",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.redAccent,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onTap: () {
                                                      Firestore.instance
                                                          .collection("Orders")
                                                          .document(list[index]
                                                              .documentID)
                                                          .delete();

                                                      setState(() {});
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  InkWell(
                                                      child: Text(
                                                        "Deleat",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .redAccent,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      onTap: () {
                                                        Firestore.instance
                                                            .collection(
                                                                "Orders")
                                                            .document(
                                                                list[index]
                                                                    .documentID)
                                                            .delete();

                                                        setState(() {});
                                                      }),
                                                ],
                                              ),
                                            )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
          }
        }
      },
    );
  }

}
