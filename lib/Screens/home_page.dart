import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // prop ...
  static String id = 'HomePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('welcome to home page'),
      ),
    );
  }
}
