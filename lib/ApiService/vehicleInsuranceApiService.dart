import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../Common/constants.dart';
import 'package:http/http.dart' as http;
import '../Utils/Global.dart';
import '../Utils/toast.dart';

class VehicleInsuranceApiService {
  static const String url = baseURL + "api/save-vehicle-insurance";

  static Future vehicleInsuranceApiCall({
    BuildContext context,
    String uid,
    String name,
    String mobile,
    String doreg,
    String dopurchase,
    String rtoozone,
    String purchase_city,
    String imposed_specialcond,
    String chasisno,
    String engno,
    String city,
    String branch,
    String additionalcover,
    String nonconention_fuel,
    String extension_required,
    String higher_deductable,
    String assoc_member,
    String anti_theft,
    String cover_legal_liab,
    String legal_liab_other,
    String pa_cover,
    String cng_lpg,
    File pan,
    File adhar,
    File photo,
    File rcbook,
    File insurance,
  }) async {
    try {
      var accessToken = Global.shared.accessToken;
      print("accessss==$accessToken");
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        "Accept": "application/json"
      };
      var formData = FormData.fromMap({
        // "uid": uid,
        // "name": name,
        // "mobile": mobile,
        // "doreg":doreg,
        // "dopurchase":dopurchase,
        // "rtoozone":rtoozone,
        // "purchase_city":purchase_city,
        // "imposed_specialcond":imposed_specialcond,
        // "chasisno":chasisno,
        // "engno":engno,
        // "city":city,
        // "branch":branch,
        // "additionalcover":additionalcover,
        // "nonconention_fuel":nonconention_fuel,
        // "extension_required":extension_required,
        // "higher_deductable":higher_deductable,
        // "assoc_member":assoc_member,
        // "anti_theft":anti_theft,
        // "cover_legal_liab":cover_legal_liab,
        // "legal_liab_other":legal_liab_other,
        // "pa_cover":pa_cover,
        // "cng_lpg":cng_lpg,

        "uid": uid,
        "name": name,
        "mobile": mobile,
        "date": "2023-02-04",
        "vehicle_type": "1",
        "policy_type": "1",
        "doreg": doreg,
        "dopurchase": dopurchase,
        "rtoozone": rtoozone,
        "purchase_city": purchase_city,
        "orgmember": "1",
        "policy_start": "2020-12-25",
        "regno": "rr1234",
        "color": "1",
        "imposed_specialcond": imposed_specialcond,
        "chasisno": chasisno.toString(),
        "engno": engno.toString(),
        "hypothtype": "1",
        "oicl": "1",
        "city": city,
        "branch": branch,
        "additionalcover": additionalcover,
        "nonconention_fuel": nonconention_fuel,
        "fuel_type": "1",
        "extension_required": extension_required,
        "country": '1',
        "higher_deductable": higher_deductable,
        "amount": "1",
        "assoc_member": assoc_member,
        "assoc_regno": "1",
        "anti_theft": anti_theft,
        "item_name": "item_name",
        "cost": "1000",
        "manufact_name": "Tata",
        "cover_legal_liab": cover_legal_liab,
        "noperson": "5",
        "legal_liab_other": legal_liab_other,
        "noemployee": "2",
        "pa_cover": pa_cover,
        "capital_sum": "10000",
        "cover_noperson": "2",
        "cng_lpg": cng_lpg,
        "cng_lpg_value": "cng value",
        "cng_lpg_desc": "Test data",
        "rto_registered": "1",
        "accessory_detail": "1",
        "accessory_value": "1000",
        "acc_desc": "Test daa",
        'pan': await MultipartFile.fromFile(
          pan.path,
        ),
        'adhar': await MultipartFile.fromFile(
          adhar.path,
        ),
        'photo': await MultipartFile.fromFile(
          adhar.path,
        ),
        'rcbook': await MultipartFile.fromFile(
          adhar.path,
        ),
        'insurance': await MultipartFile.fromFile(
          adhar.path,
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
//
//
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import '../Common/constants.dart';
// import '../Utils/Global.dart';
//
// class VehicleInsuranceApiService {
//   static const String url = "${baseURL}api/save-vehicle-insurance";
//
//   static Future vehicleInsuranceApiCall({
//     BuildContext context,
//     String uid,
//     String name,
//     String mobile,
//     String doreg,
//     String dopurchase,
//     String rtoozone,
//     String purchase_city,
//     String imposed_specialcond,
//     String chasisno,
//     String engno,
//     String city,
//     String branch,
//     String additionalcover,
//     String nonconention_fuel,
//     String extension_required,
//     String higher_deductable,
//     String assoc_member,
//     String anti_theft,
//     String cover_legal_liab,
//     String legal_liab_other,
//     String pa_cover,
//     String cng_lpg,
//     File pan,
//     File adhar,
//     File photo,
//     File rcbook,
//     File insurance,
//   }) async {
//       try {
//         print('pan ${pan.path}');
//         print('photo ${photo.path}');
//       var accessToken = Global.shared.accessToken;
//       print("accessss==" + accessToken);
//
//       Map<String, String> headers = {
//         'Authorization': 'Bearer $accessToken',
//       };
//       var formData = FormData.fromMap({
//         "uid": uid,
//         "name": name,
//         "mobile": mobile,
//         "date": "2023-02-04",
//         "vehicle_type": "1",
//         "policy_type": "1",
//         "doreg": doreg,
//         "dopurchase": dopurchase,
//         "rtoozone": rtoozone,
//         "purchase_city": purchase_city,
//         "orgmember": "1",
//         "policy_start": "2020-12-25",
//         "regno": "rr1234",
//         "color": "1",
//         "imposed_specialcond": imposed_specialcond,
//         "chasisno": chasisno.toString(),
//         "engno": engno.toString(),
//         "hypothtype": "1",
//         "oicl": "1",
//         "city": city,
//         "branch": branch,
//         "additionalcover": additionalcover,
//         "nonconention_fuel": nonconention_fuel,
//         "fuel_type": "1",
//         "extension_required": extension_required,
//         "country": '1',
//         "higher_deductable": higher_deductable,
//         "amount": "1",
//         "assoc_member": assoc_member,
//         "assoc_regno": "1",
//         "anti_theft": anti_theft,
//         "item_name": "item_name",
//         "cost": "1000",
//         "manufact_name": "Tata",
//         "cover_legal_liab": cover_legal_liab,
//         "noperson": "5",
//         "legal_liab_other": legal_liab_other,
//         "noemployee": "2",
//         "pa_cover": pa_cover,
//         "capital_sum": "10000",
//         "cover_noperson": "2",
//         "cng_lpg": cng_lpg,
//         "cng_lpg_value": "cng value",
//         "cng_lpg_desc": "Test data",
//         "rto_registered": "1",
//         "accessory_detail": "1",
//         "accessory_value": "1000",
//         "acc_desc": "Test daa",
//         'pan': await MultipartFile.fromFile(
//           pan.path,
//         ),
//         'adhar': await MultipartFile.fromFile(
//           adhar.path,
//         ),
//         'photo': await MultipartFile.fromFile(
//           adhar.path,
//         ),
//         'rcbook': await MultipartFile.fromFile(
//           adhar.path,
//         ),
//         'insurance': await MultipartFile.fromFile(
//           adhar.path,
//         ),
//
//       });
//       print(formData);
//       Dio dio = Dio();
//       final response = await dio.post(
//         url,
//         options: Options(
//           headers: headers,
//         ),
//         // options: RequestOptions(headers: headers, baseUrl: url),
//         data: formData,
//         onSendProgress: (received, total) {},
//       );
//       var responseJson = response.data;
//       print(responseJson);
//       return responseJson;
//     } catch (e) {
//       if (e is DioError) {
//         print('application data${e.response}');
//         print(' ${e.response.statusCode}');
//       }
//     }
//   }
// }
