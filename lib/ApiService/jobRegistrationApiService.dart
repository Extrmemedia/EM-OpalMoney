import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:opal_money/Model/ModelJobRegistration.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Utils/Global.dart';
import 'package:http/http.dart' as http;

import '../Utils/toast.dart';

class JobRegistrationApiService{
  static const String url = "${baseURL}api/save-jobconsultancy";
  static Future jobFormApiCall({BuildContext context,
    String reg_type,
    String name,
    String mobile,
    String emailid,
    String dob,
    String gender,
    String height,
    String qualifiaction,
    String experience,
    String name_father,
    String occupation,
    String name_mother,
    String job_type,
    String job_cat,
    String job_location,
    String exp_salary,
    File photo,
    File resume
  }) async {
    try {
      print('reg type $reg_type');
      print('name $name');
      print('mobile $mobile');
      print('email $emailid');
      print('dob $dob');
      print('gender $gender');
      print('height $height');
      print('qualification $qualifiaction');
      print('experience $experience');
      print('father name $name_father');
      print('mother name $name_mother');
      print('occupation $occupation');
      print('job type $job_type');
      print('job cat $job_cat');
      print('job location $job_location');
      print('exp salary $exp_salary');
      print('resume ${resume.path}');
      print('photo ${photo.path}');
     // print(reg_type + gender + experience + job_type + job_cat  );
      var accessToken = Global.shared.accessToken;
      String uid = Global.shared.userId;
      print("accessss==$accessToken");
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
      };
      var formData = FormData.fromMap({
        'uid': uid,
        "reg_type":reg_type,
          "name":name,
          "mobile":mobile,
          "emailid":emailid,
          "dob":dob,
          "height":height,
          "gender":gender,
          "qualification":qualifiaction,
          "experience":experience,
          "name_father":name_father,
          "occupation":occupation,
          "name_mother":name_mother,
          "job_type": job_type,
          "job_cat":job_cat,
          "job_location":job_location,
          "exp_salary":exp_salary,
        "resume": await MultipartFile.fromFile(
          resume.path,
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

  }
}