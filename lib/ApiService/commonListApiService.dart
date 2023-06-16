import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import '../Common/constants.dart';
import '../Model/ModelCommonList.dart';
import '../Utils/Global.dart';
import '../Utils/toast.dart';

class CommonListApiService {
  static const String url = baseURL+"api/subcat-of-cat";

  static Future<ModelCommonList> commonListApiCall(
      BuildContext context, String catId) async {
    try {
      var accessToken = Global.shared.accessToken;
      print("accessss==" + accessToken);


      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      Map<String, String> params = {"cat_id": catId};

      final response =
      await http.post(Uri.parse(url), headers:headers,body: params).timeout(const Duration(seconds: 30));
       print(response.body);
      print("catId $catId");
      if (response.statusCode == 200) {
       // print(json.decode(response.body));
        return ModelCommonList.fromJson(json.decode(response.body));

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
