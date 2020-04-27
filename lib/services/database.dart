import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/ice.dart';
import 'package:firebase/models/user.dart';



class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference iceCreamCollection = Firestore.instance.collection('iceCreams');
  Future updateUserData(String flavors,String name ,int scoops) async {
    return await iceCreamCollection.document(uid).setData({
      'flavors':flavors,
      'name': name,
      'scoops':scoops,
    });
  }

//
List<Ice> _iceListFromSnapshot(QuerySnapshot snapshot){
  return snapshot.documents.map((doc){
      return Ice(
        name:doc.data['name'] ?? '',
        scoops:doc.data['scoops'] ?? 100,
        flavors:doc.data['flavors'] ?? '0',


      );
  }).toList();

}
//userdata from snapshot
UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
  return UserData(
    uid:uid,
    name:snapshot.data['name'],
    flavors:snapshot.data['falvors'],
    scoop:snapshot.data['scoops'],
  );
}


  //get icecream stream

  Stream<List<Ice>> get iceCreams {
    return iceCreamCollection.snapshots()
    .map(_iceListFromSnapshot);
  }

  Stream<UserData> get userData {
      return iceCreamCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);  
  }


}