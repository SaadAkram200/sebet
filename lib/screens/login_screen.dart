// ignore_for_file: no_leading_underscores_for_local_identifiers, must_be_immutable, prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sebet/screens/signup_screen.dart';
import 'package:sebet/utils/colors.dart';
import 'package:sebet/utils/resuables.dart';

import 'dashboard.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

//Textfield Controller
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
//sign in function
  Future signIn(context) async {
    // checking if Textfields are empty
    if (_emailController.text == "" || _passwordController.text == "") {
      Fluttertoast.showToast(
        msg: "Please enter Email or Password",
        backgroundColor: CColors.textfieldColor,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        textColor: Colors.white,
        fontSize: 15,
      );
    } else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
            (route) => false);
      } catch (error) {
        Fluttertoast.showToast(
          msg: "Incorrect Email or Password",
          backgroundColor: CColors.textfieldColor,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
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
        child: Padding(
          padding: const EdgeInsets.only(left: 36, right: 36, top: 60),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //logo and texts
                  const LogoAndText(
                      text1: "Hello again,", text2: "welcome", text3: "back!"),

                  //email text field
                  SebetTextfields(
                    controller: _emailController,
                    fieldName: "Email",
                  ),

                  //password text field
                  SebetTextfields(
                    controller: _passwordController,
                    fieldName: "Password",
                    obscureText: true,
                  ),

                  // sign in button
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: SignButton(
                      buttonName: "Sign in",
                      onPressed: () {
                        signIn(context);
                      },
                    ),
                  ),

                  //forget password and sign up buttons
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: CColors.primary),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()),
                              (route) => true);
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: CColors.greenGrad1),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
