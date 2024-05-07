import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void getToast({
  required String message,
  required Color bkgColor,
  required Color textColor,
}){
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT, // seconds for android.. // 5 seconds for LONG, 1 for SHORT
    gravity: ToastGravity.TOP,
// timeInSecForIosWeb: 1, // seconds for web
    backgroundColor: bkgColor,
    textColor: textColor,
    fontSize: 16.0,
  );
}


Widget appButton({required Function()? onTap, required String text}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}


Widget appTextField ({Widget? preIcon, required controller, required bool obscureText, required String hintText, required Function(dynamic value) onChange}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      fillColor: Colors.grey.shade200,
      filled: true,
      prefixIcon: preIcon,
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey[500]),),
      onChanged: onChange,
    ),
  );
}

Widget buildNoData({required String image, required String text})=>SingleChildScrollView(
  child: SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50,),
        Image.asset(image, fit: BoxFit.fill, width: 220,),
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 20),
          child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,),
        ),
        const SizedBox(height: 50,),
      ],
    ),
  ),
);

Widget buildText({required String text, required double fontSize, required int maxLines, required bool isBold}) {
  return Text(text, style: TextStyle(
      fontSize: fontSize,
      fontWeight: isBold ? FontWeight.bold : null
  ),
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textAlign: TextAlign.start,
  );
}
