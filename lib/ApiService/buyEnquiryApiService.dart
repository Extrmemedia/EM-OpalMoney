import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Model/ModelBuyingEnquiry.dart';
import '../Model/ModelSelling.dart';
import 'package:http/http.dart' as http;

import '../Utils/Global.dart';

class BuyingEnguiryApiService{
  static const String url = "${baseURL}api/realestate-buy-enquiry";

  static Future
 // <ModelBuyingEnquiry>

  buyingApiCall(BuildContext context,
      String uid, String type, String exp_rate, String district,String location,
      String description) async {
   // try {
      var accessToken = Global.shared.accessToken;
      print("accessss==" + accessToken);


      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      var params = {
        'uid': uid,
        'type': type,
        'exp_rate': exp_rate,
        'district': district,
        'location': location,
        'description': description,
      };
     print(params);
      final response =
      await http.post(Uri.parse(url), headers:headers,body: params).timeout(const Duration(seconds: 30));
      print(response.body);
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        return responseJson;

        // print(ModelBuyingEnquiry.fromJson(json.decode(response.body)));
        // return ModelBuyingEnquiry.fromJson(json.decode(response.body));

      }
    // } catch (e) {
    //   print("uuu+$e.toString()");
    //   Toast.show("Something went wrong", context,
    //       duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    // }
  }
}

