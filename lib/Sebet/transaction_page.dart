import 'package:flutter/material.dart';
import 'package:sebet/Sebet/dashboard.dart';
import 'package:sebet/colors.dart';
import 'package:sebet/resuables.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.primary,
      body: SafeArea(
          child: Column(
        children: [
          BackButtonAndPageName(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
            },
            pageName: "Transaction",
          )
        ],
      )),
    );
  }
}
