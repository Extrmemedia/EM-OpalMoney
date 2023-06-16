import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:opal_money/Model/ModelOccupation.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Model/ModelJobCategory.dart';
import '../Utils/Global.dart';
import 'package:http/http.dart' as http;

import '../Utils/toast.dart';


class JobCategoryApiService{
  static const String url = baseURL+"api/job-types";

  static Future<ModelJobCategory> JobCategoryApiCall(
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
        print(response);
        return ModelJobCategory.fromJson(json.decode(response.body));
      }
      throw Exception('Failed to load post');
    } catch (e) {
      print("uuu+$e.toString()");
      showToast("Something went wrong",);
      throw Exception('Failed to load post');
    }

  }
}