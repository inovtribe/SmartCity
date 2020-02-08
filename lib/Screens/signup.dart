import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'home_screen.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import '../handling_data/Auth.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  
  
  Future _getData()async{
    LocationData currentLocation ;

var location = new Location();

// Platform messages may fail, so we use a try/catch PlatformException.
try {
  currentLocation = await location.getLocation();
  print(currentLocation.latitude);
  print(currentLocation.longitude);
}  catch (e) {
  if (e.code == 'PERMISSION_DENIED') {
    print("Denied");}
  else
   print("Some other error occured!");
  } 
  currentLocation = null;
}
  
  @override
  void initState() { 
    super.initState();
    _getData();
  }
  final GlobalKey<FormState> key = GlobalKey();
  TextEditingController emailController  = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController uidController = TextEditingController();
  bool isSubmitting = false;
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return Scaffold(
      backgroundColor:Color(0xFF092D6F),
       body:ListView(
         children: <Widget>[
            Column(
         mainAxisAlignment: MainAxisAlignment.center,
        //  crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           SizedBox(height: 50,),
           Center(
             child:Container(
                    child: SvgPicture.asset('assets/aeroLogo.svg',
                    width: 70,),
                  ),
            //  Container(
            //    width: 82,
            //    height: 44,
            //    decoration: BoxDecoration(
            //      color: Color(0xFF092D6F),
            //      image:DecorationImage(
            //        image:SvgPicture.asset('assets/logo.svg',
            //         width: 30,),
            //        fit: BoxFit.cover
            //      )
            //    ),
            //  )
           ),
           SizedBox(
             height: 9,
           ),
            Text('Maintenance UnderControl',style: TextStyle(fontSize: 20,color: Colors.white),),

            SizedBox(height: 100,),
            


            Form(
            key: key,
                       
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30,bottom: 20),
                      child:  TextFormField(
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        style: TextStyle(fontFamily: 'Quicksand',fontSize: 14,color: Colors.white),
                        
                        validator: (val){
                          if (val.isEmpty )
                           {
                             return 'Please enter the name';
                           
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
                      borderSide: BorderSide(color:Color(0xFF20417D)),
               ),
                        labelStyle: TextStyle(fontFamily: 'Quicksand',fontSize: 15,color: Color(0xFF8FA0BE),),
                        labelText: 'Name',
                        // helperText: 'abc0000@gmail.com',
                        helperStyle: TextStyle(fontFamily: 'Quciksand',color: Colors.yellow),
                      ),
                    ),
                    ),
                   
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30,bottom: 20),
                      child:  TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        style: TextStyle(fontFamily: 'Quicksand',fontSize: 14,color: Colors.white),
                        
                        validator: (val){
                          if (val.isEmpty ||!val.contains('@gmail.com'))
                           {
                             return 'Invalid Email';
                           
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
                        labelStyle: TextStyle(fontFamily: 'Quicksand',fontSize: 15,color: Color(0xFF8FA0BE)),
                        labelText: 'Email Id',
                        // helperText: 'abc0000@gmail.com',
                        // helperStyle: TextStyle(fontFamily: 'Quciksand',color: Colors.yellow),
                      ),
                    ),
                    ),
                   

                   Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30,bottom: 20),
                      child:  TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: uidController,
                        style: TextStyle(fontFamily: 'Quicksand',fontSize: 14,color: Colors.white),
                        
                        validator: (val){
                          if (val.isEmpty  )
                           {
                             return 'Invalid uid';
                           
                           }
                        },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF20417D),
                        enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                   borderSide: BorderSide(color:  Color(0xFF20417D)),
                   ), 
               
                hintStyle: TextStyle(color: Colors.white,fontFamily: 'Quicksand'),
               focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.all(Radius.circular(2.0)),
               borderSide: BorderSide(color: Color(0xFF20417D)),
        ),
                        labelStyle: TextStyle(fontFamily: 'Quicksand',fontSize: 15,color: Color(0xFF8FA0BE),),
                        labelText: 'Unique Id number',
                        // hintText: 'abc@123',
                        // helperStyle: TextStyle(fontFamily: 'Quciksand',color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                    ),
                    ),
                 
                    
                     Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30,bottom: 20),
                      child:  TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        controller: passController,
                        style: TextStyle(fontFamily: 'Quicksand',fontSize: 14,color: Colors.white),
                        
                        validator: (val){
                          if (val.isEmpty && val.length < 6 )
                           {
                             return 'Invalid Password';
                           
                           }
                        },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF20417D),
                        enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                   borderSide: BorderSide(color:  Color(0xFF20417D)),
                   ), 
               
                hintStyle: TextStyle(color: Colors.white,fontFamily: 'Quicksand'),
               focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.all(Radius.circular(2.0)),
               borderSide: BorderSide(color: Color(0xFF20417D)),
        ),
                        labelStyle: TextStyle(fontFamily: 'Quicksand',fontSize: 15,color: Color(0xFF8FA0BE),),
                        labelText: 'Password',
                        // hintText: 'abc@123',
                        // helperStyle: TextStyle(fontFamily: 'Quciksand',color: Colors.yellow),
                      ),
                    ),
                    ),
                    
                   isSubmitting?CircularProgressIndicator():
                 Row(
                   children: <Widget>[
                     Expanded(
                       child: Padding(
                         padding: const EdgeInsets.all(30),
                         child: RaisedButton(
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.all(Radius.circular(2))
                           ),
                           onPressed: (){
                             _submit(context,emailController,passController,uidController,nameController,auth);
                           },
                           color: Color(0xFF3DBAF1),
                         child: Padding(
                           padding: const EdgeInsets.all(10),
                           child:  Text('SignUp',style: TextStyle(color: Color(0xFF092D6F),fontSize: 18),),
                         )
                        
                       ),
                       )
                       
                     )
                   ],
                 )
                    
                    
                  ],
                ),
                   ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed('/login');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                              ),
                              Text('Already Have an account?',style: TextStyle(color:Color(0xFF3DBAF1),fontSize: 14),),
                              Text('Login',style: TextStyle(color: Colors.white,fontSize: 14),)
                            ],
                          )
                        ),
                      )
                    ],
                  ) 
         ],
       ),
         ],
        
       ),
        
      );
    
  }
  void _submit(BuildContext context,TextEditingController email,TextEditingController pass,TextEditingController uid,TextEditingController name,Auth auth)async{
    key.currentState.save();
    
    
    if (key.currentState.validate()){
      setState(() {
      isSubmitting = true;
    });
      print("success");
      print('Name as ${name.text}');
    final dd = await  auth.signUp(name.text,email.text,uid.text,pass.text);
     setState(() {
       isSubmitting = false;
     });
     if(dd == true)
      Navigator.of(context).pushNamed('/login');
      else print('Unable to Signup');
    }
  }
}