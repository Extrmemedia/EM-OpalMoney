import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../Common/constants.dart';
import '../Utils/Global.dart';
import '../Utils/toast.dart';


class CheckregisteredUserApiService {
  static const String url = "${baseURL}api/agent-check";
  static const String consultancy ='${baseURL}api/consultancy-check';

  static Future userReistrationApiCall(
      BuildContext context, String userid) async {
    print(url);

    try {

      var accessToken = Global.shared.accessToken;
       print(accessToken);
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded',
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
      showToast("Something went wrong",
         );
    }

  }



  static Future consultancyApiCall(
      BuildContext context, String userid) async {
    print(consultancy);
    try {
      var accessToken = Global.shared.accessToken;
      print(accessToken);
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      Map<String, String> params = {"userid":Global.shared.userId};
      final response =
      await http.post(Uri.parse(consultancy), body: params,headers: headers).timeout(const Duration(seconds: 30));
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


