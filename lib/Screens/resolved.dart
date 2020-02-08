import './MyAppBar.dart';
import 'package:flutter/material.dart';
// import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../handling_data/Auth.dart';
import 'dart:convert';
class Resolved extends StatefulWidget {
  String _id;
  String uid;
  Resolved(this._id,this.uid);

  @override
  _ResolvedState createState() => _ResolvedState();
}

class _ResolvedState extends State<Resolved> {
   bool isResolved =false;
  Widget build(BuildContext context) {
    //  print('Uid is${widget.uid}');
    // print('id is ${widget.id}');
    final auth = Provider.of<Auth>(context);
  
    final _token =auth.token;
    print('_id Is : ${widget._id}');
    print('Token Resolved $_token');
     TextEditingController solution = TextEditingController();
     TextEditingController addrController = TextEditingController();
     TextEditingController uidController = TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Quicksand'),
      home:Scaffold(
        appBar: MyAppBar(context),
        body: SingleChildScrollView(
          child:   Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50,left: 15,right: 15),
              child:Center(
             child: Text('UID of Equipment: ${widget.uid}',style: TextStyle(color: Color(0xFF092D6F),fontSize: 20),),
              
           ) ,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 30,bottom: 10,top: 25),
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
                   

                  
                 
                    
                    
                  
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.only(left: 30,right: 30,bottom: 20),
                           child: Text('UID of Part' ,style:TextStyle( color:Color(0xFF474747),fontWeight: FontWeight.bold),),
                         ),
                            
                       ],
                     ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30,bottom: 20),
                      
                      child:  Container(
                        width: double.infinity - 30,
                       
                     
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
            Padding(
              padding: const EdgeInsets.all(30),
              child: TextField(
                
                controller: solution,
                keyboardType: TextInputType.text,
                maxLines: 6,
                decoration: InputDecoration(
                fillColor: Color.fromRGBO(240, 240, 240, 100),
              filled: true,

                  labelStyle: TextStyle(color: Color(0xFF000000),fontSize: 14),
                  labelText: 'Write your Solution Here'
                ),
              ),
            ),
           
           ButtonTheme(
             minWidth: double.infinity,
             height: 45,
             child:Padding(
               padding: const EdgeInsets.all(30),
               child: RaisedButton(
               onPressed: (){
                 _submit(widget._id,widget.uid,_token);
               },
               color: Color(0xFF3DBAF1),
               child: isResolved?Center(child: CircularProgressIndicator(),):
               Text('Resolved',style: TextStyle(color: Color(0xFF092D6F),fontSize: 20),),
             ),
             ),
              
           )
          ],
        ),
        )
      
      )
    );
    
  }
  Future _submit(String _id,String uid,String token)async{
    print('Resolved Pressed');
    if (_id != null && uid != null && token != null){
      
    setState(() {
      isResolved = true;
    });
     http.Response response = await http.put(
       Uri.parse('http://sih2020jss.herokuapp.com/resolve'),
       body: json.encode({
         'id':_id,
         'uid':uid,
          // 'Authorization': 'Bearer $token',
       }),
       headers:  {
       "Accept":"application/json",
       "Content-Type": "application/json",
       "Authorization": "Bearer $token",
     });
     setState(() {
       isResolved = false;
       Navigator.of(context).pop();
     });
     print('Resolved ${json.decode(response.body)}');
    }
  }
}