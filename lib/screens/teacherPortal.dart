import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import "package:http/http.dart" as http;

class TeacherPortal extends StatefulWidget {
  @override
  _TeacherPortalState createState() => _TeacherPortalState();
}

class _TeacherPortalState extends State<TeacherPortal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(" ")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              child: Center(
                child: Lottie.asset('assets/welcome.json'),
              ),
            ),
            TextButton(
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
                  request.files.add(
                      await http.MultipartFile.fromPath('file', result.path));

                  // http.StreamedResponse response = await request.send();

                  // if (response.statusCode == 200) {
                  //   print(await response.stream.bytesToString());
                  // } else {
                  //  print(response.reasonPhrase);
                  // }

                  return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: FutureBuilder<http.StreamedResponse>(
                              future: request.send(),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return Center(
                                      child:
                                          Lottie.asset("assets/loading.json"),
                                    );
                                  case ConnectionState.done:
                                    return FutureBuilder(
                                        future: snapshot.data.stream
                                            .bytesToString(),
                                        builder: (context, snap) {
                                          switch (snap.connectionState) {
                                            case ConnectionState.waiting:
                                              return Center(
                                                child: Lottie.asset(
                                                    "assets/loading.json"),
                                              );
                                            case ConnectionState.done:
                                              return Center(
                                                  child: Text(
                                                      snap.data.toString()));
                                            default:
                                              return Center(
                                                  child: Text("error 2"));
                                          }
                                        });
                                  default:
                                    return Center(child: Text("error 1"));
                                }
                              },
                            ),
                          ));
                }
              },
              child: Text("Open File"),
            ),
          ],
        ));
  }
}
