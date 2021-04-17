import 'dart:ui';

import 'package:cathacks/constants.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nice_button/nice_button.dart';

import 'teacherPortal.dart';

class StartUpPage extends StatefulWidget {
  @override
  _StartUpPageState createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> {
  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/background.webp', fit: BoxFit.cover),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                color: Colors.grey.withOpacity(0.1),
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>TeacherPortal()));},
                          child: Container(
                              width: 260,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: gradient_butt),
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "For Teachers",
                                    style: font_def,
                                  ))),
                        ),
                        SizedBox(height: 10),
                        Container(
                            width: 260,
                            height: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: gradient2),
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "For Students",
                                  style: font_def,
                                ))),
                      ]),
                ),
              ),
            ),
          ),
          Align(alignment: Alignment.bottomCenter,child: GradientText(colors:[Color(0xFFb92b27),Color(0xFF1565C0)],text:'Made with 🖤 at CatHacks',style:GoogleFonts.roboto(fontSize: 30.0,color:Colors.white)))
        ],
      ),
    );
  }
}
