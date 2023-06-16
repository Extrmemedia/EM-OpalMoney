import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:opal_money/Model/ModelDeleteRealEstate.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Utils/Global.dart';
import 'package:http/http.dart' as http;

import '../Utils/toast.dart';


class DeleteRealEstateApiService{


  static const String url = "${baseURL}api/delete-real-estate";

  static Future<ModelDeleteRealEstate> deleteRealEstateApiCall(
      BuildContext context, String id) async {
    try {
      var accessToken = Global.shared.accessToken;
      print("accessss==" + accessToken);


      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      Map<String, String> params = {"id": id};

      final response =
      await http.post(Uri.parse(url), headers:headers,body: params).timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == 200) {
        print(ModelDeleteRealEstate.fromJson(json.decode(response.body)));
        return ModelDeleteRealEstate.fromJson(json.decode(response.body));

      }
      throw Exception('Failed to load post');
    } catch (e) {
      print("uuu+$e.toString()");
      showToast("Something went wrong",);
      throw Exception('Failed to load post');
    }

  }
}