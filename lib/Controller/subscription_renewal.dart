import 'package:flutter/material.dart';
import 'package:opal_money/Controller/home_page_screen.dart';
import 'package:toast/toast.dart';

import '../ApiService/subscriptionRenewalApiService.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import 'about_us_screen.dart';
import 'payment_screen.dart';

class SubscriptionRenewel extends StatefulWidget {
  @override
  State<SubscriptionRenewel> createState() => _SubscriptionRenewelState();
}

class _SubscriptionRenewelState extends State<SubscriptionRenewel> {
  String _orderid = '';





  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xff4242432),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 10, bottom: 5, top: 150),
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
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'SORRY!',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Your Part-Time Employee / Agent \nAccount is Expired',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'If you want to continue',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            onPressed: () {
                             // subscriptionrenewelApiCall();

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
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Or',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'If you want to be a user please contactus\n 7356255173',
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
        ),
      ),
    );
  }
}
