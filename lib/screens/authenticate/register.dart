import 'package:firebase/shared/constants.dart';
import 'package:firebase/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
   final AuthService _auth = AuthService();
   final _formKey = GlobalKey<FormState>();
   bool loading =false;

    String email ='';
  String password ='';
  String error ='';

 
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : MaterialApp(
       home: Container(
        
        decoration: BoxDecoration(
        
            image: DecorationImage(
                image: AssetImage('assets/gradient.png'), fit: BoxFit.cover)),
       child: Scaffold(
          
         backgroundColor: Colors.transparent,
         body: Container(
          //  margin: EdgeInsets.only(top: 200.0,left: 0.0),
           padding:EdgeInsets.symmetric(vertical:20.0,horizontal:50.0),
           child:Form(
             key: _formKey,
             child: Column(
             children: <Widget>[
               Container(
                 child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                  
                  Text('Signup page',style: TextStyle(color:Colors.white),),
                  FlatButton.icon(onPressed: (){
                      widget.toggleView();
                    
                  }, icon: Icon(Icons.person,color: Colors.white),
                label: Text('signin',style: TextStyle(color: Colors.white),),),
                 ], 
              
               ),
               ),
               SizedBox(height: 20),
               TextFormField(
                   
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null  ,
                 onChanged: (val){
                 setState(() {
                   email=val;
                 });

               }),
                SizedBox(height: 20),
                TextFormField( 
                  
                  
                decoration: textInputDecoration.copyWith(hintText: 'Password'),

                
                obscureText: true,
                validator: (val) => val.length <6 ? 'Enter password 6+ characters' : null  ,
                onChanged: (val){
                     setState(() {
                   password=val;
                 });

                }),
                 SizedBox(height: 20),
                 OutlineButton(
              borderSide: BorderSide(color: Colors.white),
              shape: StadiumBorder(),

             
              color: Colors.transparent,
              child: Text('Register',style: TextStyle(color: Colors.white ),),
              onPressed: () async{
                if(_formKey.currentState.validate())
                {
                  setState(() {
                    loading=true;
                  });
                 dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                 if(result == null){
                    setState(() {
                      error='please enter valid email';
                      loading=false;

                    });
                 }
                }

              },
                 ),
                SizedBox(height:12),
                Text(error, style:TextStyle(color:Colors.red,fontSize:14) ,)


             ],
             
             ),
             
             ) ,

            







          //  child: OutlineButton(
          //    borderSide: BorderSide(color: Colors.white),
          //    shape: StadiumBorder(),

             
          //    color: Colors.transparent,
          //    child: Text('Guest Login',style: TextStyle(color: Colors.white ),),
          //    onPressed:()async {
          //        dynamic result = await _auth.signInAnon();
          //        if (result == null){
          //          print('error signing in');

          //        }else{
          //          print('signed in');
          //          print(result.uid);
          //        }

          //    }
          //  ),
           ),
        ),
       ),
        

      
     
      
      
      
    );
  }
}