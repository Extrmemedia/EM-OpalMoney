import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';

import '../Common/constants.dart';
import '../Utils/Global.dart';

class RegistrationFormApiService {
  static const String url = "${baseURL}api/partimemployee-registration";

  static Future registrationFormApiCall(
      BuildContext context,
      String uid,
      String name,
      String mobile,
      String email,
      String dob,
      String age,
      String gender,
      String occupation,
      String address,
      String usertype,
      String agentcode,
      File pan,
      File idproof,
      File photo,
      File resume) async {

    print("rjrjrjrjrj ${pan.path}  ${idproof.path}  ${photo.path}  ${resume.path}");

    try {
      var accessToken = Global.shared.accessToken;
      print("accessss==$accessToken");
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        "Accept":"application/json"
      };
      var formData = FormData.fromMap({
        'uid': uid,
        'name': name,
        'mobile': mobile,
        'email': email,
        'dob': dob,
        'age': age,
        'gender': gender,
        'occupation': occupation,
        'address': address,
        'usertype': usertype,
        'agentcode': agentcode,
        "pan": await MultipartFile.fromFile(
          pan.path,
        ),
        "idproof": await MultipartFile.fromFile(
          idproof.path,
        ),
        "photo": await MultipartFile.fromFile(
          photo.path,
        ),
        "resume": await MultipartFile.fromFile(
          resume.path,
        ),
      });
      Dio dio = Dio();

      final response = await dio.post(
        url,
         options: Options(
             headers: headers,),
        data: formData,

      );
      var responseJson = response.data;
      return responseJson;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response);
        print(e.response.statusCode);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }
}
