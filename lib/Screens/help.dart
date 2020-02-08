import 'package:flutter_svg/flutter_svg.dart';

import '../Screens/MyAppBar.dart';
import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      appBar: MyAppBar(context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SvgPicture.asset('assets/help.svg',fit:BoxFit.cover),
      ),
    ),
    );
    
  }
}