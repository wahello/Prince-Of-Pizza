import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prince_of_pizza/dataBase/dataBase.dart';
import 'package:random_string/random_string.dart';
import 'listCatagories.dart';

class AddPizza extends StatelessWidget {
  final List<DocumentSnapshot> cata;
  AddPizza(this.cata);

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Add Pizza';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(appTitle),
        ),
        body: MyCustomForm(cata),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  final List<DocumentSnapshot> cata;
  MyCustomForm(this.cata);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  GlobalKey<FormBuilderState> _fbKey;
  List<Widget> optWidget;
  List<String> listHeader;
  Map<String, Map<String, Map<String, String>>> widgetList;

  @override
  void initState() {
    super.initState();
    _fbKey = GlobalKey<FormBuilderState>();
    optWidget = new List<Widget>();
    listHeader = new List<String>();
    widgetList = new Map<String, Map<String, Map<String, String>>>();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 15),
      children: [
        Column(
          children: <Widget>[
            FormBuilder(
              key: _fbKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 5),
                  FormBuilderDropdown(
                    attribute: "catagory",
                    decoration: InputDecoration(labelText: "Catagory"),
                    hint: Text('Select Catagory'),
                    validators: [FormBuilderValidators.required()],
                    items: widget.cata
                        .map((cat) => DropdownMenuItem(
                            value: cat.documentID, child: Text(cat.documentID)))
                        .toList(),
                  ),
                  FormBuilderTextField(
                    attribute: "name",
                    decoration: InputDecoration(labelText: "Name"),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(3),
                      FormBuilderValidators.maxLength(25),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: "tagp",
                    decoration: InputDecoration(
                        labelText:
                            "TagPrice(Must be Equal to Anyone of the Type)"),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.max(200),
                      FormBuilderValidators.numeric(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: "tags",
                    decoration: InputDecoration(labelText: "Tags"),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(3),
                      FormBuilderValidators.maxLength(50),
                    ],
                  ),
                  Row(children: [
                    Container(
                      width: width * 0.6,
                      child: FormBuilderTextField(
                        attribute: "type1",
                        decoration: InputDecoration(labelText: "Type"),
                        validators: [
                          FormBuilderValidators.required(),
                        ],
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: width * 0.3,
                      child: FormBuilderTextField(
                        attribute: "price1",
                        decoration: InputDecoration(labelText: "Price"),
                        validators: [
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.max(200),
                          FormBuilderValidators.required(),
                        ],
                      ),
                    ),
                  ]),
                  Row(children: [
                    Container(
                      width: width * 0.6,
                      child: FormBuilderTextField(
                        attribute: "type2",
                        decoration:
                            InputDecoration(labelText: "Type (Optional)"),
                        validators: [],
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: width * 0.3,
                      child: FormBuilderTextField(
                        attribute: "price2",
                        decoration:
                            InputDecoration(labelText: "Price (Optional)"),
                        validators: [
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.max(200),
                        ],
                      ),
                    ),
                  ]),
                  Row(children: [
                    Container(
                      width: width * 0.6,
                      child: FormBuilderTextField(
                        attribute: "type3",
                        decoration:
                            InputDecoration(labelText: "Type (Optional)"),
                        validators: [],
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: width * 0.3,
                      child: FormBuilderTextField(
                        attribute: "price3",
                        decoration:
                            InputDecoration(labelText: "Price (Optional)"),
                        validators: [
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.max(200),
                        ],
                      ),
                    ),
                  ]),
                  Row(children: [
                    Container(
                      width: width * 0.6,
                      child: FormBuilderTextField(
                        attribute: "type4",
                        decoration:
                            InputDecoration(labelText: "Type (Optional)"),
                        validators: [],
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: width * 0.3,
                      child: FormBuilderTextField(
                        attribute: "price4",
                        decoration:
                            InputDecoration(labelText: "Price (Optional)"),
                        validators: [
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.max(200),
                        ],
                      ),
                    ),
                  ]),
                  SizedBox(height: 20),
                  Column(children: optWidget),
                  SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 70,
                          child: InkWell(
                            onTap: () {
                              widget2(context);
                            },
                            child: Row(children: [
                              Spacer(),
                              Icon(Icons.add_circle_outline),
                              Text("Header"),
                              Spacer(),
                            ]),
                          ),
                        ),
                        Container(
                          width: 130,
                          child: InkWell(
                            onTap: () {
                              widget1(context);
                            },
                            child: Row(children: [
                              Spacer(),
                              Icon(Icons.add_circle_outline),
                              Text("1 options Widget"),
                              Spacer(),
                            ]),
                          ),
                        ),
                        Container(
                          width: 130,
                          child: InkWell(
                            onTap: () {
                              widget3(context);
                            },
                            child: Row(children: [
                              Spacer(),
                              Icon(Icons.add_circle_outline),
                              Text("3 options Widget"),
                              Spacer(),
                            ]),
                          ),
                        ),
                      ]),
                  SizedBox(height: 15),
                ],
              ),
            ),
            SizedBox(height: 10),
            MaterialButton(
              color: Colors.redAccent,
              child: Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (_fbKey.currentState.saveAndValidate()) {
                  String name = _fbKey.currentState.value['name'];
                  String cat = _fbKey.currentState.value['catagory'];
                  String price = _fbKey.currentState.value['tagp'];
                  String tags = _fbKey.currentState.value['tags'];
                  String type1 = _fbKey.currentState.value['type1'];
                  String price1 = _fbKey.currentState.value['price1'];
                  String type2 = _fbKey.currentState.value['type2'];
                  String price2 = _fbKey.currentState.value['price2'];
                  String type3 = _fbKey.currentState.value['type3'];
                  String price3 = _fbKey.currentState.value['price3'];
                  String type4 = _fbKey.currentState.value['type4'];
                  String price4 = _fbKey.currentState.value['price4'];
                  if (price == price1 || price == price2 || price == price3 || price == price4) {
                    Fluttertoast.showToast(
                        msg: ' Please Wait ',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Map<String, dynamic> str = new Map<String, dynamic>();
                    str[type1] = price1 + "\$";
                    if (price2 != "") {
                      str[type2] = price2 + "\$";
                      if (price3 != "") {
                        str[type3] = price3 + "\$";
                        if (price4 != "") {
                          str[type4] = price4 + "\$";
                        }
                      }
                    }
                    await DataBase.setPizza(cat, name,
                        {"price": "\$" + price + "+", "tag": tags}, str, widgetList);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListCatagoriesForPizza()),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: ' Wrong Tag Price ',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                }
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ],
    );
  }

  void widget1(BuildContext context) {
    GlobalKey<FormBuilderState> _wfbKey = GlobalKey<FormBuilderState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Add 1 Option Widget"),
            content: Container(
              width: 550,
              height: 150,
              child: Center(
                child: FormBuilder(
                  key: _wfbKey,
                  autovalidate: true,
                  child: ListView(children: [
                    Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        FormBuilderDropdown(
                          attribute: "header",
                          decoration: InputDecoration(labelText: "Header"),
                          hint: Text('Select Header'),
                          validators: [FormBuilderValidators.required()],
                          items: listHeader
                              .map((header) => DropdownMenuItem(
                                  value: header, child: Text("$header")))
                              .toList(),
                        ),
                        Row(children: [
                          Container(
                            width: 150,
                            child: FormBuilderTextField(
                              attribute: "OT1",
                              decoration: InputDecoration(labelText: "Tag"),
                              validators: [
                                FormBuilderValidators.required(),
                              ],
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: 80,
                            child: FormBuilderTextField(
                              attribute: "OP1",
                              decoration:
                                  InputDecoration(labelText: "Price \$"),
                              validators: [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.numeric(),
                                FormBuilderValidators.max(200),
                              ],
                            ),
                          ),
                        ]),
                        SizedBox(height: 5),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15)),
            actions: <Widget>[
              new FlatButton(
                child: Text("Add"),
                onPressed: () {
                  if (_wfbKey.currentState.saveAndValidate()) {
                    String oT1 = _wfbKey.currentState.value['OT1'];
                    String oP1 = _wfbKey.currentState.value['OP1'];
                    String header = _wfbKey.currentState.value['header'];
                    Map<String, Map<String, String>> temp = widgetList[header];
                    temp["1"+randomAlpha(5)] = {"name": oT1, "0": oP1};
                    widgetList[header] = temp;
                    optWidget.add(
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(children: [
                          Text(oT1),
                          Spacer(),
                          Text("\$" + oP1),
                        ]),
                      ),
                    );
                    setState(() {});
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        });
  }

  void widget3(BuildContext context) {
    GlobalKey<FormBuilderState> _wfbKey = GlobalKey<FormBuilderState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Add 3 Option Widget"),
            content: Container(
              width: 550,
              height: 200,
              child: Center(
                child: FormBuilder(
                  key: _wfbKey,
                  autovalidate: true,
                  child: ListView(children: [
                    Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        FormBuilderDropdown(
                          attribute: "header",
                          decoration: InputDecoration(labelText: "Header"),
                          hint: Text('Select Header'),
                          validators: [FormBuilderValidators.required()],
                          items: listHeader
                              .map((header) => DropdownMenuItem(
                                  value: header, child: Text("$header")))
                              .toList(),
                        ),
                        Row(children: [
                          Container(
                            width: 200,
                            child: FormBuilderTextField(
                              attribute: "OT1",
                              decoration: InputDecoration(labelText: "Tag"),
                              validators: [
                                FormBuilderValidators.required(),
                              ],
                            ),
                          ),
                        ]),
                        Row(children: [
                          Container(
                            width: 80,
                            child: FormBuilderTextField(
                              attribute: "OP11",
                              decoration:
                                  InputDecoration(labelText: "Price \$"),
                              validators: [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.numeric(),
                                FormBuilderValidators.max(200),
                              ],
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: 80,
                            child: FormBuilderTextField(
                              attribute: "OP12",
                              decoration:
                                  InputDecoration(labelText: "Price \$"),
                              validators: [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.numeric(),
                                FormBuilderValidators.max(200),
                              ],
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: 80,
                            child: FormBuilderTextField(
                              attribute: "OP13",
                              decoration:
                                  InputDecoration(labelText: "Price \$"),
                              validators: [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.numeric(),
                                FormBuilderValidators.max(200),
                              ],
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15)),
            actions: <Widget>[
              new FlatButton(
                child: Text("Add"),
                onPressed: () {
                  if (_wfbKey.currentState.saveAndValidate()) {
                    String oT1 = _wfbKey.currentState.value['OT1'];
                    String oP11 = _wfbKey.currentState.value['OP11'];
                    String oP12 = _wfbKey.currentState.value['OP12'];
                    String oP13 = _wfbKey.currentState.value['OP13'];
                    String header = _wfbKey.currentState.value['header'];
                    
                    Map<String, Map<String, String>> temp = widgetList[header];
                    temp["3"+randomAlpha(5)] = {"name": oT1, "0": oP11, "1": oP12, "2": oP13 };
                    widgetList[header] = temp;
                    
                    optWidget.add(
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(children: [
                          Text(oT1),
                          Spacer(),
                          Text("\$" + oP11),
                          SizedBox(width: 14),
                          Text("\$" + oP12),
                          SizedBox(width: 14),
                          Text("\$" + oP13),
                        ]),
                      ),
                    );
                    setState(() {});
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        });
  }

  void widget2(BuildContext context) {
    GlobalKey<FormBuilderState> _wfbKey = GlobalKey<FormBuilderState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Add 1 Option Widget"),
            content: Container(
              width: 550,
              height: 150,
              child: Center(
                child: FormBuilder(
                  key: _wfbKey,
                  autovalidate: true,
                  child: ListView(children: [
                    Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        Row(children: [
                          Container(
                            width: 250,
                            child: FormBuilderTextField(
                              attribute: "OT1",
                              decoration: InputDecoration(labelText: "Header"),
                              validators: [
                                FormBuilderValidators.required(),
                              ],
                            ),
                          ),
                        ]),
                        SizedBox(height: 5),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15)),
            actions: <Widget>[
              new FlatButton(
                child: Text("Add"),
                onPressed: () {
                  if (_wfbKey.currentState.saveAndValidate()) {
                    String oT1 = _wfbKey.currentState.value['OT1'];
                    listHeader.add(oT1);
                    optWidget.add(
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(children: [
                          Text(oT1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 15)),
                        ]),
                      ),
                    );
                    if (widgetList.containsKey(oT1) == false)
                      widgetList[oT1] = Map<String, Map<String, String>>();
                    setState(() {});
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        });
  }

}
