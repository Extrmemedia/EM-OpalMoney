import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Model/ModelEnquiry.dart';
import 'package:http/http.dart' as http;

import '../Utils/Global.dart';
import '../Utils/toast.dart';


class EnquiryApiService{
  static const String url = baseURL + "api/save-enquiry";



  static Future<ModelEnquiry> EnquiryApiCall(BuildContext context,
      String uid, String cat_id, String subcat_id,
      String plan_id,String name, String mobile,String email,
      String dob, String age, String address, String occupation,
      String description) async {
    try {
      var accessToken = Global.shared.accessToken;
      print("accessss==" + accessToken);

      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      Map<String, String> params = {
        'uid': uid,
        'cat_id': cat_id,
        'subcat_id':subcat_id,
        'plan_id':plan_id,
        'name':name,
        'mobile':mobile,
        'email':email,
        'dob':dob,
        'age':age,
        'address':address,
        'occupation':occupation,
        'description':description,
      };

      final response =
      await http.post(Uri.parse(url), headers:headers,body: params).timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == 200) {
        print(ModelEnquiry.fromJson(json.decode(response.body)));
        return ModelEnquiry.fromJson(json.decode(response.body));

      }
      throw Exception('Failed to load post');
    } catch (e) {
      print("uuu+$e.toString()");
      showToast("Something went wrong",);
      throw Exception('Failed to load post');
    }
  }
}