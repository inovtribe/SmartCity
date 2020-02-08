import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Auth with ChangeNotifier{
String name;
String uid;
String emailId;
String password;
String _token;
bool admin;
// Auth(this.name,this.uid,this.emailId,this.password);
Map<String,dynamic> userData;
String get userUid{
  if (uid!=null)
   {
     return uid;
   }
}
String get token{
  if(_token!=null)
   {
     return _token;
   }
}
Map<String,dynamic> get getUserData{
  if (userData != null)
   {
     return userData;
   }
}
Future<bool> signUp(String name,String emaildId,String uiid,String password)async{
  uid = uiid;
  print('Name is $name');
  final bool res  = await http.post(
    
    Uri.parse('https://sih2020jss.herokuapp.com/signup'),
        body:json.encode({
           'name':name,
           'email':emaildId,
           'uid':uiid,
          'password':password
      }),
     headers: {
       "Accept":"application/json",
       "Content-Type": "application/json"
     }).then((onValue){
       print('val is ${json.decode(onValue.body)}');
       return true;
     }).catchError((onError){
       print('Eoor${onError}');
       return false;
     });
     if(res)return true;
     else return false;
}
Future<bool> login(String uiid,String password)async{
  uid =uiid;
  final bool res  = await http.post(
    Uri.parse('https://sih2020jss.herokuapp.com/login'),
        body:json.encode({
           'uid':uiid,
          'password':password
      }),
     headers: {
       
       "Accept":"application/json",
       "Content-Type": "application/json"
     }).then((onValue){
       print('val is ${json.decode(onValue.body)}');


       // checking is login actually succeded
       
        userData = json.decode(onValue.body);

        if (userData['message'] == 'Password Incorrect')
         {
           notifyListeners();
           print('Detected');
           return false;
         }
       _token = json.decode(onValue.body)['token'];
       print('Ttoken is $_token');
       notifyListeners();
       return true;
     }).catchError((onError){
       print('Eoor${onError}');
       return false;
     });
     if(res)return true;
     else return false;
}
void myListeners(){
  notifyListeners();
}
}