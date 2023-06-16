import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:opal_money/Model/ModelMatrimony.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Utils/Global.dart';
import 'package:http/http.dart' as http;

import '../Utils/toast.dart';

class MatrimonyApiService {
  static const String url = "${baseURL}api/save-matrimony";

  static Future  matrimonyFormApiCall(BuildContext context,
      String uid,
      String name,
      String mobile,
      String emailid,
      String dob,
      String tob,
      String star,
      String religion,
      String gender,
      String height,
      String education,
      String job,
      String name_father,
      String occupation,
      String name_mother,
      String addr,
      String whatsapp,
      String work_address,
      File photo,
      File grihanila,) async {
    //   try {
    //     var accessToken = Global.shared.accessToken;
    //     print("accessss==" + accessToken);
    //
    //
    //     Map<String, String> headers = {
    //       'Authorization': 'Bearer $accessToken',
    //       'Content-Type': 'multipart/form-data; application/json; charset=UTF-8',
    //
    //     };
    //     var request = http.MultipartRequest('POST', Uri.parse(url));
    //     request.fields.addAll({
    //         "uid": uid,
    //         "name": name,
    //         "mobile": mobile,
    //         "emailid": emailid,
    //         "dob": dob,
    //         "tob": tob,
    //         "star": star,
    //         "religion": religion,
    //         "gender": gender,
    //         "height": height,
    //         "education": education,
    //         "job": job,
    //         "name_father": name_father,
    //         "occupation": occupation,
    //         "name_mother": name_mother,
    //         "addr": addr,
    //         "whatsapp": whatsapp,
    //         "work_address": work_address,
    //         "photo": photo,
    //         "grihanila": grihanila
    //     });
    //     if (photo != "") {
    //       request.files.add(await http.MultipartFile.fromPath('photo', photo));
    //     }
    //     if (grihanila != "") {
    //       request.files.add(await http.MultipartFile.fromPath('grihanila', grihanila));
    //     }
    //
    //
    //     request.headers.addAll(headers);
    //
    //
    //     http.Response response =
    //     await http.Response.fromStream(await request.send());
    //
    //     print(response.statusCode);
    //
    //
    //     if (response.statusCode == 302) {
    //       //print('response.headers:' + response.headers.toString());
    //       if (response.headers.containsKey("location")) {
    //         final getResponse = await http.get(Uri.parse(response.headers["location"]));
    //         print('getResponse.statusCode:' + getResponse.statusCode.toString());
    //         return ModelMatrimony(success: getResponse.statusCode == 200);
    //       }
    //     }else {
    //       if (response.statusCode == 200) {
    //         // print('response.data:' + response.body);
    //         print(ModelMatrimony.fromJson(json.decode(response.body)));
    //         return ModelMatrimony.fromJson(json.decode(response.body));
    //       }
    //       return ModelMatrimony(success: false);
    //     }
    //
    //
    //
    //
    //   } catch (e) {
    //     print("uuu+$e.toString()");
    //     showToast("something went wrong", );
    //   }
    // }


    try {
      var accessToken = Global.shared.accessToken;
      print("accessss==" + accessToken);

      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
      };
      var formData = FormData.fromMap({
        "uid": uid,
        "name": name,
        "mobile": mobile,
        "emailid": emailid,
        "dob": dob,
        "tob": tob,
        "star": star,
        "religion": religion,
        "gender": gender,
        "height": height,
        "education": education,
        "job": job,
        "name_father": name_father,
        "occupation": occupation,
        "name_mother": name_mother,
        "addr": addr,
        "whatsapp": whatsapp,
        "work_address": work_address,
        'photo': await MultipartFile.fromFile(
          photo.path,
        ),
        'grihanila': await MultipartFile.fromFile(
          grihanila.path,
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