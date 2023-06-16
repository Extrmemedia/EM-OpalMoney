import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import 'package:http/http.dart' as http;

import '../Model/ModelOtp.dart';
import '../Utils/toast.dart';

class OtpApiService {
  static const String url = baseURL+"api/verify_otp";

  static Future<ModelOtp> otpApiCall(
      BuildContext context, String mobile ,String otp) async {
    try {
      Map<String, String> params = {
        "phno": mobile,
        "otp":otp,
      };
      final response =
      await http.post(Uri.parse(url), body: params).timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == 200) {
        return ModelOtp.fromJson(json.decode(response.body));
      }
      throw Exception('Failed to load post');
    } catch (e) {
      print("uuu+$e.toString()");
      showToast("Something went wrong",);
      throw Exception('Failed to load post');
    }

  }
}

