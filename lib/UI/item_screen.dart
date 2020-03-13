import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prince_of_pizza/Extra/global.dart';
import 'package:prince_of_pizza/Extra/styles.dart';
import 'package:prince_of_pizza/Model/Item.dart';
import 'package:prince_of_pizza/UI/cart_screen.dart';
import 'package:prince_of_pizza/UI/home_screen.dart';
import 'package:prince_of_pizza/dataBase/Database.dart';

int amount;
int type;
var topping;
double tPrice;
String currentPrice;
TextEditingController _controller;

class ItemScreen extends StatefulWidget {
  final String cata;
  final DocumentSnapshot data;
  ItemScreen(this.cata, this.data);
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  void initState() {
    super.initState();
    currentPrice = widget.data.data["price"];
    tPrice = double.parse(currentPrice.substring(1, currentPrice.length - 1));
    topping = List.generate(10, (i) => List(1), growable: false);
    type = 0;
    amount = 1;
    _controller = null;
    _controller = new TextEditingController();
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
          backgroundColor: Colors.white,
          body: ItemScreenBody(widget.cata, widget.data, fun),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (amount == 0) {
                Fluttertoast.showToast(
                    msg: 'Select the Quantity',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else if (type == 0) {
                Fluttertoast.showToast(
                    msg: 'Select the Type',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                MyGlobals.iteamsList.add(Item(
                    catagory: widget.cata,
                    subCatagory: widget.data.documentID,
                    quantity: amount,
                    price: tPrice * amount,
                    optional: _controller.text));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              }
            },
            icon: Icon(Icons.shopping_cart),
            label: Text('Add To Cart (' + (tPrice * amount).toString().substring(0,4) + "\$)"),
            backgroundColor: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}

String calculatePriceWithSymboles(String second, int i) {
  String first = currentPrice;
  if (first.contains("+") == true)
    first = first.substring(1, first.length - 1);
  else
    first = first.substring(0, first.length - 1);
  second = second.substring(0, second.length - 1);
  double pri = (double.parse(second) - double.parse(first));
  String val = pri.toString().length > 4 ? pri.toString().substring(0,5) : pri.toString();
  if (first == second) {
    type = i;
    String temp = tPrice.toString().length > 5 ? tPrice.toString().substring(0,4) : tPrice.toString();
    return temp + "\$";
  } else {
    if (val.contains("-") == true) return val + "\$";
    return "+" + val + "\$";
  }
}

String calculatePrice(String second, int i) {
  String first = currentPrice;
  if (first.contains("+") == true)
    first = first.substring(1, first.length - 1);
  else
    first = first.substring(0, first.length - 1);
  second = second.substring(0, second.length - 1);
  double pri = (double.parse(second) - double.parse(first));
  String val = pri.toString().length > 4 ? pri.toString().substring(0,4) : pri.toString();
  if (first == second) {
    type = i;
    String temp = tPrice.toString().length > 5 ? tPrice.toString().substring(0,4) : tPrice.toString();
    return temp;
  } else {
    if (val.contains("-") == true) return val;
    return val;
  }
}

List<Widget> typeWidget(Map<String, dynamic> documents, fun) {
  List<Widget> lines = [];
  int i = 1;
  documents.forEach((k, v) => () {
        lines.add(MySeparator(
          color: Colors.grey,
        ));
        lines.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SubTitleWidget(k),
            Spacer(),
            SubTitleWidget(calculatePriceWithSymboles(v, i)),
            SelectedButton(v, i, fun),
          ],
        ));
        i++;
      }());
  return lines;
}

List<Widget> addOnsHelpWidget1(QuerySnapshot data, fun) {
  List<Widget> lines = [];
  for (var i in data.documents) {
    lines.add(
      MySeparator(
        color: Colors.grey,
      ),
    );
    lines.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SubTitleWidget(i.documentID),
          Spacer(),
          SubTitleWidget("+\$" + i.data["0"].substring(0, i.data["0"].length - 1)),
          Icon(Icons.brightness_1, color: "1" == "1" ? Colors.redAccent : Colors.black)
        ],
      ),
    );
  }
  return lines;
}

List<Widget> addOnsHelpWidget3(QuerySnapshot data, fun) {
  List<Widget> lines = [];
  int j = 0;
  for (var i in data.documents) {
    lines.add(
      MySeparator(
        color: Colors.grey,
      ),
    );
    lines.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SubTitleWidget(i.documentID),
        CircleFills(j, fun, i.data),
      ],
    ));
    j++;
  }
  return lines;
}

List<Widget> addOnsWidget(List<DocumentSnapshot> documents, fun, String str1, String str2) {
  List<Widget> lines = [];
  for (DocumentSnapshot i in documents) {
    if (i.documentID == "Type") {
      lines.insert(
        0,
        HomeScreenCard(
          Column(
            children: <Widget>[
              TitleWidget(i.documentID),
              Column(
                children: typeWidget(i.data, fun),
              ),
            ],
          ),
        ),
      );
    } else if (i.data["cat"] == "3") {
      lines.add(
        HomeScreenCard(
          Column(
            children: <Widget>[
              TitleWidget(i.documentID),
              StreamBuilder<QuerySnapshot>(
                stream: DataBase.getAddOnsDetails(str1, str2, i.documentID),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: addOnsHelpWidget3(snapshot.data, fun));
                    }
                  }
                },
              )
            ],
          ),
        ),
      );
    } else {
      lines.add(
        StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return HomeScreenCard(
              Column(
                children: <Widget>[
                  TitleWidget(i.documentID),
                  StreamBuilder<QuerySnapshot>(
                    stream: DataBase.getAddOnsDetails(str1, str2, i.documentID),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: addOnsHelpWidget1(snapshot.data, fun),
                            );
                        }
                      }
                    },
                  )
                ],
              ),
            );
          },
        ),
      );
    }
  }
  return lines;
}

class ItemScreenBody extends StatefulWidget {
  final String cata;
  final DocumentSnapshot data;
  final Function fun;
  ItemScreenBody(this.cata, this.data, this.fun);
  @override
  _ItemScreenBodyState createState() => _ItemScreenBodyState();
}

class _ItemScreenBodyState extends State<ItemScreenBody> {
  var _futureForAddOns;

  @override
  initState() {
    super.initState();
    print('in initState about to call _getData');
    _futureForAddOns = DataBase.getAddOns(widget.cata, widget.data.documentID);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Center(child: TitleWidget(widget.data.documentID)),
        HomeScreenCard(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SubTitleWidget('Quantity'),
              QuantityButton(widget.fun),
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: _futureForAddOns,
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
                      ),
                    ),
                  );
                default:
                  return Column(
                    children: addOnsWidget(snapshot.data.documents, widget.fun,
                        widget.cata, widget.data.documentID),
                  );
              }
            }
          },
        ),
        HomeScreenCard(
          Column(
            children: <Widget>[
              HomeScreenCard(
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    decoration: new InputDecoration(
                      hintText: 'Add Special Requests (optional)',
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SubTitleWidget(
                  'We love special requests, but some may cost extra. If so we will adjust your total change after checkout'),
            ],
          ),
        ),
        SizedBox(
          height: 60,
        ),
      ],
    );
  }
}

class QuantityButton extends StatefulWidget {
  final Function fun;
  QuantityButton(this.fun);

  @override
  _QuantityButtonState createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          child: Container(
            width: 20.0,
            height: 20.0,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(25.0),
              border: new Border.all(
                width: 2.0,
                color: Colors.redAccent,
              ),
            ),
            child: Center(
              child: Text(
                '-',
                style: subtitle.copyWith(color: Colors.redAccent),
              ),
            ),
          ),
          onTap: () {
            if (amount != 1) {
              amount--;
              widget.fun();
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 30.0,
            height: 30.0,
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(25.0),
                color: Colors.redAccent),
            child: Center(
              child: Text(
                amount.toString(),
                style: subtitle.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            width: 20.0,
            height: 20.0,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(25.0),
              border: new Border.all(
                width: 2.0,
                color: Colors.redAccent,
              ),
            ),
            child: Center(
              child: Text(
                '+',
                style: subtitle.copyWith(color: Colors.redAccent),
              ),
            ),
          ),
          onTap: () {
            amount++;
            widget.fun();
          },
        ),
      ],
    );
  }
}

class SelectedButton extends StatefulWidget {
  final int _type;
  final String _val;
  final Function fun;
  SelectedButton(this._val, this._type, this.fun);

  @override
  _SelectedButtonState createState() => _SelectedButtonState();
}

class _SelectedButtonState extends State<SelectedButton> {
  void _handleRadioValueChange1(int value) {
    type = value;
    String str = calculatePrice(widget._val, value);
    tPrice = tPrice + double.parse(str);
    currentPrice = widget._val;
    widget.fun();
  }

  @override
  Widget build(BuildContext context) {
    return Radio(
      activeColor: Colors.redAccent,
      value: widget._type,
      groupValue: type,
      onChanged: _handleRadioValueChange1,
    );
  }
}

class CircleFills extends StatelessWidget {
  final int tag;
  final Function fun;
  final Map<String, dynamic> data;
  CircleFills(this.tag, this.fun, this.data);

  String getToppingTag(String i) {
    if (i != null) {
      String str = "+\$" + (this.data[i]);
      return str.substring(0, str.length - 1);
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SubTitleWidget(getToppingTag(topping[tag][0])),
        InkWell(
          onTap: () {
            if (topping[tag][0] != "0") {
              if (topping[tag][0] == "1") {
                String str = this.data[topping[tag][0]];
                tPrice =
                    tPrice - double.parse(str.substring(0, str.length - 1));
              }
              if (topping[tag][0] == "2") {
                String str = this.data[topping[tag][0]];
                tPrice =
                    tPrice - double.parse(str.substring(0, str.length - 1));
              }
              topping[tag][0] = "0";
              fun();
            }
          },
          child: Icon(Icons.panorama_fish_eye,
              color: topping[tag][0] == "0" ? Colors.redAccent : Colors.black),
        ),
        InkWell(
          onTap: () {
            if (topping[tag][0] != "1") {
              if (topping[tag][0] == "0") {
                String str = this.data[topping[tag][0]];
                tPrice =
                    tPrice - double.parse(str.substring(0, str.length - 1));
              }
              if (topping[tag][0] == "2") {
                String str = this.data[topping[tag][0]];
                tPrice =
                    tPrice - double.parse(str.substring(0, str.length - 1));
              }
              topping[tag][0] = "1";
              String str = this.data[topping[tag][0]];
              tPrice = tPrice + double.parse(str.substring(0, str.length - 1));
              fun();
            }
          },
          child: Icon(Icons.blur_circular,
              color: topping[tag][0] == "1" ? Colors.redAccent : Colors.black),
        ),
        InkWell(
          onTap: () {
            if (topping[tag][0] != "2") {
              if (topping[tag][0] == "0") {
                String str = this.data[topping[tag][0]];
                tPrice =
                    tPrice - double.parse(str.substring(0, str.length - 1));
              }
              if (topping[tag][0] == "1") {
                String str = this.data[topping[tag][0]];
                tPrice =
                    tPrice - double.parse(str.substring(0, str.length - 1));
              }
              topping[tag][0] = "2";

              String str = this.data[topping[tag][0]];
              tPrice = tPrice + double.parse(str.substring(0, str.length - 1));
              fun();
            }
          },
          child: Icon(Icons.brightness_1,
              color: topping[tag][0] == "2" ? Colors.redAccent : Colors.black),
        ),
      ],
    );
  }
}
