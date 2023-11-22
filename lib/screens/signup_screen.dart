// ignore_for_file: no_leading_underscores_for_local_identifiers, must_be_immutable, prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sebet/models/firestore_service.dart';
import 'package:sebet/models/user_model.dart';
import 'package:sebet/screens/signup_screen2.dart';
import 'package:sebet/utils/resuables.dart';

import '../utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //firestoreservice
  final FirestoreServices firestoreServices = FirestoreServices();
  //SignUp Functiom
  Future signUp() async {
    if (_fnameController.text == "" ||
        _lnameController.text == "" ||
        _phoneController.text == "") {
      Fluttertoast.showToast(
        msg: "Please Fill all the fields!",
        backgroundColor: CColors.textfieldColor,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        textColor: Colors.white,
        fontSize: 15,
      );
    } else if (_passwordController.text != _confirmPassController.text) {
      Fluttertoast.showToast(
        msg: "Confirm password doesn't match!",
        backgroundColor: CColors.textfieldColor,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        textColor: Colors.white,
        fontSize: 15,
      );
    } else {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);

        final newUser = UserModel(
            firstname: _fnameController.text,
            lastname: _lnameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            state: null,
            zipcode: null,
            city: null,
            address: null);
        firestoreServices.addUser(newUser).then((value) =>
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SignUpScreen2()),
                (route) => true));
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
    }
  }

  //Textfield Controller
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _confirmPassController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _fnameController = TextEditingController();

  TextEditingController _lnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            
            //back button
            BackButtonAndPageName(
              onTap: () {
                Navigator.pop(context);
              },
            ),

            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 36,
                  right: 36,
                ),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    //logo and starting text
                    const LogoAndText(
                      text1: "Hello,",
                      text2: "Signup to",
                      text3: "get started!",
                    ),

                    //first and last name
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // first name
                        Flexible(
                            child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: SebetTextfields(
                              controller: _fnameController,
                              fieldName: "First name",
                              obscureText: false),
                        )),

                        //last name
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: SebetTextfields(
                                controller: _lnameController,
                                fieldName: "last Name",
                                obscureText: false),
                          ),
                        ),
                      ],
                    ),

                    //email textfield
                    SebetTextfields(
                      controller: _emailController,
                      fieldName: "Email",
                    ),

                    //phone textfield
                    SebetTextfields(
                      controller: _phoneController,
                      fieldName: "Phone",
                    ),

                    //password textfield
                    SebetTextfields(
                      controller: _passwordController,
                      fieldName: "Password",
                      obscureText: true,
                    ),

                    //confirm pass textfield
                    SebetTextfields(
                      controller: _confirmPassController,
                      fieldName: "Confirm Password",
                      obscureText: true,
                    ),

                    // signup button
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SignButton(
                          buttonName: "Sign Up",
                          onPressed: () {
                            signUp();
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
