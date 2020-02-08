import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../handling_data/Auth.dart';
class Welcome extends StatefulWidget {
  Welcome({Key key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF092D6F),
        body: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height*.15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:30,bottom: 10),
                    child: Text('Welcome to ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 32),),
                  ),
                ],
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:30),
                    child: Text('Maintenance UnderControl ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                  ),
                ],
              ),
              
        SizedBox(
          height: MediaQuery.of(context).size.height*.25,
        ),     
              
         Container(
           child: SvgPicture.asset('assets/aeroLogo.svg',
           width: 100,),
        ),


        SizedBox(
          height: MediaQuery.of(context).size.height*.30,
        ),
        Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:30,bottom: 10),
                    child: Text('Enter as',style: TextStyle(color: Colors.white,fontSize: 14),),
                  ),
                ],
              ),  

        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left:15,right: 10),
                child:  RaisedButton(
                elevation: 0,
                child: Text('User',style: TextStyle(color: Color(0xFF092D6F)),),
                onPressed: (){ 
                  auth.admin = false;
                  Navigator.of(context).pushNamed('/signUp');},
                color: Color(0xFF3DBAF1),
                
              ),
              ),
             
            ),
            
            
             Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left:15,right: 15),
                child:  RaisedButton(
                elevation: 0,
                child: Text('Admin',style: TextStyle(color: Colors.white),),
                onPressed: (){
                  auth.admin = true;
                  Navigator.of(context).pushNamed('/login');
                },
                color: Color(0xFF092D6F),
                shape: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0
                  )
                ),
              ),
              ),
             
            ),
            
          ],
        ),    
              
            
            ],
          ),
        
      ),
    );
  }
}