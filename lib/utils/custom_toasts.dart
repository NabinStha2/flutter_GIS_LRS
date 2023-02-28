import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToasts {
  static void showToast({
    String? msg,
    String? color = "linear-gradient(to right, #34C759, #34C759)",
  }) {
    // Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msg.toString(),
        webBgColor: color,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
        timeInSecForIosWeb: 1,
        webPosition: "right",
        webShowClose: true,
        textColor: Colors.white,
        fontSize: 14.0);
  }
}

errorToast({String msg = "please fill the data"}) {
  CustomToasts.showToast(msg: msg, color: "linear-gradient(to right, #FF0000, #FF0000)");
}

successToast({String? msg}) {
  CustomToasts.showToast(msg: msg, color: "linear-gradient(to right, #34C759, #34C759)");
}
