import 'package:flutter/material.dart';
import 'package:sebet/Sebet/dashboard.dart';
import 'package:sebet/colors.dart';
import 'package:sebet/resuables.dart';

class MonthlyBudget extends StatelessWidget {
  const MonthlyBudget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CColors.primary,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButtonAndPageName(
              pageName: "Monthly Budget",
              onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
            }),
          ],
        ),
      ),
    );
  }
}
