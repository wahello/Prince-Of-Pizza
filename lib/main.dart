import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:prince_of_pizza/UI/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplash(
        imagePath: 'assets/logo.png',
        home: HomeScreen(),
        duration: 2500,
      ),
    );
  }
}

