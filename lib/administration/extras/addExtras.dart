import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prince_of_pizza/administration/extras/listExtras.dart';
import 'package:prince_of_pizza/dataBase/dataBase.dart';

class AddExtras extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Add Extra';
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
  GlobalKey<FormBuilderState> _fbKey;
  @override
  void initState() {
    super.initState();
    _fbKey = GlobalKey<FormBuilderState>();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: [
        Column(
          children: <Widget>[
            FormBuilder(
              key: _fbKey,
              initialValue: {
                // 'line': snapshot.data.documents[0].data["line"],
                // 'price': snapshot.data.documents[0].data["price"],
                // 'name': snapshot.data.documents[0].data["name"],
              },
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 5),
                  FormBuilderTextField(
                    attribute: "name",
                    decoration: InputDecoration(labelText: "Name"),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(3),
                      FormBuilderValidators.maxLength(18),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: "line",
                    decoration: InputDecoration(labelText: "Line"),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(20),
                      FormBuilderValidators.maxLength(40),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: "price",
                    decoration: InputDecoration(labelText: "Price in \$"),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.min(0.5),
                      FormBuilderValidators.maxLength(20),
                    ],
                  ),
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
                  String line = _fbKey.currentState.value['line'];
                  String price = _fbKey.currentState.value['price'];
                  Fluttertoast.showToast(
                      msg: ' Please Wait ',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  await DataBase.setExtraIteams(name, price, line);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ListExtras()),
                  );
                }
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ],
    );
  }
}
