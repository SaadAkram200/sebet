import 'package:flutter/material.dart';
import 'colors.dart';

//textfield
class SebetTextfields extends StatelessWidget {
  final TextEditingController controller;
  final String fieldName;
  final bool obscureText;
  final int maxLines;
  const SebetTextfields(
      {super.key,
      required this.controller,
      required this.fieldName,
      this.obscureText = false,  this.maxLines=1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        maxLines: maxLines,
        minLines: maxLines,
        keyboardType: TextInputType.multiline,
        obscureText: obscureText,
        controller: controller,
        cursorColor: Colors.grey,
        style: const TextStyle(
          color: Colors.grey,
        ),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 20,top: 20,),
            filled: true,
            fillColor: CColors.textfieldColor,
            hintText: fieldName,
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: CColors.textfieldColor)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: CColors.textfieldColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: CColors.textfieldColor),
                borderRadius: const BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}

//Logo and Texts

class LogoAndText extends StatelessWidget {
  final String text1, text2, text3;
  const LogoAndText(
      {super.key,
      required this.text1,
      required this.text2,
      required this.text3});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Image.asset(
              "assets/images/sebetlogo.png",
              width: 100,
            ),
          ),

          //Hello text
          Text(
            text1,
            style: TextStyle(
                color: CColors.primary,
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
          Text(
            text2,
            style: const TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              text3,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ]);
  }
}

// ignore: must_be_immutable
class SignButton extends StatelessWidget {
  final String buttonName;
  void Function()? onPressed;
  SignButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [CColors.greenGrad1, CColors.greenGrad2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
      child: ElevatedButton(
          style: const ButtonStyle(
              shadowColor: MaterialStatePropertyAll(Colors.transparent),
              backgroundColor: MaterialStatePropertyAll(Colors.transparent),
              minimumSize: MaterialStatePropertyAll(Size(double.infinity, 45))),
          onPressed: onPressed,
          child: Text(
            buttonName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          )),
    );
  }
}

//back button and page name
// ignore: must_be_immutable
class BackButtonAndPageName extends StatelessWidget {
  void Function()? onTap;
   BackButtonAndPageName({
    super.key,
    required this.onTap,

  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                CColors.redGrad1,
                CColors.redGrad2,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          width: 40,
          height: 40,
          child: const Center(
              child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          )
          )
        ),
    );
  }
}
