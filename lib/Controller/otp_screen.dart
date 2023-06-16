import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:opal_money/ApiService/otpApiService.dart';
import 'package:opal_money/Controller/home_page_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../ApiService/loginApiService.dart';
import '../Common/constants.dart';
import '../Model/ModelLogin.dart';
import '../Model/ModelOtp.dart';
import '../Utils/AppConstants.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import '../Utils/PreferenceHelper.dart';
import '../Utils/toast.dart';




class OtpScreen extends StatefulWidget {
   final String otp;
   final String phone;

  const OtpScreen({key, this.otp, this.phone}):super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  PreferenceHelper prefs = PreferenceHelper();
      ModelOtp model;
      ModelLogin modelLogin;
     String otpCode ="";
  @override
  // initState()  {
  //   showToast(widget.otp,
  //       gravity: Toast.BOTTOM, duration: 10);
  //   super.initState();
  // }




  Future<void> redirect() async {
    PreferenceHelper prefs = PreferenceHelper();
    bool isLoggedin =
    await prefs.getPreferenceBoolValue(AppConstants.isLoggedin);
    setState(() {
      if (isLoggedin) {
        //Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const HomePageScreen();
            },
          ),
        );
      }
    });
  }

  void setPreferenceValues(ModelOtp response) async {
    SharedPreferences logindata = await SharedPreferences.getInstance();
    setState(() {
      logindata.setBool('alreadyLogged', true);
      logindata.setString('accessToken', response.token);
      logindata.setString('userId', response.user.id.toString());
      logindata.setString('id', response.user.id.toString());

    });
  }


  otpApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();

        apiFunc();
      } else {
        showToast("Please check your internet connection",
          );

        return;
      }
    });
  }

  apiFunc() {

    OtpApiService.otpApiCall(
        context,widget.phone,otpCode)
        .then((modelOtp) async {
      try {

        model = modelOtp;
        if (modelOtp.status) {

          setState(()  {
            Global.shared.accessToken = modelOtp.token;

            print("AccessToken:${Global.shared.accessToken}");

            Global.shared.userId = modelOtp.user.id.toString();
            print("ID${Global.shared.userId}");
            Global.shared.id = modelOtp.user.id.toString();
            print("ID${Global.shared.id}");
          });

          setPreferenceValues(modelOtp);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return  const HomePageScreen();
              },
            ),
          );
        }
      } catch (e) {
        print(e);
        throw Exception('Failed');
      }
    });

  }


  loginApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        loginApiFunc();
      } else {
        showToast("Please check your internet connection",
           );

        return;
      }
    });
  }

  loginApiFunc() {
    LoginApiService.loginApiCall(
        context, widget.phone)
        .then((model) async {
      try {
        modelLogin = model;

        // progressDialog.hide();
        if (model.status=="true") {
          showToast(modelLogin.otp.toString(),
            );
          print(model.otp);


        }
        // await progressDialog.hide();
        //showToast((model.message), gravity: Toast.BOTTOM, duration: 2);
      } catch (e) {
        //await progressDialog.hide();
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themeColor,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: SizedBox(
                  height: size.height * 0.5,
                  width: size.width,
                  child: Image.asset(
                    "assets/images/bg_onboard.png",
                    height: size.height * 0.5,
                    width: size.width,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: size.height*0.1,
                child: Container(
                  width: size.width,
                  color: themeColor,
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/otp_phone.png",
                          height: 114,
                          width: 110,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(
                          height: 45.0,
                        ),
                        const Text(
                          "Enter OTP",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.normal,
                              fontSize: 18.0
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(top: size.height * 0.6, child: otpBgWidget())
            ],
          ),
        ),
      ),
    );
  }

  Widget otpBgWidget() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.5,
      width: size.width,
      color: Colors.white,
      child: Column(
        children: [


          OtpTextField(
            enabledBorderColor: const Color(0xFFE0E0E0),
            numberOfFields: 4,
            textStyle: const TextStyle( color:themeColor,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                fontSize: 16.0),
            borderColor:  const Color(0xFFE0E0E0),
            fieldWidth: 40.0,
            focusedBorderColor:  const Color(0xFFE0E0E0),
            showFieldAsBox: true,
            borderRadius: BorderRadius.circular(10),

            onCodeChanged: (String code) {

            },
            onSubmit: (String verificationCode){
              otpCode = verificationCode;

            }, // end onSubmit
          ),
          const SizedBox(height:30 ,),
          GestureDetector(
            onTap: (){
              loginApiCall();
            },
            child: const Text(
              "Resend OTP",
              style: TextStyle(
                  color:themeColor,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0
              ),
            ),
          ),
           SizedBox(height:size.height*0.075 ,),
          TextButton(
            onPressed: (){
              otpApiCall();

            },
            child: Container(
              height: 45,
              width: size.width*0.7,
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(45),
              ),
              child: const Center(
                child: Text(
                  "Verify",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto",
                    color: Colors.white,
                    fontSize: 16,
                  ),

                ),
              ),
            ),
          ),
          const SizedBox(height: 50,),
        ],
      ),
    );
  }
}
