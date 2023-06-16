import 'package:flutter/material.dart';
import 'package:opal_money/Controller/home_page_screen.dart';
import 'package:toast/toast.dart';

import '../ApiService/subscriptionRenewalApiService.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import '../Utils/toast.dart';

class AccountExpiredScreen extends StatefulWidget {
  @override
  State<AccountExpiredScreen> createState() => _AccountExpiredScreenState();
}

class _AccountExpiredScreenState extends State<AccountExpiredScreen> {
  String _status = '';


  subscriptionrenewelApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
       apiFunc();
      } else {
        showToast("Please check your internet connection",);

        return;
      }
    });
  }
  apiFunc() {

  SubscriptionRenewalApiService.subscriptionRenewal(context).then((result) async {
      try {
        setState(() {
          _status = result['status'].toString();
          print('dddd' + _status.toString());
        });

      } catch (e) {
        //await progressDialog.hide();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff4242432),
      body: Padding(
        padding: EdgeInsets.only(left: 30, right: 10, bottom: 5, top: 150),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          child: Container(
            height: 400,
            width: 300,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.asset(
                      "assets/images/expire.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'SORRY!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Your Part-Time Employee / Agent \nAccount is Expired',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'If you want to continue',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return subscriptionrenewelApiCall();
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Re-Register",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Or',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'If you want to be a user please contactus\n9956784310',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
