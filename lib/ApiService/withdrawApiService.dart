import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:opal_money/Model/ModelDeleteRealEstate.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Utils/Global.dart';
import 'package:http/http.dart' as http;

import '../Utils/toast.dart';


class WithdrawApiService{


  static const String url = "${baseURL}api/wallet-withdraw";

  static Future withdrawApiCall(
      BuildContext context, String id) async {
    try {
      var accessToken = Global.shared.accessToken;
      print("accessss==" + accessToken);


      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      Map<String, String> params = {"userid":Global.shared.userId};

      final response =
      await http.post(Uri.parse(url), body: params,headers: headers).timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        return responseJson;
      }
    } catch (e) {
      print("uuu+$e.toString()");
      showToast("Something went wrong",   );
    }

  }
}

