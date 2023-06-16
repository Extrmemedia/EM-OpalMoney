import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import '../Common/constants.dart';
import '../Model/ModelLogin.dart';
import '../Utils/toast.dart';


class LoginApiService {
  static const String url = baseURL + "api/logout";

  static Future<ModelLogin> loginApiCall(
      BuildContext context, String mobile) async {
    try {
      Map<String, String> params = {"phno": mobile};
      final response =
      await http.post(Uri.parse(url), body: params).timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == 200) {
        return ModelLogin.fromJson(json.decode(response.body));
      }
      throw Exception('Failed to load post');
    } catch (e) {
      print("uuu+$e.toString()");
      showToast("Something went wrong",);
      throw Exception('Failed to load post');
    }

  }
}
