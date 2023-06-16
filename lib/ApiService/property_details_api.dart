import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import '../Common/constants.dart';
import '../Model/ModelLogin.dart';
import '../Utils/Global.dart';
import '../Utils/toast.dart';


class PropertyDetailsApiService {
  static const String url = baseURL + "api/property-details";
  static const String enquire_url = baseURL + "api/realestate-enquiry";


  static Future  propertydetailsApiCall(
      BuildContext context, String id) async {
    try {

      var accessToken = Global.shared.accessToken;
      print("accessss==" + accessToken);


      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      Map<String, String> params = {"propertyid": id};
          print(params);
      final response =
      await http.post(Uri.parse(url), body: params,headers: headers).timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        return responseJson;
      }
    } catch (e) {
      print("uuu+$e.toString()");
      showToast("Something went wrong",);
    }

  }


  static Future  enquireApiCall(
      BuildContext context, String id,String uid) async {
    try {
      var accessToken = Global.shared.accessToken;
      print("accessss==" + accessToken);


      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      var params = {"prpoertyid":id,"uid":uid};
      print(params);
      final response =
      await http.post(Uri.parse(enquire_url), body: params,headers: headers).timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        return responseJson;
      }
    } catch (e) {
      print("uuu+$e.toString()");
      showToast("Something went wrong",);
    }

  }


}


