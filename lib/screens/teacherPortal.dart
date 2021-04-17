import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TeacherPortal extends StatefulWidget {
  @override
  _TeacherPortalState createState() => _TeacherPortalState();
}

class _TeacherPortalState extends State<TeacherPortal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Center(child: Lottie.asset('assets/welcome.json'),));
  }
}