import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';

class ConnectivityCheck {
  static Future<bool> checkConnection() async {

    ConnectivityResult connectivityResult = await (new Connectivity().checkConnectivity());

    debugPrint(connectivityResult.toString());

    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)){
      return true;
    } else {
      return false;
    }
  }

  static void showAlert(BuildContext context, String text) {
    var alert = AlertDialog(
      content: Container(
        child: Row(
          children: <Widget>[Text(text)],
        ),
      ),
      actions: <Widget>[
         FlatButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.blue),
            ))
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }
}