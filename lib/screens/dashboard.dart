import 'package:flutter/material.dart';
import 'package:sebet/screens/navDrawer.dart';
import 'package:sebet/utils/colors.dart';

// ignore: must_be_immutable
class Dashboard extends StatelessWidget {
   Dashboard({super.key});

//for navdrawer
final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.primary,
      key: _globalKey,
      drawer: const NavDrawer(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  _globalKey.currentState?.openDrawer();
                },
                child: Image.asset("assets/images/navDrawerButton.png")),
          ],
        ),
      ),
    );
  }
}
