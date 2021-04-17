import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:cathacks/screens/startupPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
   
    win.alignment = Alignment.center;
    win.title = "";
    win.show();
  });
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartUpPage(),
    );
  }
}

