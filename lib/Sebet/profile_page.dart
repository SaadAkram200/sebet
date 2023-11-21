import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sebet/Models/firestore_service.dart';
import 'package:sebet/Models/user_model.dart';
import 'package:sebet/Sebet/dashboard.dart';
import 'package:sebet/colors.dart';
import 'package:sebet/resuables.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //forestore services instant
  FirestoreServices firestoreServices = FirestoreServices();

// variable to store userdata coming from Firestore
  UserModel? userData;

  //geting user info
  @override
  void initState() {
    super.initState();
    var uid = FirebaseAuth.instance.currentUser?.uid;
    firestoreServices.users.doc(uid).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        userData = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);

        setState(() {});
      } else {
        print('no data');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.textfieldColor,
      body: SafeArea(
        child: Container(
          color: CColors.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            //profile column
            Container(
              color: CColors.textfieldColor,
              child: Column(children: [
                BackButtonAndPageName(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Dashboard()));
                  },
                  pageName: "Profile",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Image.asset("assets/images/userprofile.png"),
                )
              ]),
            ),

            //userdata column
            Container(
              color: CColors.primary,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(children: [
                  //username
                  Text(
                    userData != null
                        ? "${userData!.firstname} ${userData!.lastname}"
                        : 'loading',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),

                  //email
                  Text(
                    userData != null ? userData!.email : 'loading',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  //phone
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Text(
                      userData != null ? userData!.phone : 'loading',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  //address
                  Text(
                    userData != null ? userData!.address! : 'loading',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                  Container(
                    child: Row(children: [
                      Image.asset("assets/images/editicon.png", scale: 1.5,),
                      Text(
                        'Sign Up',
                        style: TextStyle(color: CColors.greenGrad1),
                      ),
                    ]),
                  ),

                  Divider(
                    color: CColors.grey1,
                    thickness: 1,
                  ),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
