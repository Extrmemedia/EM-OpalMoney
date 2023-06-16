import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../Common/constants.dart';
import '../Utils/Global.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ProfileUpdateApiService {
  static const String url = "${baseURL}api/profile-update";
  static const String imgurl = "${baseURL}api/profile-image-update";

  static Future profileApiCall(
      BuildContext context,
      String usertype,
      String  uid,
      String name,
      String mobile,
      String email,
      String  dob,
      String  age,
      String  gender,
      String   address,
      String occupation,
          File pan,
      File idproof,
      File photo,
      ) async {


    try {
      var accessToken = Global.shared.accessToken;
      print("accessss==$accessToken");
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
      };
      String genderID;


      // if (value['data'][0]['gender'] == 0) {
      //   _selectedGender = 'Male';
      // } else if (value['data'][0]['gender'] == 1) {
      //   _selectedGender = 'Female';
      // } else {
      //   _selectedGender = 'Others';
      // }
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
        "pancard": await MultipartFile.fromFile(
          pan.path,
        ),
        "idproof": await MultipartFile.fromFile(
          idproof.path,
        ),
        "photo": await MultipartFile.fromFile(
          photo.path,
        ),
      });
      print(formData.fields);
      Dio dio = Dio();
      final response = await dio.post(
        url,
        options:Options( headers: headers,method: 'POST'),
        data: formData,
        onSendProgress: (received, total) {
          // if (total != -1) {
          //   print('${(received / total * 100).toStringAsFixed(0)}%');
          // }
        },
      );
      var responseJson = response.data;
      print(responseJson);
      return  responseJson;
    } catch (e) {
      if (e is DioError) {
        print('jiihihihihigugtdrtd${e.response}');
        print(' ${e.response.statusCode}');

      }
    }





    // var accessToken = Global.shared.accessToken;
    // print("accessss==" + accessToken);
    // var request = http.MultipartRequest(
    //   "POST",
    //   Uri.parse(
    //     url,
    //   ),
    // );
    //
    //
    // Map<String, String> headers = {
    //   'Content-Type': 'multipart/form-data',
    //   'token': ''
    // };
    // request.headers['token'] = accessToken;
    // request.headers["Content-Type"] = 'multipart/form-data';
    // request.fields['uid'] = uid;
    //
    // request.fields['name'] = name;
    // request.fields['mobile'] = mobile;
    // request.fields['email'] = email;
    // request.fields['dob'] = dob;
    // request.fields['age'] = age;
    // request.fields['gender'] = gender;
    // request.fields['occupation'] = occupation;
    // request.fields['address'] = address;
    // request.fields['usertype'] = usertype;
    //
    // var panf = await http.MultipartFile.fromPath("pan", pan.path);
    // //add multipart to request
    // request.files.add(panf);
    // var prooff = await http.MultipartFile.fromPath("idproof", idproof.path);
    // //add multipart to request
    // request.files.add(prooff);
    // var picf = await http.MultipartFile.fromPath("photo",photo .path);
    // //add multipart to request
    // request.files.add(picf);
    // var response = await request.send();
    // //Get the response from the server
    // var responseData = await response.stream.toBytes();
    // var responseString = String.fromCharCodes(responseData);
    // print(responseString);
    }

















  static Future profileimgApiCall(
      File photo,
      ) async {

    try {
      var accessToken = Global.shared.accessToken;
      var userId =  Global.shared.userId;
      print("accessss==$accessToken");
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
      };
      var formData = FormData.fromMap({
        'userid':userId,
        "profileimage": await MultipartFile.fromFile(
          photo.path,
        ),

      });
     // print(json.encode(formData));
      Dio dio = Dio();
      final response = await dio.post(
        imgurl,
        options: Options( headers: headers,method: 'POST'),
        data: formData,
        onSendProgress: (received, total) {
          // if (total != -1) {
          //   print('${(received / total * 100).toStringAsFixed(0)}%');
          // }
        },
      );
      var responseJson = response.data;
      print(responseJson);
      return  responseJson;
    } catch (e) {
      if (e is DioError) {
        print('jiihihihihigugtdrtd ${e.response}');
        print(' ${e.response.statusCode}');

      }
    }









    // var accessToken = Global.shared.accessToken;
    // print("accessss==" + accessToken);
    // var request = http.MultipartRequest(
    //   "POST",
    //   Uri.parse(
    //     imgurl,
    //   ),
    // );
    //
    // var userId =  Global.shared.userId;
    //
    // Map<String, String> headers = {
    //   'Content-Type': 'multipart/form-data',
    //   'token': ''
    // };
    // request.headers['token'] = accessToken;
    // request.headers["Content-Type"] = 'multipart/form-data';
    // request.fields['userid'] = userId;
    //
    //
    //
    //
    // var picf = await http.MultipartFile.fromPath("profileimage",photo .path);
    // //add multipart to request
    // request.files.add(picf);
    // var response = await request.send();
    //
    // //Get the response from the server
    // var responseData = await response.stream.toBytes();
    // var responseString = String.fromCharCodes(responseData);
    // print(responseString);
    //





  }

    // try {
    // var accessToken = Global.shared.accessToken;
    // print("accessss==" + accessToken);
    //
    //
    //   Map<String, String> headers = {
    //     'Authorization': 'Bearer $accessToken',
    //     'Content-Type': 'multipart/form-data; application/json; charset=UTF-8',
    //   };
    //   var request = http.MultipartRequest('POST', Uri.parse(url));
    //   request.fields.addAll({
    //     'uid': uid,
    //     'name': name,
    //     'mobile': mobile,
    //     'email': email,
    //     'dob': dob,
    //     'age': age,
    //     'gender': gender,
    //     'occupation': occupation,
    //     'address': address,
    //     'usertype': usertype,
    //     // 'pan': pan,
    //     // 'idproof': idproof,
    //     // 'photo': photo,
    //   });
    //   if (pan != "") {
    //     request.files.add(await http.MultipartFile.fromPath('pan', pan));
    //   }
    //   if (idproof != "") {
    //     request.files.add(await http.MultipartFile.fromPath('idproof', idproof));
    //   }
    //   if (photo != "") {
    //     request.files.add(await http.MultipartFile.fromPath('photo', photo));
    //   }
    //   request.headers.addAll(headers);
    //   http.Response response =
    //       await http.Response.fromStream(await request.send());
    //   print("mmmmmmmmmmm"+json.encode(response.body));
    //   if (response.statusCode == 302) {
    //     // if (response.headers.containsKey("location")) {
    //     //   final getResponse = await http.get(response.headers["location"]);
    //     //   return ModelSaveAgentRegForm(success: getResponse.statusCode == 200);
    //     // }
    //     print("nnnnnnnnnn"+json.encode(response.body));
    //
    //   } else {
    //     if (response.statusCode == 200) {
    //       print('ddddddddd'+response.body);
    //     }
    //   }
    //   print('kkkkkkkk'+response.body);
  }

