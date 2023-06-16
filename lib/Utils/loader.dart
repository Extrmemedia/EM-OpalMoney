import 'package:flutter/material.dart';
import 'package:opal_money/Common/constants.dart';

loader(BuildContext context ) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return  Center(
        child: Container(
          height: 20,
          width: 20,
          margin: const EdgeInsets.all(5),
          child: const CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor : AlwaysStoppedAnimation(themeColor),
          ),
        ),
      );
    },
  );
}