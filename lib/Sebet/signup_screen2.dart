// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sebet/Models/firestore_service.dart';
import 'package:sebet/Sebet/dashboard.dart';
import 'package:sebet/colors.dart';
import 'package:sebet/resuables.dart';

class SignUpScreen2 extends StatefulWidget {
  const SignUpScreen2({super.key});

  @override
  State<SignUpScreen2> createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  //Textfield Controller
  TextEditingController _zipCodeController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _referalCodeController = TextEditingController();

  //for Dropdownbutton of state
  String? dropdownValue;

  //firestoreservice
  final FirestoreServices firestoreServices = FirestoreServices();
  //SignUp Functiom
  Future signUp2() async {
    if (_zipCodeController.text == "" ||
        _addressController.text == "" ||
        _cityController.text == "" ||
        dropdownValue.toString() == "") {
      Fluttertoast.showToast(
        msg: "Please fill all the fields!!",
        backgroundColor: CColors.textfieldColor,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        textColor: CColors.grey,
        fontSize: 15,
      );
    } else {
      try {
        firestoreServices
            .updateUserData(dropdownValue.toString(), _zipCodeController.text,
                _cityController.text, _cityController.text)
            .then((value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
                (route) => false));
      } catch (e) {
        Fluttertoast.showToast(
          msg: "An Error occors, please try again",
          backgroundColor: CColors.textfieldColor,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          textColor: CColors.grey,
          fontSize: 15,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.primary,
      body: SafeArea(
          child: Column(
        children: [
          //back button
          BackButtonAndPageName(onTap: () {
            Navigator.pop(context);
          }),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 36, right: 36),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Logo and texts
                    const LogoAndText(
                        text1: "A few more",
                        text2: "details to",
                        text3: "begin"),

                    //state and zip code
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // State
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                  color: CColors.textfieldColor),
                              child: DropdownButtonHideUnderline(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: DropdownButton(
                                    value: dropdownValue,
                                    dropdownColor: CColors.textfieldColor,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: CColors.greenGrad1,
                                      size: 30,
                                    ),
                                    hint: Text(
                                      "State",
                                      style:
                                          TextStyle(color: CColors.greenGrad1),
                                    ),
                                    items: <String>[
                                      'Pakistan',
                                      'UAE',
                                      'Turkey',
                                      'Qatar'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                      );
                                    }).toList(),
                                    borderRadius: BorderRadius.circular(10),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        //zip code
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: SebetTextfields(
                              controller: _zipCodeController,
                              fieldName: "Zip Code",
                            ),
                          ),
                        ),
                      ],
                    ),

                    //city text field
                    SebetTextfields(
                      controller: _cityController,
                      fieldName: "City",
                    ),

                    //street address text field
                    SebetTextfields(
                      controller: _addressController,
                      fieldName: "Street Address",
                      maxLines: 6,
                    ),

                    Divider(
                      color: CColors.grey1,
                      thickness: 1,
                    ),

                    //Referal code text field
                    SebetTextfields(
                      controller: _referalCodeController,
                      fieldName: "Referal code (Optional)",
                    ),

                    //start button
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SignButton(
                          buttonName: "Start",
                          onPressed: () {
                            signUp2();
                          }),
                    ),
                  ]),
            ),
          ),
        ],
      )),
    );
  }
}
