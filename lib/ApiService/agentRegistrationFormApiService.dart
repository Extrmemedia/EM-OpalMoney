import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../Common/constants.dart';
import '../Model/ModelAgentRegistration.dart';
import '../Utils/Global.dart';

class AgentRegistrationFormApiService{
  static const String url = "${baseURL}api/agent-registration";

  static Future agentregistrationFormApiCall(BuildContext context,
      String uid,
      String name,String mobile, String email,String dob,
      String age, String gender,  String occupation,String address,String usertype,
      String agentcode,File pan,
      File idproof,File photo) async {
    try {
      var accessToken = Global.shared.accessToken;
      print("accessss==$accessToken");
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
      });
      print(formData);
      Dio dio = Dio();
      final response = await dio.post(
        url,
        options: Options(
          headers: headers,),
       // options: RequestOptions(headers: headers, baseUrl: url),
        data: formData,
        onSendProgress: (received, total) {

        },
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
  }}


