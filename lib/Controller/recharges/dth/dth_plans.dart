import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../../../ApiService/recharge_api.dart';
import '../../../Common/constants.dart';
import '../../../Model/plans.dart';
import '../../../Utils/Connectivity.dart';
import '../../../Utils/toast.dart';

class DthPlans extends StatefulWidget {
  String op = '';
  String dth = '';

  DthPlans({Key key, this.dth, this.op}) : super(key: key);

  @override
  State<DthPlans> createState() => _DthPlansState();
}

class _DthPlansState extends State<DthPlans> {
  List<DthModel> dthData = [];

  @override
  void initState() {
    super.initState();
    plan(widget.op, widget.dth);
  }

  plan(String op, String dth) {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        RechargeApiService.dthApiCall(context, op, dth).then((res) {
          if (res['status'] == 'true') {
            Navigator.pop(context);

            setState(() {
              dthData = ((res ?? []) as List)
                  .map((li) => DthModel.fromJson(li))
                  .toList();
            });
          } else {
            showToast('${res['message']}', );


          }
        });
      } else {

        showToast("Please check your internet connection", );
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
          "Dth Plans",
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
      body: ListView.builder(
          itemCount: dthData.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
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
                          "Monthly Plan : ${dthData[index].monthlyPlan ?? ''}",
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
                          "Account Balance : ${dthData[index].accountBalance ?? ''}",
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
                          "Customer Name : ${dthData[index].customerName ?? ''}",
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
                          "Next Due : ${dthData[index].nextDue ?? ''}",
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
                          "Last Recharge Date : ${dthData[index].lastRechargeDate ?? ''}",
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
                          "Last Recharge : ${dthData[index].lastRecharge ?? ''}",
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
                          "Plan Details : ${dthData[index].planDetails ?? ''}",
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
    );
  }
}
