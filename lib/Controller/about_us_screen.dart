import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:opal_money/Common/constants.dart';
import 'package:opal_money/Controller/my_account.dart';

import '../ApiService/about_us_api.dart';
import '../Model/about_us_model.dart';
import '../Utils/Connectivity.dart';
import '../Utils/toast.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  List<AboutusModel> about = [];

  @override
  void initState() {
    super.initState();
    apiCall();
  }

  apiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        data();
      } else {
        showToast(
          "Please check your internet connection",
        );
        return;
      }
    });
  }

  data() {
    AboutUsApiService.aboutusApiCall(context).then((value) {
      if (value['status'] == '1') {
        setState(() {
          about = ((value["data"] ?? []) as List)
              .map((li) => AboutusModel.fromJson(li))
              .toList();
        });
      } else {
        showToast(
          value['message'],
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
        toolbarHeight: 90,
        centerTitle: true,
        elevation: 0,
        backgroundColor: themeColor,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 26,
              color: Colors.white70,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text(
          "About Us",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              fontFamily: "Poppins"),
        ),
        actions:  [
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container()

            // CircleAvatar(
            //   radius: 13.0,
            //   backgroundColor: themeColor,
            //   backgroundImage: AssetImage(
            //     "assets/images/profile_img.png",
            //   ),
            // ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0,left: 15.0,right: 15.0,bottom: 18.0),
          child: Html(
            data: about.isEmpty ? '' : about[0].details,
            defaultTextStyle: const TextStyle(
              color: Colors.white70,
              fontFamily: "Roboto",
              fontWeight: FontWeight.normal,
              fontSize: 14.0,
            ),
          ),
        ),
      ),
    );
  }
}
