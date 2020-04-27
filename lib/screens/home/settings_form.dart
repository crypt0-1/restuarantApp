import 'package:firebase/models/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase/services/database.dart';
import 'package:firebase/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:firebase/shared/loading.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();
  final List<String> flavors = [
    'strawberry',
    'chocolate',
    'vanilla',
  ];
  final List<int> scoops = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  String _currentName;
  String _currentFlavors;
  int _currentScoops;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData =snapshot.data;
            return Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Text(
                    'update your iceCream settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 10,
                  ),
               
                  DropdownButtonFormField(
                     decoration: textInputDecoration,
                     value: _currentFlavors ?? userData.flavors,
                    items: flavors.map((flavor) {
                      return DropdownMenuItem(
                        value: flavor,
                        child: Text('$flavor falvors'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentFlavors = val),
                  ),
                      Slider(
                  value: (_currentScoops ?? userData.scoop).toDouble(),
                  activeColor: Colors.brown[_currentScoops ?? userData.scoop],
                  inactiveColor: Colors.brown[_currentScoops ?? userData.scoop],
                  min: 100.0,
                  max: 900.0,
            divisions: 8,
                 
                  onChanged: (val) => setState(() => _currentScoops = val.round()),
                ),
                  RaisedButton(
                    color: Colors.pink,
                    child:
                        Text('update', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid:user.uid).updateUserData(
                          _currentFlavors ?? userData.flavors,
                         _currentName ?? userData.name,
                          _currentScoops ?? userData.scoop
                          );
                          Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();

          }
        });
  }
}
