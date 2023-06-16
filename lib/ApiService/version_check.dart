import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:opal_money/Model/ModelLocation.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import 'package:http/http.dart' as http;

import '../Utils/Global.dart';
import '../Utils/toast.dart';

class VersionApiService{
  static const String url = baseURL+"api/version-check";

  static Future versionApiCall(
      BuildContext context) async {
    try {
      var accessToken = Global.shared.accessToken;
      print("accessss==" + accessToken);


      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      final response =
      await http.get(Uri.parse(url),headers: headers).timeout(const Duration(seconds: 30));
      // print(response.body);
      if (response.statusCode == 200) {
        var responseJson= json.decode(response.body);
        print(responseJson);
        return responseJson;
      }
    } catch (e) {
      print("uuu+$e.toString()");
      showToast("Something went wrong",  );
      throw Exception('Failed to load post');
    }

  }
}