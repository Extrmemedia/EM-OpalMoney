import 'dart:math';

import 'package:flutter/material.dart';
import 'package:opal_money/Common/constants.dart';
import 'package:opal_money/Utils/loader.dart';
import 'package:toast/toast.dart';

import '../../../ApiService/recharge_api.dart';
import '../../../Model/plans.dart';
import '../../../Model/providers.dart';
import '../../../Utils/Connectivity.dart';
import '../../../Utils/toast.dart';
import 'recharge_update.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({Key key}) : super(key: key);

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  var amtController = TextEditingController();
  List<Networks> networks = [];
  List<Plans> plans = [];
  String opName = 'Airtel';
  String opCode = 'A';
  String blnceAmt = '';
  @override
  void initState() {
    super.initState();
    //balance();
    plan(opCode);
    networks = [
      Networks(name: 'Airtel', code: 'A', service: 'Mobile'),
      Networks(name: 'Vodafone Idea (VI)', code: 'V', service: 'Mobile'),
      Networks(name: 'BSNL - TOPUP', code: 'BT', service: 'Mobile'),
      Networks(name: 'JIO', code: 'RC', service: 'Mobile'),
      Networks(name: 'V!', code: 'I', service: 'Mobile'),
      Networks(name: 'BSNL - STV	', code: 'BR', service: 'Mobile'),
      Networks(name: 'Airtel Postpaid', code: 'PAT', service: 'PostPaid'),
      Networks(name: 'Idea Postpaid', code: 'IP', service: 'PostPaid'),
      Networks(name: 'Vodafone Postpaid', code: 'VP', service: 'PostPaid'),
      Networks(name: 'Vodafone Landline', code: 'VLN', service: 'PostPaid'),
      Networks(name: 'BSNL Postpaid', code: 'BP', service: 'PostPaid'),
      Networks(name: 'Bsnl Landline', code: 'LBS', service: 'PostPaid'),
      Networks(name: 'Airtel Landline', code: 'LAT', service: 'PostPaid'),
      Networks(name: 'JIO Postpaid', code: 'JPP', service: 'PostPaid'),
    ];
  }



  balance() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        RechargeApiService.balanceApiCall(
          context,
        ).then((res) {
          if (res['status'] == 'Success') {
            setState(() {
              blnceAmt = res['balance'].toString();
            });
          } else {
            showToast('${res['status']}',
              );
          }
        });
      } else {
        showToast("Please check your internet connection",
           );

        return;
      }
    });
  }

  plan(String op) {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        RechargeApiService.planApiCall(context, op).then((res) {
          if (res['status'] == 'true') {
            setState(() {
              plans = ((res['data']["plans"] ?? []) as List)
                  .map((li) => Plans.fromJson(li))
                  .toList();
            });
          } else {
            showToast('${res['message']}',
              );
          }
        });
      } else {
        showToast("Please check your internet connection");
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
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
          "Recharge",
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
      body: Padding(
        padding:
            const EdgeInsets.only(top: 50.0, bottom: 20, left: 10, right: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                // Text(
                //   "Balance Amount : $blnceAmt",
                //   style: const TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.w400,
                //       fontSize: 16.0,
                //       fontFamily: "Poppins"),
                // ),
                // const SizedBox(
                //   height: 20.0,
                // ),
                Container(
                  height: 45,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: greyColor,
                    border: Border.all(
                      color: greyColor,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: DropdownButton(
                        hint: const Text("Select"),
                        isExpanded: true,
                        value: opName,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 12),
                        items: networks.map((n) {
                          return DropdownMenuItem(
                            value: n.name,
                            onTap: () {
                              opCode = n.code;
                            },
                            child: Text(n.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            opName = value.toString();
                            plan(opCode);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: plans.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RechargeUpdate(
                            amt: plans[index].amount.toStringAsFixed(0),
                            opCode: opCode,
                            plans: plans,
                            index: index,
                          );
                        }));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Amount : ${plans[index].amount ?? ''}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Roboto",
                                    fontSize: 11.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "Talktime : ${plans[index].talktime ?? ''}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Roboto",
                                    fontSize: 11.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "validity : ${plans[index].validity ?? ''}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Roboto",
                                    fontSize: 11.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "PlanName : ${plans[index].planName ?? ''}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Roboto",
                                    fontSize: 11.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "PlanDescription : ${plans[index].planDescription ?? ''}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Roboto",
                                    fontSize: 11.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                Text(
                                  "DataBenefit : ${plans[index].dataBenefit ?? ''}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Roboto",
                                    fontSize: 11.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
