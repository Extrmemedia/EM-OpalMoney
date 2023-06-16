import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:opal_money/Utils/AppConstants.dart';
import 'package:toast/toast.dart';
import '../Common/constants.dart';
import '../Model/ModelLogin.dart';
import '../Utils/Global.dart';

class PaymentApiService {
  static const String url = baseURL + "api/razorpay-payment";

  static Future paymentApiCall(BuildContext context, String name,
      String orderid, String amount, String paymentid) async {
    print(url);

     try {

    var accessToken = Global.shared.accessToken;
    print(accessToken);
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var params = {
      'uid': Global.shared.id,
      'name': name,
      'orderid': orderid,
      'amount': amount,
      'paymentid': paymentid
    };
    print(params);
    final response = await http
        .post(Uri.parse(url), body: params, headers: headers)
        .timeout(const Duration(seconds: 30));
    print(response.body);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      return responseJson;
    }
    } catch (e) {
     print(e);
    }
  }

  static Future jobApiCall(BuildContext context, String id, String amount) async {
    print(url);

    try {

      var accessToken = Global.shared.accessToken;
      print(accessToken);
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      var params = {
        'amount': amount,
        'consultancyid':id
      };
      print(params);
      final response = await http
          .post(Uri.parse('${baseURL}api/jobseeker-payment'), body: params, headers: headers)
          .timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        return responseJson;
      }
    } catch (e) {
      print(e);
    }
  }


}
