import 'package:flutter/material.dart';
import 'package:opal_money/Common/constants.dart';
import 'package:opal_money/Utils/Global.dart';
//import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

import '../ApiService/loginApiService.dart';
import '../Model/ModelLogin.dart';
import '../Utils/AppConstants.dart';
import '../Utils/Connectivity.dart';
import '../Utils/PreferenceHelper.dart';
import '../Utils/toast.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // progressDialog;
  var mobileTextController = TextEditingController();

  bool isButtonPressed = false;
  bool isError = false;
   ModelLogin model;
  final GlobalKey<FormState> _formKey = GlobalKey();
  dynamic _mob = '';
  dynamic _phone ='';



   bool validateMobile(String value) {
      String pattern =r'^[6-9]\d{9}$';

      RegExp regExp = RegExp(pattern);
      if (value.isEmpty) {
        return false;
      }
      else if (!regExp.hasMatch(value)) {
        return false;
      }
      return true;


   }

  loginApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        print('hhhhhhhh');
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
    LoginApiService.loginApiCall(
        context, mobileTextController.text)
        .then((modelLogin) async {
      try {

        // showToast(modelLogin.message.toString(),
        //     gravity: Toast.bottom, duration: 2);
        model = modelLogin;

         // progressDialog.hide();
        if (modelLogin.status=="true") {
          print(mobileTextController.text);
          print(modelLogin.otp);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(AppConstants.phone,mobileTextController.text.toString());
          final String phone = prefs.getString(AppConstants.phone);
          print(phone);
          setState(() {
            _phone = phone;
            print(_phone);
            Global.shared.phone = _phone;

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return  OtpScreen(
                    otp: modelLogin.otp,
                    phone: modelLogin.contact,
                  );
                },
              ),
            );
          });
        }
       // await progressDialog.hide();
        showToast((modelLogin.message),
           );
      } catch (e) {
        //await progressDialog.hide();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

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
                    height: size.height * 0.4,
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
                          "assets/images/login_phone.png",
                          height: 114,
                          width: 64,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(
                          height: 45.0,
                        ),
                        const Text(
                          "Verify Your Mobile Number",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.normal,
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(top: size.height * 0.65, child: loginWidget())
            ],
          ),
        ),
      ),
    );
  }

  Widget loginWidget() {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Container(
        height: size.height * 0.5,
        width: size.width,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children:  [
                Container(
                  width: 35,
                  color: Colors.transparent,
                  child: TextFormField(
                    enabled: false,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      helperText: ' ',
                      hintText: "+91",
                      hintStyle: TextStyle(
                          fontSize: 16.0,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          color: themeColor
                      ),
                      contentPadding: EdgeInsets.all(0.0),
                      isDense: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color:themeColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: themeColor),
                      ),
                      disabledBorder:  UnderlineInputBorder(
                        borderSide: BorderSide(color: themeColor),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: themeColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "error";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Image.asset(
                      "assets/images/separator.png",height: 22,width: 5,),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Container(
                  width: 110,
                  color: Colors.transparent,
                  child: TextFormField(
                  maxLength: 10,
                    keyboardType: TextInputType.number,
                    expands: false,
                    maxLines: 1,
                    controller: mobileTextController,
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                        color: themeColor
                    ),

                    decoration:  const InputDecoration(
                      helperText: ' ',
                      counterText: '',
                      contentPadding: EdgeInsets.all(0.0),
                      isDense: true,
                       enabledBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color:themeColor),
                       ),
                       focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color:themeColor),
                       ),
                      border:  UnderlineInputBorder(
                        borderSide: BorderSide(color:themeColor),
                      ),
                      errorBorder:  UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                  ),
                    validator: (value) {
                      String pattern =r'^[6-9]\d{9}$';

                      RegExp regExp = RegExp(pattern);
                      if (value.isEmpty) {
                        return 'Please enter mobile number';
                      }
                      else if (!regExp.hasMatch(value)) {
                        return 'Please enter valid mobile number';
                      }
                      _mob = value;
                      return null;
                    },
                   onChanged: (value) {
                     setState(() {
                       _mob = value;
                       _formKey.currentState.validate();
                     });
                   },
                ),
                )
              ],
            ),

            Text(isError?"Enter valid number":""),

            SizedBox(height:size.height*0.1 ,),
            TextButton(
              onPressed: (){
                if(validateMobile(mobileTextController.text)) {
                  loginApiCall();
                }
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
                    "Send OTP",
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
          ],
        ),
      ),
    );
  }
}
