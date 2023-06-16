import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:opal_money/Model/ModelPlanList.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Utils/Global.dart';
import 'package:http/http.dart' as http;

import '../Utils/toast.dart';

class PlanListApiService{
  static const String url = "${baseURL}api/plans-of-subcat";

  static Future<ModelPlanList> planListApiCall(
      BuildContext context, String catId) async {
    try {
      var accessToken = Global.shared.accessToken;
      print("accessss==$accessToken");

      print('cat id for listing $catId');
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      Map<String, String> params = {"subcat_id": catId};

      final response =
      await http.post(Uri.parse(url), headers:headers,body: params).timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return ModelPlanList.fromJson(json.decode(response.body));

      }
      throw Exception('Failed to load post');
    } catch (e) {
      print("uuu+$e.toString()");
      showToast("Something went wrong",);
      throw Exception('Failed to load post');
    }

  }
}