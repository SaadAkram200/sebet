import 'package:flutter/material.dart';
import 'package:sebet/resuables.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Textfield Controller
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _phoneController = TextEditingController();
    TextEditingController _fnameController = TextEditingController();
    TextEditingController _lnameController = TextEditingController();

    return  Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 36, right: 36,),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
        
                //back button
                 BackButtonAndPageName(
                  onTap: () {
                  Navigator.pop(context); 
                 },),
        
                //logo and starting text
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: LogoAndText(
                    text1: "Hello,",
                    text2: "Signup to",
                    text3: "get started!",
                  ),
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
                          obscureText: false
                        ),
                      ),
                    ),
                  ],),
                //email textfield
                SebetTextfields(
                  controller: _emailController, 
                  fieldName: "Email", 
                  obscureText: false,
                ),
                //phone textfield
                SebetTextfields(
                  controller: _phoneController, 
                  fieldName: "Phone", 
                  obscureText: false,
                ),
                //password textfield
                SebetTextfields(
                  controller: _passwordController, 
                  fieldName: "Password", 
                  obscureText: true,
                ),
                //confirm pass textfield
                SebetTextfields(
                  controller: _emailController, 
                  fieldName: "Confirm Password", 
                  obscureText: true,
                ),
                
                // signup button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SignButton(
                    buttonName: "Sign Up", 
                    onPressed: (){}
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

