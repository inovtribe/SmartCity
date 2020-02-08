import 'package:airport_app/Screens/resolved.dart';
import 'package:flutter/material.dart';
// import 'package:qrscan/qrscan.dart' as scanner;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../handling_data/Auth.dart';
import './report.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
class Report_prev extends StatefulWidget {
  Report_prev({Key key}) : super(key: key);

  @override
  _Report_prevState createState() => _Report_prevState();
}

class _Report_prevState extends State<Report_prev> {
 
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
    //  cameraScanResult = await scanner.scan();
   setState(() {
     cameraScanResult = cameraScanResult;
     scanCompleted = true;
   });
  }
   
    void initState() { 
      super.initState();
      _scan();
    }
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
     final token= auth.token;
     print('Token muy $token');
       
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
      home:  Scaffold(
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
                    width: 40,),
                  ),
             
           ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text('Resolve',style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: 'Quicksand',fontWeight: FontWeight.w400),),
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 155,
              decoration: BoxDecoration(
                color: Color(0xFFE5E5E5),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75),
                topRight: Radius.circular(50))
              ),
              child: ListView.builder(
                itemCount: equipDetails['problems'].length,
                itemBuilder: (context,index)=>
                GestureDetector(
                  onTap: (){
                    print('Tapped');
                     Navigator.push(context, MaterialPageRoute(builder: (context) => Resolved(equipDetails['problems'][index]['_id'],equipDetails['problems'][index]['uid'])));
           
                  },
                  child: Card(
                  margin: const EdgeInsets.only(left:15,right: 15,top: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  color: Color(0xFFFFFFFF),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 120,
                    child:Row(
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
                      SizedBox(width: 10,),
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
                          padding: const EdgeInsets.only(left:15,right: 15,bottom: 10,top: 7),
                          child: Container(
                            //  color: Colors.pink,
                             width: MediaQuery.of(context).size.width-100,
                             height: 40,
                             child:  
                          Text('Problem: ${equipDetails['problems'][index]['problem']}',
                        style: TextStyle(color: Color(0xFF497E96)),),
                          // overflow: TextOverflow.ellipsis,
                        // maxLines: 2,
                        // softWrap: true,
                        )
                        ),

                         Padding(
                          padding: const EdgeInsets.only(left:15,right: 15,bottom: 10),
                          child: Text('Name of Part: ${equipDetails['name']}',
                        style: TextStyle(color: Color(0xFF497E96)),),
                        )
                        
                      ],
                    ),

                      ],
                    ),
                     
                  ),
                ),
                )
                
              ),
            )
          ],
        ),
        ) 
      ),
    );
  }
}