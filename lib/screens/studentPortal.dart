import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import "package:http/http.dart" as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../constants.dart';

class StudentScreen extends StatefulWidget {
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  bool fetched = false;
  String summary = " ";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * .4,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 400,
                              child: Lottie.asset("assets/welcome.json")),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Text(
                                "Summarise your long boring lectures into a Paraphrased comprehension at the press of a button!",
                                style: GoogleFonts.electrolize(fontSize: 24)),
                          ),
                        )
                      ],
                    )),
              ],
            )),
        Expanded(
          child: Container(

              // decoration: BoxDecoration(
              //     color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Select an Audio File to summarize the lecture",
                  style: GoogleFonts.electrolize(fontSize: 24)),
              SizedBox(height: 100),
              RoundedLoadingButton(
                  controller: _btnController,
                  onPressed: () async {
                    final file = OpenFilePicker()
                      ..filterSpecification = {
                        'Audio Files (*.wav)': '*.wav',
                        'All Files': '*.*'
                      }
                      ..defaultFilterIndex = 0
                      ..defaultExtension = 'wav'
                      ..title = 'Select an audio file';

                    final result = file.getFile();

                    if (result != null) {
                      var request = http.MultipartRequest(
                          'POST', Uri.parse('http://localhost:5000/upload'));
                      request.files.add(await http.MultipartFile.fromPath(
                          'file', result.path));

                      http.StreamedResponse response = await request.send();
                      // FormData formData = FormData.fromMap(
                      //     {'file': await MultipartFile.fromFile(result.path)});
                      // var response = await Dio()
                      //     .post("http://3403672a4d7b.ngrok.io/upload", data: formData);

                      // if (response.data != null) {
                      //   _btnController.success();
                      //   setState(() {
                      //     summary = response.data["summary"];
                      //     fetched = false;
                      //   });
                      // } else {
                      //   _btnController.error();
                      //   print(response.statusCode.toString());
                      // }

                      if (response.statusCode == 200) {
                        _btnController.success();

                        Map<String, dynamic> foo =
                            jsonDecode(await response.stream.bytesToString());
                        setState(() {
                          summary = foo["summary"].toString().substring(
                              1, foo["summary"].toString().length - 1);
                          print(foo["summary"].toString());
                          fetched = true;
                        });

                        _btnController.reset();
                      } else {
                        _btnController.error();
                        print(response.reasonPhrase);
                      }
                      // return showDialog(
                      //     context: context,
                      //     builder: (context) => AlertDialog(
                      //           content: FutureBuilder<http.StreamedResponse>(
                      //             future: request.send(),
                      //             builder: (context, snapshot) {
                      //               switch (snapshot.connectionState) {
                      //                 case ConnectionState.waiting:
                      //                   return Center(
                      //                     child: Lottie.asset(
                      //                         "assets/student.json"),
                      //                   );
                      //                 case ConnectionState.done:
                      //                   return FutureBuilder(
                      //                       future: snapshot.data.stream
                      //                           .bytesToString(),
                      //                       builder: (context, snap) {
                      //                         switch (snap.connectionState) {
                      //                           case ConnectionState.waiting:
                      //                             return Center(
                      //                               child: Lottie.asset(
                      //                                   "assets/student.json"),
                      //                             );
                      //                           case ConnectionState.done:
                      //                             _btnController.success();
                      //                             print(snap.data.toString());
                      //                             return Container();
                      //                             break;
                      //                           default:
                      //                             return Center(
                      //                                 child: Text("error 2"));
                      //                         }
                      //                       });
                      //                 default:
                      //                   return Center(child: Text("error 1"));
                      //               }
                      //             },
                      //           ),
                      //         ));
                    }
                  },
                  child: Ink(
                      width: 400,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: gradient_butt),
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
                                      borderType: BorderType.Circle,
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
                      ))),
              SizedBox(height: 100),
              Visibility(
                visible: fetched,
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 3,
                  child: Container(
                    width: 500,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Summary", style: TextStyle(fontSize: 25)),
                          SelectableText(summary, style: TextStyle()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Material(
              //   borderRadius: BorderRadius.circular(20),
              //   clipBehavior: Clip.antiAlias,
              //   child: Ink(
              //       width: 400,
              //       height: 60,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           gradient: gradient_butt),
              //       child: InkWell(
              //         onTap: () async {
              //           final file = OpenFilePicker()
              //             ..filterSpecification = {
              //               'Audio Files (*.wav)': '*.wav',
              //               'All Files': '*.*'
              //             }
              //             ..defaultFilterIndex = 0
              //             ..defaultExtension = 'wav'
              //             ..title = 'Select an audio file';

              //           final result = file.getFile();

              //           if (result != null) {
              //             var request = http.MultipartRequest(
              //                 'POST',
              //                 Uri.parse(
              //                     'http://f0c4614f6184.ngrok.io/upload'));
              //             request.files.add(await http.MultipartFile.fromPath(
              //                 'file', result.path));

              //             // http.StreamedResponse response = await request.send();

              //             // if (response.statusCode == 200) {
              //             //   print(await response.stream.bytesToString());
              //             // } else {
              //             //  print(response.reasonPhrase);
              //             // }
              //             return showDialog(
              //                 context: context,
              //                 builder: (context) => AlertDialog(
              //                       content:
              //                           FutureBuilder<http.StreamedResponse>(
              //                         future: request.send(),
              //                         builder: (context, snapshot) {
              //                           switch (snapshot.connectionState) {
              //                             case ConnectionState.waiting:
              //                               return Center(
              //                                 child: Lottie.asset(
              //                                     "assets/student.json"),
              //                               );
              //                             case ConnectionState.done:
              //                               return FutureBuilder(
              //                                   future: snapshot.data.stream
              //                                       .bytesToString(),
              //                                   builder: (context, snap) {
              //                                     switch (
              //                                         snap.connectionState) {
              //                                       case ConnectionState
              //                                           .waiting:
              //                                         return Center(
              //                                           child: Lottie.asset(
              //                                               "assets/loading.json"),
              //                                         );
              //                                       case ConnectionState.done:
              //                                         return Center(
              //                                             child: Text(snap
              //                                                 .data
              //                                                 .toString()));
              //                                       default:
              //                                         return Center(
              //                                             child: Text(
              //                                                 "error 2"));
              //                                     }
              //                                   });
              //                             default:
              //                               return Center(
              //                                   child: Text("error 1"));
              //                           }
              //                         },
              //                       ),
              //                     ));
              //           }
              //         },
              //         child: Center(
              //           child: Padding(
              //               padding: EdgeInsets.all(8),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Container(
              //                     height: 30,
              //                     width: 30,
              //                     child: DottedBorder(
              //                         borderType: BorderType.Circle,
              //                         color: Colors.grey,
              //                         dashPattern: [1, 1],
              //                         child: Center(child: Icon(Icons.add))),
              //                   ),
              //                   SizedBox(width: 10),
              //                   Text(
              //                     "Add a file",
              //                     style: font_def,
              //                   ),
              //                 ],
              //               )),
              //         ),
              //       )),
              // ),
            ]),
          )),
        ),
      ],
    );
  }
}
