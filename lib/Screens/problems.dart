import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../handling_data/Auth.dart';
import './MyAppBar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './MyMap.dart';
import 'package:location/location.dart';
import './loadingScreen.dart';
class Problems extends StatefulWidget {
  Problems({Key key}) : super(key: key);

  @override
  _ProblemsState createState() => _ProblemsState();
}

class _ProblemsState extends State<Problems> {
  bool isLoading = true;
  bool once = false;
  double latitude ;
  double longitude;
  bool locationFetched = false;

  double equipLatitde;
  double equipLongitude;
  List<dynamic> problems;
    Future _getData()async{
    LocationData currentLocation ;

var location = new Location();

// Platform messages may fail, so we use a try/catch PlatformException.
try {
  currentLocation = await location.getLocation();
  print(currentLocation.latitude);
  print(currentLocation.longitude);
  latitude = currentLocation.latitude;
  longitude=currentLocation.longitude;
  setState(() {
    locationFetched = true;
  });
}  catch (e) {
  if (e.code == 'PERMISSION_DENIED') {
    print("Denied");}
  else
   print("Some other error occured!");
  } 
  currentLocation = null;
}
 Future _getProblems(String authToken,context)async{
   http.Response response = await http.get(
     Uri.parse('http://sih2020jss.herokuapp.com/problem',
     
     ),headers: {
       "Accept":"application/json",
       "Content-Type": "application/json",
       "Authorization": "Bearer $authToken",
     }
   ).catchError((onError){
     showDialog(context: context,
     builder: (ctx)=>AlertDialog(
       title: Text('Internet Problem'),
       content: Text('Can not load this page because of internet issues .'),
       actions: <Widget>[
         FlatButton(
           child: Text('Ok'),
           onPressed: (){
             
             Navigator.of(context).pop();
             
           },
         )
       ],
     )
     );
   });
  //  print(json.decode(response.body));
   problems = json.decode(response.body);
  //  print('Problems are is $problems');
  //  print('length of problems is ${problems.length}');
 }
  void initState() { 
    super.initState();
   _getData();
  }
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final authToken = auth.token;
    if (!once){
      _getProblems(authToken,context).then((_){
       setState(() {
        isLoading = false;
       });
     });
     once = true;
    }
     
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins'
      ),
      home: Scaffold(
        backgroundColor: Color(0xFFE5E5E5),
        appBar: MyAppBar(context),
        body:isLoading?LoadingScreen()
        :
        ListView.builder(
           
          itemCount: problems.length,
          itemBuilder: (ctx,index)=>
          
            ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: problems[index]['problems'].length,
            itemBuilder: (ctx,i)=>
            GestureDetector(
              onTap: (){
                // print("object");
              locationFetched?
              Navigator.push(context,MaterialPageRoute(
               builder: (ctx)=>MyMap(latitude,longitude,problems[index]['problems'][i]['latitude'],problems[index]['problems'][i]['longitude'])
                )):Center(child: CircularProgressIndicator(),);             
              },
              child:  Card(
              
            color: Colors.white,
            elevation: 10.0,
            margin: const EdgeInsets.only(left: 15,right: 15,top: 10),
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))
            ),
            child: Container(
              height: 130,
              child:Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: <Widget>[
                   Container(
                    child: SvgPicture.asset('assets/carrds.svg',
                    width: 30,),
                  ),
                 Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left:15,right: 15,top: 15),
                        child: Text('Type of Flight  ${problems[index]['uid']}',style: TextStyle(color: Color(0xFF092D6F),fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(width: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left:15,right: 15,top: 15),
                        child: problems[index]['problems'][i]['resolve']?Row(children: <Widget>[
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                      
                        padding: const EdgeInsets.only(left:15,right: 15,top: 15),
                        child:Column(
                          
                         children:<Widget>[
                           Container(
                            //  color: Colors.pink,
                             width: MediaQuery.of(context).size.width-100,
                             height: 40,
                             child:  Text('Problem: ${problems[index]['problems'][i]['problem']}',style:TextStyle(color: Color(0xFF497E96)))
              
                          // overflow: TextOverflow.ellipsis,
                        // maxLines: 2,
                        // softWrap: true,
                        )
                         ]                       
                        ),
                       
                      )
                      
                    ],
                  ),
                  Padding(
                      
                        padding: const EdgeInsets.only(left:15,right: 15,top: 15),
                        child:Text('Uid: ${problems[index]['problems'][i]['person']}',style:TextStyle(color: Color(0xFF497E96),fontWeight: FontWeight.w500,fontSize: 10))
              
                      )
                    ],
                
              )
                 ],
              ),

            ),
            
            
          ),
            )
           
          ),
          
           
          
         
        ),
          
        
       
        
         
      ),
    );
  }
}