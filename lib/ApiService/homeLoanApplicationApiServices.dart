import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../Common/constants.dart';
import '../Utils/Global.dart';

class HomeLoanApplicationFormApiService {
  static const String url = "${baseURL}api/home-loan-application";

  static Future applicationFormApiCall(
      BuildContext context,
      String uid,
      String cat_id,
      String subcat_id,
      String plan_id,
      String name,
      String mobile,
      String email,
      String dob,
      String age,
      String address,
      String occupation,
      String description,
      File pan,
      File adhar,
     ) async {
    print('cat id $cat_id subcat_id $subcat_id plan_id $plan_id');

    try {
      var accessToken = Global.shared.accessToken;
      print("accessss==" + accessToken);

      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
      };
      var formData = FormData.fromMap({
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
        'pan': await MultipartFile.fromFile(
          pan.path,
        ),
        'adhar': await MultipartFile.fromFile(
          adhar.path,
        ),

      });
      print(formData);
      Dio dio = Dio();
      final response = await dio.post(
        url,
        options: Options(
          headers: headers,
        ),
        // options: RequestOptions(headers: headers, baseUrl: url),
        data: formData,
        onSendProgress: (received, total) {},
      );
      var responseJson = response.data;
      print(responseJson);
      return responseJson;
    } catch (e) {
      if (e is DioError) {
        print('application data${e.response}');
        print(' ${e.response.statusCode}');
      }
    }
  }
}
