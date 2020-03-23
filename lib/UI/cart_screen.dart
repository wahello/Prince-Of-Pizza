import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prince_of_pizza/Extra/global.dart';
import 'package:prince_of_pizza/Extra/styles.dart';
import 'package:prince_of_pizza/Model/Item.dart';
import 'package:prince_of_pizza/UI/checkout_screen.dart';
import 'package:prince_of_pizza/UI/home_screen.dart';
import 'package:prince_of_pizza/UI/menu_screen.dart';
import 'package:prince_of_pizza/dataBase/Database.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  fun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: CartScreenBody(fun),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              MyGlobals.myOrder.status = "0";
              MyGlobals.myOrder.totalAmount =
                  MyGlobals.countMoney().toString().length > 8
                      ? "\$" + MyGlobals.countMoney().toString().substring(0, 8)
                      : "\$" + MyGlobals.countMoney().toString().toString();
              if (await FirebaseAuth.instance.currentUser() != null)
                MyGlobals.currentUser.firebaseId =
                    (await FirebaseAuth.instance.currentUser()).uid;
              else
                MyGlobals.currentUser.firebaseId = null;
              if (MyGlobals.currentUser.firebaseId == null)
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutScreen()),
                );
              else
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutScreen3()),
                );
            },
            icon: Icon(Icons.attach_money),
            label: Text('Proceed to Checkout'),
            backgroundColor: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}

class CartScreenBody extends StatefulWidget {
  final Function fun;
  CartScreenBody(this.fun);
  @override
  _CartScreenBodyState createState() => _CartScreenBodyState();
}

class _CartScreenBodyState extends State<CartScreenBody> {
  List<Widget> extraItemsWidget(List<DocumentSnapshot> documents, fun) {
    List<Widget> lines = [];
    for (DocumentSnapshot i in documents) {
      lines.add(
        HomeScreenCard(
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MenuTitleWidget(i.documentID),
                  SubTitleWidget(i.data["price"]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SubTitleWidget(i.data["tag"]),
                  InkWell(
                    onTap: () {
                      if (MyGlobals.extrasList[i.documentID] == null)
                        MyGlobals.extrasList[i.documentID] = i.data["price"];
                      else
                        MyGlobals.extrasList.remove(i.documentID);
                      fun();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        MyGlobals.extrasList[i.documentID] == null
                            ? Icons.add_circle_outline
                            : Icons.check_circle_outline,
                        color: MyGlobals.extrasList[i.documentID] == null
                            ? Colors.redAccent
                            : Colors.greenAccent,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }
    return lines;
  }

  List<Widget> addItemsWidget() {
    List<Widget> lines = [];
    for (Item i in MyGlobals.iteamsList) {
      lines.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SubTitleWidget(i.quantity.toString() + ' ' + i.subCatagory),
            SubTitleWidget(i.price.toString().length > 4
                ? "\$" + i.price.toString().substring(0, 4)
                : "\$" + i.price.toString()),
          ],
        ),
      );
      lines.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SubTitleWidget(i.catagory),
            InkWell(
              onTap: () {
                MyGlobals.iteamsList.remove(i);
                if (MyGlobals.iteamsList.length == 0) Navigator.pop(context);
                widget.fun();
              },
              child: Icon(
                Icons.close,
                color: Colors.grey,
              ),
            )
          ],
        ),
      );
      lines.add(
        MySeparator(
          color: Colors.grey,
        ),
      );
    }
    lines.add(
      FlatButton(
        child: Text(
          'Add More Items',
          style: title.copyWith(color: Colors.white),
        ),
        color: Colors.redAccent,
        onPressed: () => Navigator.pop(context),
      ),
    );

    return lines;
  }

  var _futureForExtra;

  @override
  initState() {
    super.initState();
    _futureForExtra = DataBase.getExtraIteams();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Center(
          child: TitleWidget('Cart'),
        ),
        HomeScreenCard(
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: addItemsWidget(),
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
        Center(
            child: Column(
          children: <Widget>[
            TitleWidget('Slides You Gotta Try'),
            SubTitleWidget('Treat yourself to a few extras.')
          ],
        )),
        StreamBuilder<QuerySnapshot>(
          stream: _futureForExtra,
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
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: extraItemsWidget(
                            snapshot.data.documents, widget.fun),
                      ),
                    ),
                  );
              }
            }
          },
        ),
        Divider(
          color: Colors.grey,
        ),
        HomeScreenCard(
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MenuTitleWidget('Subtotal'),
                  SubTitleWidget(MyGlobals.countMoney().toString().length > 8
                      ? "\$" + MyGlobals.countMoney().toString().substring(0, 8)
                      : "\$" + MyGlobals.countMoney().toString().toString()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SubTitleWidget(' Before Delivery fee and taxes'),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 60)
      ],
    );
  }
}
