import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prince_of_pizza/dataBase/dataBase.dart';

class BasicInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Edit Basic Info';
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
  File _file;
  @override
  void initState() {
    super.initState();
    _file = null;
    _fbKey = GlobalKey<FormBuilderState>();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DataBase.getBasicInfo(),
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
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Column(
                    children: <Widget>[
                      FormBuilder(
                        key: _fbKey,
                        initialValue: {
                          'address': snapshot.data.documents[0].data["address"],
                          'line': snapshot.data.documents[0].data["line"],
                          'closing': snapshot.data.documents[0].data["timeing"],
                          'name': snapshot.data.documents[0].data["name"],
                          'discount': snapshot.data.documents[1].data["details"]
                              .toString()
                              .replaceAll(",", "\n")
                        },
                        autovalidate: true,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 5),
                            InkWell(
                              onTap: () async {
                                _file = await FilePicker.getFile(
                                    type: FileType.IMAGE);
                                setState(() {});
                              },
                              child: _file == null
                                  ? CachedNetworkImage(
                                      width: 320,
                                      height: 300,
                                      fit: BoxFit.cover,
                                      imageUrl: snapshot
                                          .data.documents[2].data["logo"],
                                      placeholder: (context, url) => Container(
                                        width: 45,
                                        height: 45,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                new AlwaysStoppedAnimation<
                                                    Color>(Colors.redAccent),
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.error,
                                        color: Colors.redAccent,
                                        size: 30,
                                      ),
                                    )
                                  : Image.file(
                                      _file,
                                      width: 320,
                                      height: 300,
                                    ),
                            ),
                            FormBuilderTextField(
                              attribute: "name",
                              decoration: InputDecoration(labelText: "Name"),
                              validators: [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.minLength(5),
                                FormBuilderValidators.maxLength(25),
                              ],
                            ),
                            FormBuilderTextField(
                              attribute: "address",
                              decoration: InputDecoration(labelText: "Address"),
                              validators: [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.minLength(25),
                                FormBuilderValidators.maxLength(40),
                              ],
                            ),
                            FormBuilderTextField(
                              attribute: "line",
                              decoration: InputDecoration(labelText: "Line"),
                              validators: [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.minLength(30),
                                FormBuilderValidators.maxLength(40),
                              ],
                            ),
                            FormBuilderTextField(
                              attribute: "closing",
                              decoration: InputDecoration(labelText: "Closing"),
                              validators: [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.minLength(10),
                                FormBuilderValidators.maxLength(20),
                              ],
                            ),
                            FormBuilderTextField(
                              attribute: "discount",
                              decoration: InputDecoration(
                                  labelText:
                                      "Discount  < Next Line New Discount >"),
                              validators: [],
                            ),
                            FormBuilderCheckbox(
                              attribute: 'accept_terms',
                              label: Text(
                                  "I have read and agree to the Update the basic Info"),
                              validators: [
                                FormBuilderValidators.requiredTrue(
                                  errorText: "You must accept this to continue",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      MaterialButton(
                        color: Colors.redAccent,
                        child: Text("Update",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          if (_fbKey.currentState.saveAndValidate()) {
                            String name = _fbKey.currentState.value['name'];
                            String address =
                                _fbKey.currentState.value['address'];
                            String line = _fbKey.currentState.value['line'];
                            String discounts =
                                _fbKey.currentState.value['discount'];
                            String timeing =
                                _fbKey.currentState.value['closing'];
                            Fluttertoast.showToast(
                                msg: ' Please Wait ',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            await DataBase.setBasicInfo(context, address, line,
                                name, timeing, discounts, _file);
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
      },
    );
  }
}
