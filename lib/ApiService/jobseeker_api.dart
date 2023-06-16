import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Utils/Global.dart';
import 'package:http/http.dart' as http;

import '../Utils/toast.dart';

class JobSeekerApiService {
  static const String url = "${baseURL}api/jobseeker-details-api";

  static Future jobseekerApiCall(BuildContext context) async {
    try {

      var accessToken = Global.shared.accessToken;
      print(accessToken);
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded',
      };



      final response =
      await http.get(Uri.parse(url),headers: headers).timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        return responseJson;
      }
    } catch (e) {
      print("uuu+$e.toString()");
      showToast("Something went wrong",
      );
    }
  }
}
