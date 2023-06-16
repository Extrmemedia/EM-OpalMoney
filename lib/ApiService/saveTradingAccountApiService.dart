import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:opal_money/Model/ModelSaveTradingAccount.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Utils/Global.dart';
import 'package:http/http.dart' as http;

import '../Utils/toast.dart';

class SaveTradingAccountApiService {
  static const String url = "${baseURL}api/save-trading-account";
  static Future  tradingFormApiCall(
    BuildContext context,
    String uid,
    String name,
    String mobile,
    String email,
    String dob,
    String age,
    String gender,
    String address,
    String name_mother,
    File pan,
    File adhaar,
    File photo,
    File checque,
    File sign,
    File bank_stmt,
  ) async {
    try {
      var accessToken = Global.shared.accessToken;
      print("accessss==" + accessToken);

      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
      };
      var formData = FormData.fromMap({
        'uid': uid,
        'name': name,
        'mobile': mobile,
        'email': email,
        'dob': dob,
        'age': age,
        'gender': gender,
        'address': address,
        'name_mother': name_mother,
        'pan': await MultipartFile.fromFile(
          pan.path,
        ),
        'adhaar': await MultipartFile.fromFile(
          adhaar.path,
        ),
        'photo': await MultipartFile.fromFile(
          photo.path,
        ),
        'checque': await MultipartFile.fromFile(
          checque.path,
        ),
        'sign': await MultipartFile.fromFile(
          sign.path,
        ),
        'bank_stmt': await MultipartFile.fromFile(
          bank_stmt.path,
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
        print('jiihihihihigugtdrtd${e.response}');
        print(' ${e.response.statusCode}');
      }
    }
  }
}
