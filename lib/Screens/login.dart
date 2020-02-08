import 'package:flutter/material.dart';
import '../handling_data/Auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './AdminScreen.dart';
class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
 final GlobalKey<FormState> key = GlobalKey();
  TextEditingController uidController  = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isSubmitting = false;
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins'
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF092D6F),
        body:ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Center(
             child:

             Container(
                    child: SvgPicture.asset('assets/aeroLogo.svg',
                    width: 70,),
                  ),
            //  Container(
            //    width: 82,
            //    height: 44,
            //    decoration: BoxDecoration(
            //      color: Color(0xFF092D6F),
            //      image:DecorationImage(
            //        image: AssetImage('assets/logo.png'),
            //        fit: BoxFit.cover
            //      )
            //    ),
            //  )
           ),
              Padding(
                padding: const EdgeInsets.all(10,),
                child: Text('Maintenance UnderControl',style: TextStyle(color: Colors.white),),
              ),
              SizedBox(
                height: 100,
              ),
              Form(
            key: key,
                       
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Padding(
                     padding: const EdgeInsets.only(left: 30,right: 30,bottom: 15),
                      child:  TextFormField(
                        keyboardType: TextInputType.text,
                        controller: uidController,
                        style: TextStyle(fontFamily: 'Quicksand',fontSize: 14,color: Colors.white),
                        
                        validator: (val){
                          if (val.isEmpty )
                           {
                             return 'Invalid uid';
                           
                           }
                        },
                      decoration: InputDecoration(
                         filled: true,
                        fillColor: Color(0xFF20417D),
                      enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      borderSide: BorderSide(color: Color(0xFF20417D)),
                      ), 
               
                     hintStyle: TextStyle(color: Colors.white,fontFamily: 'Quicksand',fontWeight: FontWeight.bold),
                      focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      borderSide: BorderSide(color: Color(0xFF20417D)),
               ),
                        labelStyle: TextStyle(fontFamily: 'Quicksand',fontSize: 14,color: Color(0xFF8FA0BE)),
                        labelText: '  Unique Id number',
                        // helperText: 'abc0000@gmail.com',
                        helperStyle: TextStyle(fontFamily: 'Quciksand',color: Colors.yellow),
                      ),
                    ),
                    ),
                   
                    Padding(
                     padding: const EdgeInsets.only(left: 30,right: 30,bottom: 20),
                      child:  TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: passController,
                        style: TextStyle(fontFamily: 'Quicksand',fontSize: 14,color:Colors.white),
                        obscureText: true,
                        validator: (val){
                          if (val.isEmpty )
                           {
                             return 'Invalid password';
                           
                           }
                        },
                      decoration: InputDecoration(
                         filled: true,
                        fillColor: Color(0xFF20417D),
                        enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                   borderSide: BorderSide(color: Color(0xFF20417D)),
                   ), 
               
                hintStyle: TextStyle(color: Colors.white,fontFamily: 'Quicksand'),
               focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.all(Radius.circular(2.0)),
               borderSide: BorderSide(color: Color(0xFF20417D)),
        ),
                        labelStyle: TextStyle(fontFamily: 'Quicksand',fontSize: 14,color: Color(0xFF8FA0BE)),
                        labelText: '  Password',
                        // helperText: '  Password',
                        // helperStyle: TextStyle(fontFamily: 'Quciksand',fontSize: 14,color: Color(0xFF8FA0BE)),
                      ),
                    ),
                    ),
                   

                  isSubmitting?CircularProgressIndicator():
                  ButtonTheme(
                    minWidth: double.infinity,
                    height: 50,

                    child:   Row(
                   children: <Widget>[
                     Expanded(
                       child: Padding(
                         padding: const EdgeInsets.all(30),
                         child: RaisedButton(
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.all(Radius.circular(2))
                           ),
                           onPressed:(){
                             _submit(context,uidController,passController,auth);
                           } ,
                           color: Color(0xFF3DBAF1),
                         child: Text('Login',style: TextStyle(color: Color(0xFF092D6F),fontSize: 14,fontWeight: FontWeight.w600),),
                       ),
                       )
                       
                     )
                   ],
                 )
                  ),
               
                    
                    
                  ],
                ),
                     ),
              ],  
            )
          ],
        )
      ),
    );
  }
  void _submit(BuildContext context,TextEditingController uid, TextEditingController pass , Auth auth)async{
    key.currentState.save();
    
    if(key.currentState.validate()){
      setState(() {
      isSubmitting=true;
    });
      print("success login");
      final d = await auth.login(uid.text,pass.text);
      setState(() {
        isSubmitting=false;
      });
      if(d)
      Navigator.of(context).pushNamed('/homeScreen');
      else{
        print('login failed');
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx)=> AlertDialog(
          title: Text('Login Failed ',style: TextStyle(color:Color(0xFF092D6F))),
          content: Text('Wrong Uid or Password ',style: TextStyle(color:Color(0xFF092D6F)),),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: (){Navigator.of(context).pop();},
            )
          ],
        )
        );
       
      }
      
    }
  }
}