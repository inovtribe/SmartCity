// import 'package:airport_app/Screens/TabsScreen.dart';
import './Screens/report_prev.dart';

import './Screens/scanner.dart';
// import './Screens/TabsScreen.dart';
import './Screens/home_screen.dart';
import './Screens/resolved.dart';
import './Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './handling_data/Auth.dart';
import './Screens/signup.dart';
import './Screens/report.dart';
import './Screens/problems.dart';
import './Screens/help.dart';
import './Screens/welcom.dart';
// void main() => runApp(SignUp());
// void main() => runApp(Login());
// void main() => runApp(MyApp());
 void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value:Auth() ,
        )
      ],
      child:
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'Quicksand'
      ),
    debugShowCheckedModeBanner: false,
         routes: {
        '/login':(ctx)=>Login(),
        '/homeScreen':(ctx)=>HomeScreen(),
        '/scanner':(ctx)=>Scanner(),
        '/report':(ctx)=>Report(),
        // '/resolved':(ctx)=>Resolved(),
        '/problems':(ctx)=>Problems(),
        '/help':(ctx)=>Help(),
        '/report_prev':(ctx)=>Report_prev(),
        '/signUp':(ctx)=>SignUp()
      },
      home:Welcome()
    ),);
  }
}