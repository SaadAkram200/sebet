import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:sebet/models/firestore_service.dart';
import 'package:sebet/models/user_model.dart';
import 'package:sebet/screens/dashboard.dart';
import 'package:sebet/screens/login_screen.dart';
import 'package:sebet/utils/colors.dart';
import 'package:sebet/utils/resuables.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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
  late StreamSubscription? streamSubscription;
  //geting user info
  @override
  void initState() {
    super.initState();
    var uid = FirebaseAuth.instance.currentUser?.uid;
    streamSubscription = firestoreServices.users.doc(uid).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        userData = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);

        setState(() {});
      } else {
        print('no data');
      }
    });
  }

  //Text controllers
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  //edit user data
  editUserData() {
    _fnameController.text = userData!.firstname;
    _lnameController.text = userData!.lastname;
    _phoneController.text = userData!.phone;
    _addressController.text = userData!.address!;

    return AlertDialog(
      backgroundColor: CColors.primary,
      title: const Text(
        "Edit User",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Cancel",
            style: TextStyle(color: CColors.redGrad1),
          ),
        ),
        TextButton(
          onPressed: () {
            try {
              firestoreServices
                  .editUserData(_fnameController.text, _lnameController.text,
                      _phoneController.text, _addressController.text)
                  .then((value) {
                Fluttertoast.showToast(
                  msg: "Profile Edited Sucessfully!",
                  backgroundColor: CColors.textfieldColor,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                  textColor: Colors.white,
                  fontSize: 15,
                );
                Navigator.of(context).pop();
              });
            } catch (e) {
              Fluttertoast.showToast(
                msg: "An Error occors, please try again",
                backgroundColor: CColors.textfieldColor,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                textColor: Colors.white,
                fontSize: 15,
              );
            }
          },
          child: Text(
            "Edit",
            style: TextStyle(color: CColors.greenGrad1),
          ),
        ),
      ],
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        SebetTextfields(controller: _fnameController, fieldName: "First Name"),
        SebetTextfields(controller: _lnameController, fieldName: "Last Name"),
        SebetTextfields(
            controller: _phoneController, fieldName: "Phone Number"),
        SebetTextfields(
            controller: _addressController, fieldName: "Address", maxLines: 3),
      ]),
    );
  }

  //signout method
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut().then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()));
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
                Expanded(
                  child: Container(
                    color: CColors.primary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
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

                        //edit button
                        SmallButton(
                            iconName: IconlyBold.editSquare,
                            buttonName: "Edit Profile",
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => editUserData(),
                              );
                            }),

                        Divider(
                          color: CColors.grey1,
                          thickness: 1,
                        ),

                        //Referral
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Your Referral code",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),

                        DottedBorder(
                          dashPattern: const [15, 5],
                          strokeWidth: 2,
                          color: CColors.grey1,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(6),
                          child: Container(
                            width: double.infinity,
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GradientText(
                                  "AA34X66",
                                  colors: [CColors.redGrad1, CColors.redGrad2],
                                  style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w900),
                                  gradientType: GradientType.linear,
                                  gradientDirection: GradientDirection.ttb,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // referral agreement and my referral buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Referral Agreement",
                                  style: TextStyle(color: CColors.greenGrad1),
                                )),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "My Referral",
                                  style: TextStyle(color: CColors.greenGrad1),
                                )),
                          ],
                        ),
                      ]),
                    ),
                  ),
                ),

                // logout button
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            signOut();
                          },
                          child: Text(
                            "Logout",
                            style: TextStyle(color: CColors.redGrad1),
                          )),
                      Image.asset(
                        "assets/images/logouticon.png",
                        scale: 4,
                      )
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    streamSubscription!.cancel();
    super.dispose();
  }
}
