import 'package:flutter/material.dart';
// import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../handling_data/Auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Scanner extends StatefulWidget {
  Scanner({Key key}) : super(key: key);

  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  String cameraScanResult;
  bool isLoading = true;
  bool once = true;
  bool scanCompleted = false;
  Map<String,dynamic> equipDetails;

  Future _getEquipData(String token)async{
  final http.Response response = await http.get(
      Uri.parse('http://sih2020jss.herokuapp.com/component/$cameraScanResult'),
       headers: {
       "Accept":"application/json",
       "Content-Type": "application/json",
       "Authorization": "Bearer $token",
     }
    );
    setState(() {
      isLoading =false;
    });
  // print(json.decode(response.body));
  equipDetails=json.decode(response.body);
  print(equipDetails);


  }

  
  Future _scan()async{
    cameraScanResult = await  FlutterBarcodeScanner.
    scanBarcode("#414141", 'Cancel', true, ScanMode.QR);
    // cameraScanResult = await scanner.scan();
   setState(() {
     cameraScanResult = cameraScanResult;
     scanCompleted = true;
   });
    // print('Here the resulkt$cameraScanResult');
  }
  void initState() { 
    super.initState();
    _scan();
    
  }
  Widget build(BuildContext context) {
     final auth = Provider.of<Auth>(context);
     final token= auth.token;
    //  print('My Token is $token');
     if (token!=null &&once&&scanCompleted)
      {
        print('Scan Result is $cameraScanResult');
        _getEquipData(token);
        setState(() {
          once = false;
        });
      }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Quicksand'),
      home: Scaffold(
        backgroundColor: Color(0xFF092D6F) ,
        // body:isLoading?Center(child: CircularProgressIndicator()):
        body:isLoading?Center(child: CircularProgressIndicator(),):
        SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Center(
              child:Container(
                    child: SvgPicture.asset('assets/logo.svg',
                    width: 50,),
                  ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text('Scanner',style: TextStyle(color: Colors.white,fontSize: 18),),
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 155,
              decoration: BoxDecoration(
                color: Color(0xFFE5E5E5),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),
                topRight: Radius.circular(25))
              ),
              child: ListView.builder(
                itemCount: equipDetails['problems'].length,
                itemBuilder: (context,index)=>
                Card(
                  margin: const EdgeInsets.only(left:15,right: 15,top: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  color: Color(0xFFFFFFFF),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 120,
                    child: Row(
                      children: <Widget>[
                         Container(
                    child: SvgPicture.asset('assets/carrds.svg',
                    width: 30,),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                        padding: const EdgeInsets.only(left:15,right: 15,top: 15),
                        child: Text('Type of Flight  ${equipDetails['uid']}',style: TextStyle(color: Color(0xFF092D6F),fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:15,right: 15,top: 15),
                        child: equipDetails['problems'][index]['resolve']?Row(children: <Widget>[
                      Container(
                        width: 13,
                        height: 13,
                        child:  SvgPicture.asset('assets/check_mark.svg',fit:BoxFit.cover),
                      ),
                      SizedBox(width: 3,),
                      Text('Resolved',style: TextStyle(color: Color(0xFF6BD25A),fontWeight: FontWeight.bold)),
                      
                      
                      ],):
                        Row(children: <Widget>[
                      Container(
                        width: 13,
                        height: 13,
                        child:  SvgPicture.asset('assets/error.svg',fit:BoxFit.cover),
                      ),
                       SizedBox(width: 3,),
                      Text('Reported',style: TextStyle(color: Color(0xFFDB3535),fontWeight: FontWeight.bold)),
                      // Icon(Icons.error,color: Color(0xFFDB3535),),
                      
                      ],),
                      ),
                          ],
                        ),

                        // Problems

                        
                        Padding(
                          padding: const EdgeInsets.only(left:15,right: 15,top: 10),
                          child: Container(
                            //  color: Colors.pink,
                             width: MediaQuery.of(context).size.width-100,
                             height: 40,
                            //  child:  Text('Problem: ${problems[index]['problems'][i]['problem']}',style:TextStyle(color: Color(0xFF497E96)))
              
                          // overflow: TextOverflow.ellipsis,
                        // maxLines: 2,
                        // softWrap: true,
                        // )
                          
                       child:   Text('Problem: ${equipDetails['problems'][index]['problem']}',
                        style: TextStyle(color: Color(0xFF497E96)),),
                        ),
                        ),

                         Padding(
                          padding: const EdgeInsets.only(left:15,right: 15,bottom: 10),
                          child: Text('Name of Part: ${equipDetails['name']}',
                        style: TextStyle(color: Colors.black,fontSize: 11),),
                        )
                        
                      ],
                    ),
                      ],
                    ),
                    
                  ),
                ),
              ),
            )
          ],
        ),
        ) 
      ),
    );
  }
}