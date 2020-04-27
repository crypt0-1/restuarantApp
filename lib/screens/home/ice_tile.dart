import 'package:flutter/material.dart';
import 'package:firebase/models/ice.dart';

class IceTile extends StatelessWidget {
  final Ice ice;
  IceTile({this.ice});
  @override
  Widget build(BuildContext context) {
    return Padding(
padding: EdgeInsets.only(top:8),
child: Card(
  margin: EdgeInsets.fromLTRB(20, 6, 20,6),
  child: ListTile(
    leading: CircleAvatar(radius: 25,backgroundColor: Colors.pink[ice.scoops],),
    title: Text(ice.name),
    subtitle: Text('chose ${ice.flavors} flavors'),
  ),
  ),

    );
  }
}