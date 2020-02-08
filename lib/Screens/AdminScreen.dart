import '../Screens/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../handling_data/Auth.dart';
import 'dart:convert';
class AdminScreen extends StatefulWidget {
  AdminScreen({Key key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  
  Future _adminList(String authToken)async{
    http.Response response = await http.get(
     Uri.parse('http://sih2020jss.herokuapp.com/admin',
     
     ),headers: {
       "Accept":"application/json",
       "Content-Type": "application/json",
       "Authorization": "Bearer $authToken",
     });
     print(json.decode(response.body));
  }
  void initState() { 
    super.initState();
    
  }

  bool once = true;
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final authToken = auth.token;
    if (once&&authToken!=null)
    {
      once=false;
      _adminList(authToken);
    }
    return Text('Admin Pannel');
      
    
      
    
  }
}