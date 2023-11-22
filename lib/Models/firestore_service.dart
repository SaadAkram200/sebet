import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sebet/models/user_model.dart';

class FirestoreServices {
  final CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('sebet_users');

  //Create user
  Future<void> addUser(UserModel user) {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    var doc = users.doc(uid);
    user.id = uid;
    return doc.set(user.toMap());
  }

  //for signup2 screen
    Future<void> updateUserData(String state, String zipcode, String city, String address) {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    return users.doc(uid).update({
      'state': state,
      'zipcode': zipcode,
      'city': city,
      'address': address,
    });
  }

  // for edit profile
    Future<void> editUserData(String firstname, String lastname, String phone, String address) {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    return users.doc(uid).update({
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'address': address,
    });
  }

//stream to get user location
  Stream<List<UserModel>> getUserData() {
    return FirebaseFirestore.instance.collection('users').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((document) {
        final data = document.data();
        return UserModel.fromMap(data);
      }).toList();
    });
  }
}