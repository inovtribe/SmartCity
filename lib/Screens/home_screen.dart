import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../handling_data/Auth.dart';
import './MyAppBar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './AdminScreen.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver{
  bool load_userData = true;
  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  Widget build(BuildContext context) {
   final auth = Provider.of<Auth>(context);
   bool admin = auth.admin;
   Map<String,dynamic> userData = auth.getUserData;
   List<dynamic> problems= userData['problems'];
    // 
   print('Problems aree $problems');
    return  MaterialApp(
      theme: ThemeData(fontFamily: 'Quicksand'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFE5E5E5),
        appBar: MyAppBar(context),

        body:!admin?
            Stack(
          children: <Widget>[
           Container(
              height:MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.white,
              child: userData == null ?Center(child: CircularProgressIndicator(),) :
              UserDetails(userData),
            ),
            Positioned(
              top: 106,
              left: 25,
              child: Text('Past Records',style: TextStyle(color: Color(0xFF000000),fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'Quicksand'),),
            ),
            Positioned(
              top: 118,left: 0,
              child: 
              Container(
                width:MediaQuery.of(context).size.width,
                 height: MediaQuery.of(context).size.height - 280,
                // color: Colors.blue,
                child: ListView.builder(
                  itemCount: problems.length,
                  itemBuilder: (ctx,index)=>Card(
            color: Colors.white,
            elevation: 2.0,
            margin: const EdgeInsets.only(left: 18,right: 18,top: 13),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))
            ),
            child: Container(
              height: 130,
              child: Row(
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
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
/// ),
//                       ),
                      Padding(
                        padding: const EdgeInsets.only(left:15,right: 15,top: 15),
                        child: Text('Type of Flight  ${problems[index]['uid']}',style: TextStyle(color: Color(0xFF092D6F),fontWeight: FontWeight.bold,fontSize: 14,fontFamily: 'Poppins'),),
                      ),
                      SizedBox(width: 10,),
                           Padding(
                        padding: const EdgeInsets.only(left: 20,right: 5,top: 15),
                        child: problems[index]['resolve']?Row(children: <Widget>[
                      Container(
                        width: 13,
                        height: 13,
                        child:  SvgPicture.asset('assets/check_mark.svg',fit:BoxFit.cover),
                      ),
                     SizedBox(
                        width: 3,
                      ),
                      Text('Resolved',style: TextStyle(color: Color(0xFF6BD25A),fontWeight: FontWeight.bold)),
                      
                      
                      ],):
                        Row(children: <Widget>[
                      Container(
                        width: 13,
                        height: 13,
                        child:  SvgPicture.asset('assets/error.svg',fit:BoxFit.cover),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text('Reported',style: TextStyle(color: Color(0xFFDB3535),fontWeight: FontWeight.bold)),
                      // Icon(Icons.error,color: Color(0xFFDB3535),),
                      
                      ],
                      )
                      )
                       
                     
                       
                      
                      
                    ],
                  ),
               
                      Padding(
                      
                        padding: const EdgeInsets.only(left:15,right: 15,top: 7),
                        child:Column(
                          
                         children:<Widget>[
                           Container(
                            //  color: Colors.pink,
                             width: MediaQuery.of(context).size.width-100,
                             height: 40,
                             child:  Text('Problem: ${problems[index]['problem']}',style:TextStyle(color: Color(0xFF497E96),fontFamily: 'Poppins',fontWeight: FontWeight.w400,fontSize: 12),
                        
                           ),
                          // overflow: TextOverflow.ellipsis,
                        // maxLines: 2,
                        // softWrap: true,
                        )
                         ]                       
                        ),
                    
                      ),
                      Padding(
                      
                        padding: const EdgeInsets.only(left:15,right: 15,bottom: 5,top: 20),
                        child:Text('Uid : ${problems[index]['person']}',style:TextStyle(color: Colors.black,fontFamily: 'Poppins',fontWeight: FontWeight.w500,fontSize: 10))
              
                      )
                   ],
                
              )
                ],
              ),
              
            ),
           
          ),
                  
                  
                )
              )
              
               
            ),
           
            Positioned(
              bottom: 0,
              child:    Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                 Container(
                  width: MediaQuery.of(context).size.width*0.31,
                  height: 70,
                  color: Color(0xFF092D6F),
                  child:IconButton(
                    icon:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        
                        Icon(Icons.bug_report,color: Colors.white,),
                        Text('Report',style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    onPressed: (){
                      print('Report');
                      Navigator.of(context).popAndPushNamed('/report');
                    },
                ),
                ),

                
                   GestureDetector(
                 
                  child:   Container(
                    width: MediaQuery.of(context).size.width*0.38,
                    height: 90,
                    color:  Color(0xFF3DBAF1),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 2,),
                        Image.asset('assets/scanner.png',fit: BoxFit.cover,
                        width: 40,
                        height: 40,),
                        SizedBox(height: 4,),
                        Text('Scanner',style: TextStyle(color: Color(0xFF092D6F)),),
                        SizedBox(height: 2,),
                        
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).pushNamed('/scanner');
                    print("object");
                  },
                ),
                  
               GestureDetector(
                
                child: Container(
                  width: MediaQuery.of(context).size.width*0.31,
                  height: 70,
                  color:Color(0xFF092D6F),
                  child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        
                        Icon(Icons.flight,color: Colors.white,),
                        Text('Resolved',style: TextStyle(color: Colors.white),)
                      ],
                    ),
                ),
                onTap: (){
                  print("Resolved");
                  Navigator.of(context).pushNamed('/report_prev');
                },
                )
              ],
            ) ,
            )
          ],
        ):AdminScreen(),
        
         
        
        
      ),
    );
    
  }
  Widget UserDetails(Map<String,dynamic> userData){

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 20,),
        Container(
          width: 60,
          height: 60,
          // child: Text('A'),
          child: Image.asset('assets/person_pic.png'),
        
        ),
        SizedBox(width: 20,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${userData['item']['name']}',style: TextStyle(color: Color(0xFF000000),fontSize: 20,fontFamily: 'Poppins',fontWeight: FontWeight.w500 ),),
            Text('${userData['item']['email']}',style: TextStyle(color: Color(0xFF7B7B7B),fontSize: 11,fontFamily: 'Poppins',fontWeight: FontWeight.w300 )),
            // Text('${userData['item']['uid']}',style: TextStyle(color: Color(0xFF000000)),),
            // Text('hello'),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 0,right: 10,top: 8),
                  child: Text('Reported: ${userData['report']}',style: TextStyle(color: Color(0xFF092D6F),fontSize: 16,fontFamily: 'Poppins',fontWeight: FontWeight.w500),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 10,top: 8),
                  child: Text('Resolved : ${userData['resolve']}',style: TextStyle(color: Color(0xFF092D6F),fontFamily: 'Poppins',fontWeight: FontWeight.w500),),
                )
              ],
            )
          ],
        )
      ],
    );
  }
  
  void dispose() { 
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    setState(() {
      print('Home Screen Resumed');
    });
    super.didChangeAppLifecycleState(state);
  }
}