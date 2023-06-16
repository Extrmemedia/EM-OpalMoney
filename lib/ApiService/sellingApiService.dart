import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Model/ModelSelling.dart';
import 'package:http/http.dart' as http;

import '../Utils/Global.dart';
import '../Utils/toast.dart';

class SellingApiService{
  static const String url = "${baseURL}api/save-real-estate";

  static Future  sellingApiCall(BuildContext context,
      String uid, String type, String expected_rate, String rate_type,
      String area_type,String area_measure, String district,String location,
      String description, File image1, File image2, File image3,
      File image4) async {




    try {
      var accessToken = Global.shared.accessToken;
      print("accessss==" + accessToken);

      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
      };
      var formData = FormData.fromMap({
        'uid': uid,
            'type': type,
            'expected_rate': expected_rate,
            'rate_type': rate_type,
            'area_type': area_type,
            'area_messure': area_measure,
            'district': district,
            'location': location,
            'description': description,
        'image_1': await MultipartFile.fromFile(
          image1.path,
        ),
        'image_2': await MultipartFile.fromFile(
          image2.path,
        ),
        'image_3': await MultipartFile.fromFile(
          image3.path,
        ),
        'image_4': await MultipartFile.fromFile(
          image4.path,
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

    // try {
    //   var accessToken = Global.shared.accessToken;
    //   print("accessss==" + accessToken);
    //
    //
    //   Map<String, String> headers = {
    //     'Authorization': 'Bearer $accessToken',
    //     //'Content-Type':'multipart/form-data',
    //     'Content-Type': 'multipart/form-data; application/json; charset=UTF-8',
    //
    //   };
    //   var request = http.MultipartRequest('POST', Uri.parse(url));
    //   request.fields.addAll({
    //     'uid': uid,
    //     'type': type,
    //     'expected_rate': expected_rate,
    //     'rate_type': rate_type,
    //     'area_type': area_type,
    //     'area_messure': area_measure,
    //     'district': district,
    //     'location': location,
    //     'description': description,
    //   });
    //   if (image1 != "") {
    //     request.files.add(await http.MultipartFile.fromPath('image_1', image1));
    //   }
    //   if (image2 != "") {
    //     request.files.add(await http.MultipartFile.fromPath('image_2', image2));
    //   }
    //   if (image3 != "") {
    //     request.files.add(await http.MultipartFile.fromPath('image_3', image3));
    //   }
    //   if (image4 != "") {
    //     request.files.add(await http.MultipartFile.fromPath('image_4', image4));
    //   }
    //
    //   request.headers.addAll(headers);
    //
    //
    //   http.Response response =
    //   await http.Response.fromStream(await request.send());
    //
    //   print(response.statusCode);
    //
    //
    //   if (response.statusCode == 302) {
    //     //print('response.headers:' + response.headers.toString());
    //     if (response.headers.containsKey("location")) {
    //       final getResponse = await http.get(Uri.parse(response.headers["location"]));
    //       print('getResponse.statusCode:' + getResponse.statusCode.toString());
    //       return ModelSelling(success: getResponse.statusCode == 200);
    //     }
    //   }else {
    //     if (response.statusCode == 200) {
    //       // print('response.data:' + response.body);
    //       print(ModelSelling.fromJson(json.decode(response.body)));
    //       return ModelSelling.fromJson(json.decode(response.body));
    //     }
    //     return ModelSelling(success: false);
    //   }
    //
    //
    //   // if (response.statusCode == 200) {
    //   //
    //   //   return ModelSelling.fromJson(json.decode(response.body));
    //   //   // final result = jsonDecode(response.body) as Map<String, dynamic>;
    //   //   // return ModelSelling.fromJson(result);
    //   // }
    //   // else {
    //   //   print(response.reasonPhrase);
    //   // }
    //
    //
    //
    // } catch (e) {
    //   print("uuu+$e.toString()");
    //   showToast("something went wrong",);
    // }
  }
}