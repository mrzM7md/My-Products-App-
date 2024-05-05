import 'dart:ui';

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
