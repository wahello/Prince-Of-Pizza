import 'package:braintree_payment/braintree_payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prince_of_pizza/Extra/global.dart';
import 'package:prince_of_pizza/Extra/styles.dart';
import 'package:prince_of_pizza/UI/home_screen.dart';
import 'package:prince_of_pizza/administration/admin.dart';
import 'package:prince_of_pizza/dataBase/auth.dart';
import 'package:prince_of_pizza/dataBase/dataBase.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

TextEditingController first = TextEditingController(),
    last = TextEditingController(),
    email = TextEditingController(),
    password = TextEditingController(),
    phoneno = TextEditingController(),
    location = TextEditingController(),
    unit = TextEditingController(),
    city = TextEditingController(),
    state = TextEditingController(),
    notes = TextEditingController(),
    label = TextEditingController();

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: CheckoutScreenBody1(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (first.text == "" ||
                  last.text == "" ||
                  email.text == "" ||
                  password.text == "" ||
                  phoneno.text == "")
                Fluttertoast.showToast(
                    msg: '  Fill the details  ',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              else
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutScreen2()),
                );
            },
            icon: Icon(Icons.arrow_forward),
            label: Text('Continue'),
            backgroundColor: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}

class CheckoutScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: CheckoutScreenBody3(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            icon: Icon(Icons.rate_review),
            label: Text('Review order'),
            backgroundColor: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}

class CheckoutScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: CheckoutScreenBody2(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              if (location.text == "" || city.text == "" || state.text == "")
                Fluttertoast.showToast(
                    msg: '  Fill the details  ',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              else {
                Map<String, dynamic> info = new Map<String, dynamic>();
                info["firstN"] = first.text;
                info["lastN"] = last.text;
                info["location"] = location.text;
                info["city"] = city.text;
                info["state"] = state.text;
                info["password"] = password.text;
                info["phoneno"] = phoneno.text;
                info["unit"] = unit.text;
                info["notes"] = notes.text;
                info["label"] = label.text;
                info["email"] = email.text;
                MyGlobals.currentUser.profileName =
                    first.text + " " + last.text;
                MyGlobals.currentUser.location = location.text;
                MyGlobals.currentUser.city = city.text;
                MyGlobals.currentUser.state = state.text;
                MyGlobals.currentUser.phoneno = phoneno.text;
                MyGlobals.currentUser.unit = unit.text;
                MyGlobals.currentUser.notes = notes.text;
                MyGlobals.currentUser.label = label.text;
                MyGlobals.currentUser.email = email.text;
                MyGlobals.currentUser.firebaseId =
                    await Accounts.signUpWithEmail(email.text, password.text);
                await DataBase.setUserDetails(
                    MyGlobals.currentUser.firebaseId, info);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutScreen3()),
                );
              }
            },
            icon: Icon(Icons.arrow_forward),
            label: Text('Continue'),
            backgroundColor: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}

class Field extends StatelessWidget {
  final String hint;
  final Icon icon;
  final TextEditingController _controller;
  final TextInputType _type;

  Field(this.hint, this._controller, this._type, {this.icon});

  @override
  Widget build(BuildContext context) {
    return HomeScreenCard(
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextField(
          controller: _controller,
          keyboardType: _type,
          decoration: new InputDecoration(
            icon: icon,
            hintText: hint,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class CheckoutScreenBody1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Align(child: SubTitleWidget('Checkout')),
            Align(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SignInWidget(),
              ),
              alignment: Alignment.centerRight,
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
        ),
        Center(
            child: Image.asset(
          'assets/progress1.png',
          height: 10,
        )),
        Center(child: TitleWidget('Personal Info')),
        MySeparator(
          color: Colors.grey,
        ),
        Center(child: SubTitleWidget('Enter yours below to start an account')),
        Field('First Name', first, TextInputType.text),
        Field('Last Name', last, TextInputType.text),
        Field('Email Address', email, TextInputType.emailAddress),
        Field('Password', password, TextInputType.visiblePassword),
        Field('Phone Number', phoneno, TextInputType.phone),
        MySeparator(
          color: Colors.grey,
        ),
        SizedBox(height: 100)
      ],
    );
  }
}

class CheckoutScreenBody2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Align(child: SubTitleWidget('Checkout')),
            Align(
              child: SignInWidget(),
              alignment: Alignment.centerRight,
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
        ),
        Center(
            child: Image.asset(
          'assets/progress2.png',
          height: 10,
        )),
        Center(child: TitleWidget('Location Info')),
        MySeparator(
          color: Colors.grey,
        ),
        Center(
            child:
                SubTitleWidget('Tell us where you want your food delivered.')),
        Field(
          'Location',
          location,
          TextInputType.text,
          icon: Icon(Icons.location_on),
        ),
        Field('Unit (optional)', unit, TextInputType.number),
        Field('City', city, TextInputType.text),
        Field('State', state, TextInputType.text),
        Field('Notes - eg, Buzz #237 (optional)', notes, TextInputType.text),
        Field('Label - eg, Home (optional)', label, TextInputType.text),
        // Padding(
        //   padding: const EdgeInsets.all(30),
        //   child: FlatButton(
        //     child: Text(
        //       'Add Alternate Address',
        //       style: title.copyWith(color: Colors.white),
        //     ),
        //     color: Colors.redAccent,
        //     onPressed: () {
        //       homeAddressAlert(context);
        //     },
        //   ),
        // ),
        MySeparator(
          color: Colors.grey,
        ),
        SizedBox(height: 100)
      ],
    );
  }
}

class CheckoutScreenBody3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Align(child: SubTitleWidget('Checkout')),
            Align(
              child: SignOutWidget(),
              alignment: Alignment.centerRight,
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
        ),
        HomeScreenCard(
          Column(
            children: <Widget>[
              Center(
                  child: Image.asset(
                'assets/progress3.png',
                height: 10,
              )),
              Center(child: TitleWidget('Payment Info')),
              MySeparator(
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                              child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Colors.redAccent),
                          ));
                        });
                    BraintreePayment braintreePayment = new BraintreePayment();
                    braintreePayment
                        .showDropIn(
                            nonce: MyGlobals.clientNonce,
                            amount: MyGlobals.countMoney().toString(),
                            enableGooglePay: true)
                        .then((data) {
                      if (data['status'] == "success") {
                        Navigator.pop(context);
                        Navigator.pop(context);

                        Fluttertoast.showToast(
                            msg: ' Payment Successfully ',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: ' Payment Failed ',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.redAccent,
                      ),
                      SubTitleWidget('  Payment by a Card'),
                    ],
                  ),
                ),
              ),
              MySeparator(
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.attach_money,
                        color: Colors.redAccent,
                      ),
                      SubTitleWidget('  Cash'),
                    ],
                  ),
                ),
              ),
              MySeparator(
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.payment,
                        color: Colors.redAccent,
                      ),
                      SubTitleWidget('  Paypal'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        MySeparator(
          color: Colors.grey,
        ),
        SizedBox(height: 100)
      ],
    );
  }
}

class SignInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(
          'Sign In',
          style: subtitle.copyWith(
              fontWeight: FontWeight.bold, color: Colors.redAccent),
        ),
      ),
      onTap: () {
        signInAlert(context);
      },
    );
  }
}

class SignOutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(
          'Sign Out',
          style: subtitle.copyWith(
              fontWeight: FontWeight.bold, color: Colors.redAccent),
        ),
      ),
      onTap: () {
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
    );
  }
}

void homeAddressAlert(BuildContext context) {
  Alert(
      context: context,
      title: "Alternate Address",
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.location_on),
              labelText: 'Location',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Unit (optional)',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'City',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'State',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: FlatButton(
              child: Text(
                'Add',
                style: title.copyWith(color: Colors.white),
              ),
              color: Colors.redAccent,
              onPressed: () {
                homeAddressAlert(context);
              },
            ),
          ),
        ],
      ),
      buttons: []).show();
}

void signInAlert(BuildContext context) {
  Alert(
      context: context,
      title: "Sign In",
      content: Column(
        children: <Widget>[
          TextField(
            controller: email,
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              labelText: 'Email Address',
            ),
          ),
          TextField(
            controller: password,
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline),
              labelText: 'Password',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: FlatButton(
              child: Text(
                'Sign In',
                style: title.copyWith(color: Colors.white),
              ),
              color: Colors.redAccent,
              onPressed: () async {
                if (email.text == "" || password.text == "") {
                  Fluttertoast.showToast(
                      msg: '  Fill the details  ',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  MyGlobals.currentUser.firebaseId = await Accounts.signInWithEmail(email.text, password.text);
                  if (MyGlobals.currentUser.firebaseId == null) {
                    Fluttertoast.showToast(
                        msg: '  Enter Corrent Email or Password  ',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    Navigator.pop(context);
                    if(email.text == "prince@of.pizza"){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminPanal())
                      );
                    }
                    else{
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutScreen3()),
                      );
                    }
                  }
                }
//                homeAddressAlert(context);
              },
            ),
          ),
        ],
      ),
      buttons: []).show();
}
