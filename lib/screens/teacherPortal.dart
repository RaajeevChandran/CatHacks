import 'dart:convert';

import 'package:animated_progress_button/animated_progress_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cathacks/constants.dart';
import 'package:cathacks/models/quiz.dart';
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
import 'package:rounded_loading_button/rounded_loading_button.dart';

class TeacherPortal extends StatefulWidget {
  @override
  _TeacherPortalState createState() => _TeacherPortalState();
}

class _TeacherPortalState extends State<TeacherPortal> {
  final animatedButtonController = AnimatedButtonController();
  final textController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  String text;
  // backgroundColor: Color(0xFFD6EEF8),

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: AnimatedTextKit(
              isRepeatingAnimation: true,
              animatedTexts: [
                ColorizeAnimatedText("Type a paragraph to generate questions!",
                    textStyle: GoogleFonts.poppins(fontSize: 30.0),
                    colors: [
                      Color(0xFF833ab4),
                      Color(0xFFfd1d1d),
                      Color(0xFFfcb045)
                    ])
              ],
            ),
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
          RoundedLoadingButton(
              color: Color(0xFFA751AC),
              controller: _btnController,
              onPressed: () async {
                // FormData formData =
                //     FormData.fromMap({'text': textController.text});
                // var result = await Dio()
                //     .post('http://localhost:5000/quiz', data: formData);
                List<Quiz> quiz = [];
                List<dynamic> foo = [
                  {
                    "answer": "Python",
                    "question":
                        "What is a general-purpose interpreted, interactive, object-oriented, and high-level programming language?"
                  },
                  {
                    "answer": "Guido van Rossum",
                    "question": "Who created Python?"
                  },
                  {
                    "answer": "GNU General Public License",
                    "question": "What is the GPL?"
                  },
                  {
                    "answer": "Python",
                    "question": "What is Python's programming language?"
                  },
                  {
                    "answer": "Monty Python's Flying Circus",
                    "question":
                        "What was the name of the BBC comedy series that was written by Guido van Rossum?"
                  },
                  {
                    "answer": "creative and well random",
                    "question":
                        "What did Guido van Rossum read the script of the BBC comedy series \"Monty Python's Flying Circus\"?"
                  },
                  {
                    "answer": "everything",
                    "question":
                        "What does the comedy series \"Monty Python's Flying Circus\" talk about?"
                  },
                  {
                    "answer": "slow and unpredictable",
                    "question":
                        "What is the result of the comedy series \"Monty Python's Flying Circus\"?"
                  }
                ];
                foo.forEach((foo) {
                  quiz.add(Quiz.fromMap(foo));
                });
                print(quiz);
                await Future.delayed(Duration(seconds: 7));
                Alert(
                    title: " ",
                    context: context,
                    content: Container(
                      width: MediaQuery.of(context).size.width * .5,
                      child: Column(
                          children: [
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: AnimatedTextKit(
                                    isRepeatingAnimation: true,
                                    animatedTexts: [
                                      ColorizeAnimatedText(
                                          "The Auto-Generated Quiz",
                                          textStyle: GoogleFonts.poppins(
                                              fontSize: 30.0),
                                          colors: [
                                            Color(0xFF833ab4),
                                            Color(0xFFfd1d1d),
                                            Color(0xFFfcb045)
                                          ])
                                    ],
                                  ),
                                ),
                              ] +
                              List.generate(quiz.length, (int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    elevation: 3,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .5,
                                        height: 120,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "Q : " + quiz[index].question,
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text("A : " + quiz[index].answer,
                                                  style: TextStyle(
                                                      fontSize: 21,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.grey))
                                            ])),
                                  ),
                                );
                              })),
                    ),
                    buttons: [
                      DialogButton(
                        onPressed: () {},
                        child: Text('Save as .txt File?'),
                      ),
                      DialogButton(
                          onPressed: () {
                            toExcel(quiz);
                          },
                          child: Text('Save as Excel file'))
                    ]).show();
                // call when you get the response
                _btnController.reset();
              },
              child: Text("Submit")),
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
                            SizedBox(width: 10),
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
    );
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
