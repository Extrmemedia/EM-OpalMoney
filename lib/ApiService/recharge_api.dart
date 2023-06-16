import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:opal_money/Utils/Global.dart';
import 'package:toast/toast.dart';

import 'package:http/http.dart' as http;

import '../Utils/toast.dart';

class RechargeApiService {
  static Future rechargeApiCall(BuildContext context, String opcode,
      String nmbr, String amt, String orderid) async {
    try {
      var accessToken = Global.shared.accessToken;

      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      Map<String, String> body = {
        'opcode': opcode,
        'number': nmbr,
        'amount': amt
      };
      final response = await http
          .post(Uri.parse(
                  //"https://myrc.in/v3/recharge/api?username=502792&token=24240ae7d4048439e3876752ca88bca9&opcode=$opcode&number=$nmbr&amount=$amt&orderid=$orderid&format=json"
                  'https://opalmoney.biz/app/api/myrc-recharge'),
              headers: headers, body: body)
          .timeout(const Duration(seconds: 30));
      print('recharge response    ${response.body}');
      var responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        return responseJson;
      }
    } catch (e) {
      print("uuu+$e.toString()");
      showToast(
        "Something went wrong",
      );
      throw Exception('Failed to load post');
    }
  }

  static Future balanceApiCall(BuildContext context) async {
    try {
      final response = await http
          .get(Uri.parse(
              "https://myrc.in/v3/recharge/balance?username=502792&token=24240ae7d4048439e3876752ca88bca9&format=json"))
          .timeout(const Duration(seconds: 30));
      print('balance response    ${response.body}');
      var responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        return responseJson;
      }
    } catch (e) {
      print("uuu+$e.toString()");
      showToast(
        "Something went wrong",
      );
      throw Exception('Failed to load post');
    }
  }

  static Future planApiCall(BuildContext context, String opcode) async {
    try {
      var accessToken = Global.shared.accessToken;

      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      Map<String, String> body = {'opcode': opcode};

      final response = await http
          .post(
              Uri.parse('https://opalmoney.biz/app/api/myrc-plan'
                  // "https://myrc.in/plan_api/mobile_normal_plan?username=502792&token=24240ae7d4048439e3876752ca88bca9&opcode=$opcode"
                  ),
              headers: headers,
              body: body)
          .timeout(const Duration(seconds: 30));
      print('plan response    ${response.body}');
      var responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        return responseJson;
      }
    } catch (e) {
      print("uuu+$e.toString()");
      showToast(
        "Something went wrong",
      );
      throw Exception('Failed to load post');
    }
  }

  static Future dthApiCall(
      BuildContext context, String opcode, String nmbr) async {
    try {
      final response = await http
          .get(Uri.parse(
              "https://myrc.in/plan_api/dth_info?username=502792&token=24240ae7d4048439e3876752ca88bca9&number=$nmbr&opcode=$opcode"))
          .timeout(const Duration(seconds: 30));
      print('dth response    ${response.body}');
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

  static Future rechargeXtraApiCall(BuildContext context, String opcode,
      String nmbr, String amt, String orderid, String dob) async {
    try {
      final response = await http
          .get(Uri.parse(
              "https://myrc.in/v3/recharge/api?username=502792&token=24240ae7d4048439e3876752ca88bca9&opcode=$opcode&number=$nmbr&amount=$amt&orderid=$orderid&Date of Birth=$dob&format=json"))
          .timeout(const Duration(seconds: 30));
      print('recharge response    ${response.body}');
      var responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        return responseJson;
      }
    } catch (e) {
      print("uuu+$e.toString()");
      showToast(
        "Something went wrong",
      );
      throw Exception('Failed to load post');
    }
  }
}
