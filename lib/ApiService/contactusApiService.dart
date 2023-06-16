import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Model/ModelContactus.dart';
import '../Model/ModelEnquiry.dart';
import 'package:http/http.dart' as http;

import '../Utils/Global.dart';
import '../Utils/toast.dart';


class ContactusFormApiService{
  static const String url = baseURL + "api/contactus";



  static Future<ModelContactus> ContactusFormApiCall(BuildContext context,
      String userid,String name, String mobile,String email, String message) async {
    try {
      var accessToken = Global.shared.accessToken;
      print("accessss==" + accessToken);

      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      Map<String, String> params = {
        'userid': userid,
        'name':name,
        'mobile':mobile,
        'email':email,
        'message':message,


      };

      final response =
      await http.post(Uri.parse(url), headers:headers,body: params).timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == 200) {
        print(ModelContactus.fromJson(json.decode(response.body)));
        return ModelContactus.fromJson(json.decode(response.body));

      }
      throw Exception('Failed to load post');
    } catch (e) {
      print("uuu+$e.toString()");
      showToast("Something went wrong",
         );
      throw Exception('Failed to load post');
    }
  }
}