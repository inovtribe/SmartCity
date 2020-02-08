import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../handling_data/Auth.dart';
import './MyAppBar.dart';
import 'package:location/location.dart';
import 'package:speech_recognition/speech_recognition.dart';
// import 'package:geolocator/geolocator.dart';

// import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
class Report extends StatefulWidget {
 
  
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> with WidgetsBindingObserver{

  double latitude;
  double longitude;
   Future _getData()async{
    LocationData currentLocation ;

var location = new Location();

// Platform messages may fail, so we use a try/catch PlatformException.
try {
  currentLocation = await location.getLocation();
  print(currentLocation.latitude);
  print(currentLocation.longitude);
  latitude = currentLocation.latitude;
  longitude = currentLocation.longitude;
}  catch (e) {
  if (e.code == 'PERMISSION_DENIED') {
    print("Denied");}
  else
   print("Some other error occured!");
  } 
  currentLocation = null;
}

  var dt = DateTime.now();
  
  final GlobalKey<FormState> key = GlobalKey();
  TextEditingController partController  = TextEditingController();
  TextEditingController addrController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  TextEditingController uidController = TextEditingController();
  bool isreported= false;
  SpeechRecognition _speechRecognition;
  bool _isAvailable= false;
  bool _isListening = false;
  String text='';
  String cameraResult;
  Auth auth ;
  Future _scan()async{
    cameraResult = await  FlutterBarcodeScanner.
    scanBarcode("#414141", 'Cancel', true, ScanMode.QR);
    //  cameraResult =await scanner.scan();
    setState(() {
      cameraResult = cameraResult;
    });}

    void _voiceRecognition(){
      _speechRecognition = SpeechRecognition();
      _speechRecognition.setAvailabilityHandler((bool handler){
       setState(() {
         _isAvailable = handler;
       });
      });
      _speechRecognition.setRecognitionStartedHandler((){
        setState(() {
          _isListening = true;
        });
      });

      _speechRecognition.setRecognitionResultHandler((String speech){
        setState(() {
        text= speech;
      });
      });
      _speechRecognition.setRecognitionCompleteHandler((){
        setState(() {
          _isListening = false;
        });
      });

      _speechRecognition.activate().then((result){
        setState(() {
          _isAvailable = true;
        });
      });
    }
    @override
    void initState() { 
      super.initState();
      _scan();
      _getData();
      _voiceRecognition();
      WidgetsBinding.instance.addObserver(this);
    }
    
    void dispose() { 
      print('dispose');
      
      super.dispose();
    }
 
  Widget build(BuildContext context) {
   print("Date Time $dt");
 auth = Provider.of<Auth>(context);
  final userUid = auth.userUid;
  final _token =auth.token;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Quicksand'),
      home: Scaffold(
        appBar: MyAppBar(context),
        backgroundColor: Colors.white,
        body:SingleChildScrollView(
          child: Container(
         width: double.infinity,
         height: MediaQuery.of(context).size.height-70,
         //apply dynamic height using app bar height and all
          child:
            Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               
                    Padding(
                  padding: const EdgeInsets.only(left: 30,bottom: 18,top: 25),
                  child:cameraResult == null?Center(child: CircularProgressIndicator(),)
                   :Text('UID of Equipment: ${cameraResult} ',style: TextStyle(color: Color(0xFF092D6F),fontWeight: FontWeight.bold,fontSize: 16),),
                )
         
                  
                       
              ],
            ),
         
            Form(
            key: key,
                       
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
              

                     Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 30,bottom: 10),
                  child: Text('Relative address',style: TextStyle(color: Color(0xFF474747),fontWeight: FontWeight.bold),),
                )
                
              ],
            ),
                   
                    Padding(
                     padding: const EdgeInsets.only(left: 30,right: 30,bottom: 20),
                      child:  TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: addrController,
                        style: TextStyle(fontFamily: 'Quicksand',fontSize: 14,color:  Color(0xFF474747)),
                        
                        validator: (val){
                          if (val.isEmpty )
                           {
                             return 'Invalid address';
                           
                           }
                        },
                      decoration: InputDecoration(
                         filled: true,
                        fillColor: Color.fromRGBO(240, 240, 240, 100),
                        
               
                hintStyle: TextStyle(color: Colors.white,fontFamily: 'Quicksand',),
              
                        labelStyle: TextStyle(fontFamily: 'Quicksand',fontSize: 14,color:  Color(0xFFBBBBBB),fontWeight: FontWeight.bold),
                        labelText: 'eg. Aeroplane no.',
                        // helperText: 'abc0000@gmail.com',
                        // helperStyle: TextStyle(fontFamily: 'Quciksand',color: Colors.yellow),
                      ),
                    ),
                    ),
                   

                  
                 
                    
                    
                  ],
                ),
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.only(left: 30,right: 30,bottom: 20),
                           child: Text('Name of the part' ,style:TextStyle( color:Color(0xFF474747),fontWeight: FontWeight.bold),),
                         ),
                            
                       ],
                     ),
                     
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30,bottom: 20),
                      
                      child:  Container(
                        width: double.infinity - 30,
                       
                        // child:Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: <Widget>[
                        //     Padding(padding: EdgeInsets.only(left: 10),
                        //     child: Text('Runway 1') ,),
                           
                            
                        //     Icon(Icons.arrow_drop_down)
                        //   ],
                        // ),
                  child:      TextField(
                        controller: uidController,
            decoration: InputDecoration(
              fillColor: Color.fromRGBO(240, 240, 240, 100),
              filled: true
            ),
            // style: TextStyle(color:Color.fromRGBO(240, 240, 240, 100),),
            keyboardType: TextInputType.text,
            maxLines: 10,
          ),
                        height: 56,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(240, 240, 240, 100),
                        ),
                ),
                    ),
                    Stack(
                      children: <Widget>[
                        Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30,bottom: 20),
                      child:  TextField(
                        autocorrect: true,
                        controller: problemController,
                      decoration: InputDecoration(
                      fillColor: Color.fromRGBO(240, 240, 240, 100),
                      filled: true,
                      hintText: 'State Your Problem Here ....'
                     ),
            // style: TextStyle(color:Color.fromRGBO(240, 240, 240, 100),),
                     keyboardType: TextInputType.text,
                     maxLines: 10,
                     
                    ),
                    ),

                    Positioned(
                      right: 0,
                      child: FlatButton(
                        child: Image.asset('assets/speaker.png'),
                        onPressed: (){
                          print('pressed');
                          
                        },
                      )
                    )
                      ],
                    ),
         
              ButtonTheme(
             minWidth: double.infinity,
             height: 45,
             child:Padding(
               padding: const EdgeInsets.only(left:30,right: 30),
               child: RaisedButton(
                 elevation: 4.0,
               onPressed: (){
                 _submit(uidController.text,addrController.text,cameraResult,problemController.text,userUid,_token);
            
               },
               color: Color(0xFF3DBAF1),
               child:  isreported?Center(child: CircularProgressIndicator(),):
               Text('Report',style: TextStyle(color: Color(0xFF092D6F),fontSize: 18),),
             ),
             ),
              
           )
          
                
                        
              
          ],
        )
        
          
        ),
        
        )
         
              
             
          
      
    ));
   
  }
   Future _submit(String part,String addr , String uid ,String problem,String userUid,String token)async{
    setState(() {
      isreported = true;
    });
    final bool d = await http.get(
    Uri.parse('https://sih2020jss.herokuapp.com/report/$uid'),
     headers: {
       "Accept":"application/json",
       "Content-Type": "application/json",
       "Authorization": "Bearer $token",
     }).then((onValue){
       print('val is ${json.decode(onValue.body)}');
       if (json.decode(onValue.body)['message']=='failure')
       {
         return true;
       }
       else 
       {
         return false;
       }
     }).catchError((onError){
       print('Eoor${onError}');
      
     });
     if(d)
      {
        print('try creating');
        http.post(
    Uri.parse('https://sih2020jss.herokuapp.com/report'),
        body:json.encode({
          'uid':uid,
          'name':part,
          'address':addr,
          'problem':problem,
          'latitude':latitude,
          'longitude':longitude,
          'Authorization': 'Bearer $token',
          // 'person':userUid
      }),
     headers: {
       "Accept":"application/json",
       "Content-Type": "application/json",
       "Authorization": "Bearer $token",
     }).then((onValue){
       print('Post is ${json.decode(onValue.body)}');
       return true;
     }).catchError((onError){
       print('Eoor${onError}');
       return false;
     });
     setState(() {
       isreported = false;
       auth.myListeners();
       Navigator.of(context).popAndPushNamed('/homeScreen');
     });
      }

      else {
        http.put(
    Uri.parse('https://sih2020jss.herokuapp.com/report'),
        body:json.encode({
          'uid':uid,
          'name':part,
          'address':addr,
          'problem':problem,
          'latitude':latitude,
          'longitude':longitude,
          'Authorization': 'Bearer $token',
          // 'person':userUid
      }),
     headers: {
       "Accept":"application/json",
       "Content-Type": "application/json",
       "Authorization": "Bearer $token",
     }).then((onValue){
       print('Put is ${json.decode(onValue.body)}');
       return true;
     }).catchError((onError){
       print('Eoor${onError}');
       return false;
     });
     setState(() {
       isreported = false;
       auth.myListeners();
        Navigator.of(context).popAndPushNamed('/homeScreen');
     });
      }
   }
}