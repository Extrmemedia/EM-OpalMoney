import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:opal_money/Model/ModelPlanDetails.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Model/ModelMyWallet.dart';
import '../Utils/Global.dart';
import 'package:http/http.dart' as http;

import '../Utils/toast.dart';

class PartimeEmployIncentiveStructureApiService{

  static const String url = baseURL+"api/pt-incentive-structure";
  static Future partimeEmployIncentiveStructureApiCall(BuildContext context) async {
    try {
      var accessToken = Global.shared.accessToken;

      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      final response = await http
          .get(Uri.parse(url),headers: headers,).timeout(const Duration(seconds: 30));
      print('trading account details    ${response.body}');
      var responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        return responseJson;
      }
    } catch (e) {
      print("uuu+$e.toString()");
      showToast("Something went wrong");
      throw Exception('Failed to load post');
    }
  }
}


