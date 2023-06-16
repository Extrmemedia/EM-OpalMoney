import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Utils/Global.dart';
import 'package:http/http.dart' as http;

import '../Utils/toast.dart';


class ReferenceOverviewApiService{


  static const String url = "${baseURL}api/refferance-overview";

  static Future  referenceOverviewApiCall(BuildContext context) async {
    try {
      var accessToken = Global.shared.accessToken;
      var userId =  Global.shared.userId;
      print("accessss==$accessToken");


      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      Map<String, String> params = {"userid": userId};

      final response =
      await http.post(Uri.parse(url), headers:headers,body: params).timeout(const Duration(seconds: 30));
      print('refernce    ${response.body}');
      var responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
       return  responseJson;

      }
    } catch (e) {
      print("uuu+$e.toString()");
      showToast("Something went wrong",);
      throw Exception('Failed to load post');
    }

  }
}