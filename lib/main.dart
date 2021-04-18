import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:cathacks/screens/studentPortal.dart';
import 'package:cathacks/screens/teacherPortal.dart';
// import 'package:cathacks/screens/startupPage.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
//   doWhenWindowReady(() {
//     final win = appWindow;
//     win.alignment = Alignment.center;
//     win.title = "";
//     win.show();
//   });
// }

// class MyApp extends StatefulWidget {
//   // This widget is the root of your application.
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: StartUpPage(),
//     );
//   }
// }

import 'dart:math' as math show pi;

import 'package:flutter/material.dart';

import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    win.alignment = Alignment.center;
    win.title = "Edu Buddy";
    win.show();
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SidebarPage(),
      ),
    );
  }
}

class SidebarPage extends StatefulWidget {
  @override
  _SidebarPageState createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  List<CollapsibleItem> _items;
  String _headline = "Home";
  NetworkImage _avatarImg =
      NetworkImage('https://www.w3schools.com/howto/img_avatar.png');

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        isSelected: true,
        text: 'Home',
        icon: Icons.home,
        onPressed: () => setState(() => _headline = 'Home'),
      ),
      // CollapsibleItem(
      //   text: 'Dashboard',
      //   icon: Icons.assessment,
      //   onPressed: () => setState(() => _headline = 'DashBoard'),
      //   isSelected: true,
      // ),
      CollapsibleItem(
        text: 'Student',
        icon: Icons.face,
        onPressed: () => setState(() => _headline = 'Student'),
      ),
      CollapsibleItem(
        text: 'Teacher',
        icon: Icons.person,
        onPressed: () => setState(() => _headline = 'Teacher'),
      ),
    ];
  }

  Map<String, Widget> foo = {
    "Home": Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          child: Center(
              child: Text("Welcome to Edu Buddy, your classroom in a nutshell!",
                  style: GoogleFonts.italiana(
                      fontSize: 40, fontWeight: FontWeight.bold))),
        ),
        Expanded(child: Lottie.asset("assets/loading2.json")),
      ],
    )),
    "Student": StudentScreen(),
    "Teacher": TeacherPortal()
  };

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: CollapsibleSidebar(
        items: _items,
        avatarImg: NetworkImage(
            "https://cdn.dribbble.com/users/1338391/screenshots/15386836/media/dea169824f0cce3899c068c35b82205b.jpg"),
        title: 'John Smith',
        body: _body(size, context),
        backgroundColor: Colors.black,
        selectedTextColor: Colors.limeAccent,
        textStyle: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
        titleStyle: TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        toggleTitleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _body(Size size, BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xFFFC9D6FF), Color(0xFFFE2E2E2)]),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
      child: foo[_headline],
    );
  }
}
