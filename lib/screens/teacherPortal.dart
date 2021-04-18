import 'dart:convert';

import 'package:animated_progress_button/animated_progress_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cathacks/constants.dart';
import 'package:cathacks/utils/toExcel.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import "package:http/http.dart" as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class TeacherPortal extends StatefulWidget {
  @override
  _TeacherPortalState createState() => _TeacherPortalState();
}

class _TeacherPortalState extends State<TeacherPortal> {
  final animatedButtonController = AnimatedButtonController();
  final textController = TextEditingController();
  String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFD6EEF8),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_outlined),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: AnimatedTextKit(
                      isRepeatingAnimation: true,
                      animatedTexts: [
                        ColorizeAnimatedText(
                            "Type a paragraph to generate questions!",
                            textStyle: GoogleFonts.poppins(fontSize: 30.0),
                            colors: [
                              Color(0xFF833ab4),
                              Color(0xFFfd1d1d),
                              Color(0xFFfcb045)
                            ])
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: DottedBorder(
                  color: Colors.black,
                  dashPattern: [1, 1],
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none),
                    maxLines: 22,
                  ),
                ),
              ),
              AnimatedButton(
                color: Color(0xFFA751AC),
                text: "Submit",
                controller: animatedButtonController,
                onPressed: () async {
                  FormData formData =
                      FormData.fromMap({'text': textController.text});
                  var result = await Dio().post(
                      'http://e68fe2f9f4b6.ngrok.io/quiz',
                      data: formData);
                  print(result.data);

                  Alert(
                      context: context,
                      title: 'Your summarized text',
                      content: Column(children: [
                        Text(result.data.toString()),
                      ]),
                      buttons: [
                        DialogButton(
                          child: Text('Save as .txt File?'),
                        ),
                        DialogButton(
                          child: Text('Save as .xslx file?'),
                          onPressed: ()async {
                            Map<String,dynamic> map = jsonDecode(result.data);
                            await toExcel(map);
                          },
                        )
                      ]).show();
                  animatedButtonController
                      .completed(); // call when you get the response
                  await Future.delayed(Duration(seconds: 2));
                  animatedButtonController.reset();
                },
              ),
              SizedBox(height: 10),
              Text('OR',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
                  )),
              SizedBox(
                height: 10,
              ),
              Material(
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAlias,
                child: Ink(
                    width: 400,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: gradient_butt),
                    child: InkWell(
                      onTap: () async {
                        String text2 = await selectFile();
                        setState(() {
                          textController.text = text2;
                        });
                      },
                      child: Center(
                        child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  child: DottedBorder(
                                      color: Colors.grey,
                                      dashPattern: [1, 1],
                                      child: Center(child: Icon(Icons.add))),
                                ),
                                SizedBox(width:10),
                                Text(
                                  "Add a file",
                                  style: font_def,
                                ),
                              ],
                            )),
                      ),
                    )),
              ),
            ],
          ),
        ));
  }
}

Future<String> selectFile() async {
  final file = OpenFilePicker()
    ..filterSpecification = {'Text Document (* txt)': '*.txt'}
    ..title = 'Select a file';
  final result = file.getFile();
  if (result != null) {
    print(result.path);
    String text = await result.readAsString();
    print(text);
    return text;
  }
  return null;
}
