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
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        _globalKey.currentState?.openDrawer();
                      },
                      child: Image.asset(
                        "assets/images/navDrawerButton.png",
                        scale: 1.4,
                      )),
                  const Spacer(),
                  Image.asset(
                    "assets/images/sebetlogo.png",
                    scale: 12,
                  ),
                  const Text(
                    "SEBET",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 29,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const Spacer()
                ],
              ),
              Divider(
                color: CColors.grey1,
                thickness: 1,
              ),
              Expanded(
                  child: Container(
                color: Colors.amber,
                child: ListView(children: [ ]),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
