import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:opal_money/Controller/home_page_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/Common/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/Global.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String token;
  String userId;

  SharedPreferences logindata;
  bool alreadyLogged = false;

  @override
  void initState() {

    checkIfAlreadyLogin();
    super.initState();
  }
  Future<void> checkIfAlreadyLogin() async {

    logindata = await SharedPreferences.getInstance();
    setState(() {
      alreadyLogged = (logindata.getBool('alreadyLogged') ?? false);
      Global.shared.accessToken = logindata.getString('accessToken') ?? "";
      Global.shared.userId = logindata.getString("userId")??"";
      Global.shared.id = logindata.getString("id")??"";
    });

    print(alreadyLogged);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      body: Center(
        child: AnimatedSplashScreen(
            duration: 1000,
            splash: splashWidget(),
            nextScreen:alreadyLogged==true? HomePageScreen():LoginScreen(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.rightToLeft,
            backgroundColor: themeColor),
      ),
    );
  }

  Widget splashWidget() {
    Size size = MediaQuery.of(context).size;
    return Image.asset("assets/images/logo_trans.png",height: 200,width: size.width*0.8,fit: BoxFit.cover,);

    }

}
