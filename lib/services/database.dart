import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_firebase/models/brew.dart';
import 'package:flutter_firebase/models/user.dart';

class DatabaseService {
  String? uid;

  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection("brews");

  Future updateUserData(String name, String sugar, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({"Name": name, "Sugar": sugar, "Strength": strength});
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc.get('Name') ?? "",
          sugar: doc.get('Sugar') ?? "",
          strength: doc.get('Strength') ?? 0);
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.get("Name"),
        sugars: snapshot.get("Sugar"),
        strength: snapshot.get("Strength"));
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
