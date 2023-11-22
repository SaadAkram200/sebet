import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sebet/models/firestore_service.dart';
import 'package:sebet/models/user_model.dart';
import 'package:sebet/screens/monthly_budget.dart';
import 'package:sebet/screens/profile_page.dart';
import 'package:sebet/screens/transaction_page.dart';
import 'package:sebet/utils/colors.dart';
import 'package:sebet/utils/resuables.dart';

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
          // itemExtent: 37,

          // Remove padding
          padding: const EdgeInsets.only(top: 30),
          children: [
            //Username
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
                onPressed: () {
                  Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) =>const ProfilePage()));
                },
              ),
              onTap: () {},
            ),

            Divider(
              color: CColors.grey1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),

            //dashboard
            NavDrawerListTile(
              imagePath: "assets/images/dashboard.png",
              pageName: "Dashboard",
              onTap: () {
                Navigator.of(context).pop();
              },
            ),

            Divider(
              color: CColors.grey1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),

            //Monthly budget
            NavDrawerListTile(
                imagePath: "assets/images/monthlybudget.png",
                pageName: "Monthly Budget",
                onTap: () {
                  Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) =>const MonthlyBudget()));
                }),

            //Sinking fund
            NavDrawerListTile(
                imagePath: "assets/images/sinkingfund.png",
                pageName: "Sinking Fund",
                onTap: () {}),

            //Debt snowballs
            NavDrawerListTile(
                imagePath: "assets/images/debt.png",
                pageName: "Debt Snowball",
                onTap: () {}),

            Divider(
              color: CColors.grey1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),

            //Transactions
            NavDrawerListTile(
                imagePath: "assets/images/transaction.png",
                pageName: "Transaction",
                onTap: () {
                  Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) =>const TransactionPage()));
                }),

            //weekly schedule
            NavDrawerListTile(
                imagePath: "assets/images/Calendar.png",
                pageName: "Weekly Schedule",
                onTap: () {}),

            //reports
            NavDrawerListTile(
                imagePath: "assets/images/reports.png",
                pageName: "Reports",
                onTap: () {}),

            Divider(
              color: CColors.grey1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),

            //CSV file Picker
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
                              borderRadius: BorderRadius.circular(10),
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
                                  color: CColors.greenGrad2,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                  // offset: Offset(6,6), // Shadow position
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          "of your bank transactions",
                          style: TextStyle(color: CColors.grey2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              color: CColors.grey1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
          ],
        ),
      ),
    );
  }
}
