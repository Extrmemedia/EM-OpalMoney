import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:opal_money/Model/ModelSaveApplication.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Utils/Global.dart';
import 'package:http/http.dart' as http;

import '../Utils/toast.dart';

class LifeInsuranceApplicationFormApiService {
  static const String url = "${baseURL}api/saveusers-application";

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
      String gender,
      String address,
      String occupation,
      String description,
      String nominee_name,
      String nominee_dob,
      String nominee_age,
      String relationship,
      File pan,
      File id_image,
      File photo,
      File sign) async {
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
        'subcat_id': subcat_id,
        'plan_id': plan_id,
        'name': name,
        'mobile': mobile,
        'email': email,
        'dob': dob,
        'age': age,
        'gender': gender,
        'address': address,
        'occupation': occupation,
        'description': description,
        'nominee_name': nominee_name,
        'nominee_dob': nominee_dob,
        'nominee_age': nominee_age,
        'relationship': relationship,
        'pan': await MultipartFile.fromFile(
          pan.path,
        ),
        'id_image': await MultipartFile.fromFile(
          id_image.path,
        ),
        'photo': await MultipartFile.fromFile(
          photo.path,
        ),
        'sign': await MultipartFile.fromFile(
          sign.path,
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
    //       'uid': uid,
    //       'cat_id': cat_id,
    //       'subcat_id': subcat_id,
    //       'plan_id': plan_id,
    //       'name': name,
    //       'mobile': mobile,
    //       'email': email,
    //       'dob': dob,
    //       'age': age,
    //       'gender':gender,
    //       'address':address,
    //       'occupation':occupation,
    //       'description':description,
    //       'nominee_name':nominee_name,
    //       'nominee_dob':nominee_dob,
    //       'nominee_age':nominee_age,
    //       'relationship':relationship,
    //       'pan':pan,
    //       'id_image':id_image,
    //       'photo':photo,
    //       'sign':sign
    //     });
    //     if (pan != "") {
    //       request.files.add(await http.MultipartFile.fromPath('pan', pan));
    //     }
    //     if (id_image != "") {
    //       request.files.add(await http.MultipartFile.fromPath('id_image', id_image));
    //     }
    //     if (photo != "") {
    //       request.files.add(await http.MultipartFile.fromPath('photo', photo));
    //     }
    //     if (sign != "") {
    //       request.files.add(await http.MultipartFile.fromPath('sign', sign));
    //     }
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
    //         return ModelSaveApplication(success: getResponse.statusCode == 200);
    //       }
    //     }else {
    //       if (response.statusCode == 200) {
    //         // print('response.data:' + response.body);
    //         print(ModelSaveApplication.fromJson(json.decode(response.body)));
    //         return ModelSaveApplication.fromJson(json.decode(response.body));
    //       }
    //       return ModelSaveApplication(success: false);
    //     }
    //
    //
    //     // if (response.statusCode == 200) {
    //     //
    //     //   return ModelSelling.fromJson(json.decode(response.body));
    //     //   // final result = jsonDecode(response.body) as Map<String, dynamic>;
    //     //   // return ModelSelling.fromJson(result);
    //     // }
    //     // else {
    //     //   print(response.reasonPhrase);
    //     // }
    //
    //
    //
    //   } catch (e) {
    //     print("uuu+$e.toString()");
    //     showToast("something went wrong" );
    //   }
  }
}
