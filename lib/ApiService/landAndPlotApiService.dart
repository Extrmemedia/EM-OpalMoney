import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:opal_money/Model/ModelLandAndPlots.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Utils/Global.dart';
import 'package:http/http.dart' as http;

import '../Utils/toast.dart';

class LandAndPlotApiService{

  static const String url = baseURL+"api/list-properties";

  static Future<ModelLandAndPlots> landAndPlotListApiCall(
      BuildContext context,String propertyType) async {
    try {
      var accessToken = Global.shared.accessToken;
      print("accessss==" + accessToken);


      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      Map<String, String> params = {

        "property_type" : propertyType
      };

      final response =
      await http.post(Uri.parse(url), headers:headers,body: params).timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == 200) {
        print(ModelLandAndPlots.fromJson(json.decode(response.body)));
        return ModelLandAndPlots.fromJson(json.decode(response.body));

      }
      throw Exception('Failed to load post');
    } catch (e) {
      print("uuu+$e.toString()");
      showToast("Something went wrong",   );
      throw Exception('Failed to load post');
    }

  }
}