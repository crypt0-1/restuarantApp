import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/screens/home/ice_list.dart';
import 'package:firebase/screens/home/settings_form.dart';
import 'package:firebase/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase/services/database.dart';
import 'package:provider/provider.dart';
import 'package:firebase/models/ice.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container (padding: EdgeInsets.symmetric(vertical:20,horizontal:60),
        child: Settings(),
        );

      });
    }
    return StreamProvider<List<Ice>>.value(
      value:DatabaseService().iceCreams,
          child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title:Text('brew'),
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: <Widget>[
            
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0.5,vertical: 0.5),
              margin: EdgeInsets.all(10),
              decoration: const BoxDecoration(
      border: Border(
         top: BorderSide(width: 1, color: Colors.pink),
        left: BorderSide(width: 1, color: Colors.pink),
        right: BorderSide(width: 1, color: Colors.pink),
        bottom: BorderSide(width: 1, color: Colors.pink),
       
      ),
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),

              child: FlatButton.icon(
                
                
                
                  
                  icon: Icon(Icons.person,color: Colors.pink,),
                  label: Text('logout',style: TextStyle(color: Colors.pink),),
                  onPressed: () async {
                    await _auth.signout();

                    
                  },
                
                ),
               
            ),
            FlatButton.icon(
              onPressed: (){
                _showSettingsPanel();
              },
             icon: Icon(Icons.settings),

             label: Text('settings')),
          ],
        ),
        body: IceCreamList(),
      ),
    );
  }
}