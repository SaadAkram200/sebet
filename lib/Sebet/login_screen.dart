import 'package:flutter/material.dart';
import 'package:sebet/Sebet/signup_screen.dart';
import 'package:sebet/colors.dart';
import 'package:sebet/resuables.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Textfield Controller
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(left: 36, right: 36),
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
                  obscureText: false),

              //password text field
              SebetTextfields(
                  controller: _passwordController,
                  fieldName: "Password",
                  obscureText: true),

              // sign in button
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SignButton(
                  buttonName: "Sign in",
                  onPressed: () {},
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
    );
  }
}
