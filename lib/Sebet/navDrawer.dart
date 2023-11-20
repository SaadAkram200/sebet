import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sebet/Models/firestore_service.dart';
import 'package:sebet/Models/user_model.dart';
import 'package:sebet/colors.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
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
    return Drawer(
      child: Container(
        color: CColors.primary,
        child: ListView(
          //itemExtent: 37,

          // Remove padding
          padding: const EdgeInsets.only(top: 30),
          children: [
            ListTile(
              leading: Image.asset("assets/images/user.png"),
              title: const Text(
                "Hello!",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              subtitle: Text(
                userData != null
                    ? "${userData!.firstname} ${userData!.lastname}"
                    : 'loading',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              trailing: TextButton(
                child: Text(
                  "View Profile",
                  style: TextStyle(color: CColors.greenGrad1),
                ),
                onPressed: () {},
              ),
              onTap: () {},
            ),
            Divider(
              color: CColors.grey1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              leading: Image.asset("assets/images/dashboard.png"),
              title: const Text(
                "Dashboard",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {},
            ),
            Divider(
              color: CColors.grey1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              leading: Image.asset("assets/images/monthlybudget.png"),
              title: const Text(
                "Monthly Budget",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Image.asset("assets/images/sinkingfund.png"),
              title: const Text(
                "Sinking Fund",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            ListTile(
              leading: Image.asset("assets/images/debt.png"),
              title: const Text(
                "Debt Snowball",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {},
            ),
            Divider(
              color: CColors.grey1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              leading: Image.asset("assets/images/transaction.png"),
              title: const Text(
                "Transaction",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Image.asset("assets/images/Calendar.png"),
              title: const Text(
                "Weekly Schedule",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Image.asset("assets/images/reports.png"),
              title: const Text(
                "Reports",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {},
            ),
            Divider(
              color: CColors.grey1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: DottedBorder(
                dashPattern: const [15, 5],
                strokeWidth: 2,
                color: CColors.grey1,
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                padding: const EdgeInsets.all(6),
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                colors: [
                                  CColors.greenGrad1,
                                  CColors.greenGrad2,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: CColors.greenGrad1,
                                  blurRadius: 4,
                                  offset: Offset(6,6), // Shadow position
                                ),
                                BoxShadow(
                                  color: CColors.greenGrad1,
                                  blurRadius: 4,
                                  offset: Offset(-6,-6), // Shadow position
                                ),
                              ],
                            ),
                            child: Center(
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.add,
                                      color: CColors.primary,
                                    ))),
                          ),
                        ),
                      ),
                      Text(
                        "Upload CVS Files",
                        style: TextStyle(color: CColors.grey2),
                      ),
                      Text(
                        "of your bank transactions",
                        style: TextStyle(color: CColors.grey2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
