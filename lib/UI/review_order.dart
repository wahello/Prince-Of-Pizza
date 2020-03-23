import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell/widget.dart';
import 'package:prince_of_pizza/Extra/global.dart';
import 'package:prince_of_pizza/dataBase/Database.dart';

TextEditingController _controller;

class ReviewOrders extends StatelessWidget {
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
              MyGlobals.myOrder.instructions = _controller.text == null ? "" : _controller.text;
              Navigator.pop(context);
            },
            icon: Icon(Icons.local_pizza),
            label: Text('Confirm'),
            backgroundColor: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}

class HomeScreenBody extends StatelessWidget {

  final _foldingCellLocationKey = GlobalKey<SimpleFoldingCellState>();
  final _foldingCellPayKey = GlobalKey<SimpleFoldingCellState>();

  _temp() {
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    _controller = new TextEditingController();
    return Container(
      color: Color(0xFF2e282a),
      alignment: Alignment.topCenter,
      child: StreamBuilder<DocumentSnapshot>(
        stream: DataBase.getUserDetails(MyGlobals.currentUser.firebaseId),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                return ListView(
                  children: [
                    SizedBox(height: 20),
                    SimpleFoldingCell(
                      key: _foldingCellLocationKey,
                      frontWidget: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 5),
                              Icon(Icons.check_circle_outline),
                              SizedBox(width: 15),
                              Column(
                                children: <Widget>[
                                  Text("Delivery ASAP",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  Spacer(),
                                  Text(snapshot.data.data["location"]),
                                ],
                              ),
                              Spacer(),
                              SizedBox(width: 5),
                              InkWell(
                                child: Icon(Icons.keyboard_arrow_down),
                                onTap: () => _foldingCellLocationKey
                                    ?.currentState
                                    ?.toggleFold(),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                      innerTopWidget: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 15),
                              Column(
                                children: <Widget>[
                                  Text("Location Details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  Spacer(),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 80,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("Unit"),
                                        Text(snapshot.data.data["unit"]),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 80,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("City"),
                                        Text(snapshot.data.data["city"]),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      innerBottomWidget: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 120,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("State"),
                                        Text(snapshot.data.data["state"]),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 120,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("Notes"),
                                        Text(
                                          snapshot.data.data["notes"] == ""
                                              ? "Not Given"
                                              : snapshot.data.data["notes"],
                                        )
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 120,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text("Label"),
                                        Text(snapshot.data.data["label"] == ""
                                            ? "Not Given"
                                            : snapshot.data.data["label"]),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              InkWell(
                                child: Icon(Icons.keyboard_arrow_up),
                                onTap: () => _foldingCellLocationKey
                                    ?.currentState
                                    ?.toggleFold(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      cellSize: Size(MediaQuery.of(context).size.width, 70),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      animationDuration: Duration(milliseconds: 200),
                      borderRadius: 10,
                    ),
                    SimpleFoldingCell(
                        key: null,
                        frontWidget: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 5),
                                Icon(Icons.check_circle_outline),
                                SizedBox(width: 15),
                                Column(
                                  children: <Widget>[
                                    Text(
                                        snapshot.data.data["firstN"] +
                                            " " +
                                            snapshot.data.data["lastN"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    Spacer(),
                                    Text(snapshot.data.data["email"] +
                                        " | " +
                                        snapshot.data.data["phoneno"]),
                                  ],
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                        innerTopWidget: _temp(),
                        innerBottomWidget: _temp(),
                        cellSize: Size(MediaQuery.of(context).size.width, 70),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        animationDuration: Duration(milliseconds: 200),
                        borderRadius: 10),
                    SimpleFoldingCell(
                      key: _foldingCellPayKey,
                      frontWidget: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 5),
                              Icon(Icons.check_circle_outline),
                              SizedBox(width: 15),
                              Column(
                                textDirection: TextDirection.ltr,
                                children: <Widget>[
                                  Text("Order Options",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  Spacer(),
                                  Text("Delivery Tip",
                                  textDirection: TextDirection.ltr,
                                    style: TextStyle(color: Colors.black)),
                                  Spacer(),
                                  Text(
                                    "Add Instructions",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              Spacer(),
                              SizedBox(width: 5),
                              InkWell(
                                child: Icon(Icons.keyboard_arrow_down),
                                onTap: () => _foldingCellPayKey?.currentState
                                    ?.toggleFold(),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                      innerTopWidget: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 15),
                              Column(
                                children: <Widget>[
                                  Spacer(),
                                  Text("Tip: Cash",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  Spacer(),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 80,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                            "Be nice and tip well. Unlink other apps,"),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 80,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("every penny goes to the shop."),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      innerBottomWidget: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Spacer(),
                                  Container(
                                      width: MediaQuery.of(context).size.width -
                                          120,
                                      child: TextField(
                                        controller: _controller,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                'Delivery Instructions (optional)'),
                                      )),
                                  Spacer(),
                                ],
                              ),
                              Spacer(),
                              InkWell(
                                child: Icon(Icons.keyboard_arrow_up),
                                onTap: () => _foldingCellPayKey?.currentState
                                    ?.toggleFold(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      cellSize: Size(MediaQuery.of(context).size.width, 81),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      animationDuration: Duration(milliseconds: 200),
                      borderRadius: 10,
                    ),
                    SizedBox(height: 80),
                  ],
                );
            }
          }
        },
      ),
    );
  }
}
