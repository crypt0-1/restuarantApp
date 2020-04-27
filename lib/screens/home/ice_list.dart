import 'package:firebase/screens/home/ice_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase/models/ice.dart';
class IceCreamList extends StatefulWidget {
  @override
  _IceCreamListState createState() => _IceCreamListState();
}

class _IceCreamListState extends State<IceCreamList> {
  @override
  Widget build(BuildContext context) {
    final iceCreams = Provider.of<List<Ice>>(context) ?? [];
    //print(icecreams.documents);
  
    return ListView.builder(
       itemCount: iceCreams.length,
       itemBuilder: (context,index){
         return IceTile(ice:iceCreams[index]);

    },);
  }
}