import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void showToast(String msg) {
  Toast.show(msg,
      duration:1 , gravity: Toast.bottom);
}