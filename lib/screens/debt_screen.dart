import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sebet/screens/dashboard.dart';
import 'package:sebet/utils/colors.dart';
import 'package:sebet/utils/resuables.dart';

class DebtScreen extends StatelessWidget {
  const DebtScreen({super.key});

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
            pageName: "Debt SnowBall",
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "Enter your debts here.  Add something extra that\nyou want to throw at these debts if you can and\npress the button to begin your debt snowball\nplan!",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Divider(
            color: CColors.grey1,
            thickness: 1,
          ),

          //Extra income button
          SmallButton(
              iconName: IconlyBold.plus,
              buttonName: "Extra Income",
              onPressed: () {}),

          Divider(
            color: CColors.grey1,
            thickness: 1,
          ),

          // expanses image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Image.asset("assets/images/dummyexpanse.png"),
          ),

          //add a debt button
          SmallButton(
              iconName: IconlyBold.plus,
              buttonName: "Add a Debt",
              onPressed: () {}),

          // no data column
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/nodata.png",
                  scale: 4,
                ),
                
                const SizedBox(height: 20,),
                
                const Text(
                  "No data found",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
