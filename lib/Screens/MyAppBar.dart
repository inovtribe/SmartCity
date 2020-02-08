import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
Widget MyAppBar(BuildContext context){
  return  AppBar(
          leading:Padding(
            padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),
            child: Container(
                    child: SvgPicture.asset('assets/aeroLogo.svg',
                    width: 5,),
                  ),
          ),
          
          title: Text('Maintenance UnderControl',style: TextStyle(color: Colors.white,fontSize: 14),),
          backgroundColor: Color(0xFF092D6F),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton(
              initialValue: 0,
              onSelected: (selectedVal){
                print("$selectedVal");
                if (selectedVal == 3){
                 while(Navigator.of(context).canPop())
                  {
                    Navigator.of(context).pop();
                  }}
                  else if (selectedVal == 1)
                   {
                     Navigator.of(context).pushNamed('/problems');
                   }
                   else
                    {
                      Navigator.of(context).pushNamed('/help');
                    }
              },
              itemBuilder: (_)=>[
                
                 PopupMenuItem(
                  value: 1,
                  child: Text('Problems',style: TextStyle(color: Color(0xFF092D6F)),),
                ),
                 PopupMenuItem(
                  value: 2,
                  child: Text('Help',style: TextStyle(color: Color(0xFF092D6F)),),
                ),
                 PopupMenuItem(
                  value: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      
                       Text('Logout',style: TextStyle(color: Color(0xFF092D6F)),),
                       Icon(Icons.arrow_right)
                    ],
                  )
                 
                )
              ],
            )
          ],
        );
}