import 'dart:math';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../../../ApiService/recharge_api.dart';
import '../../../Common/constants.dart';
import '../../../Model/plans.dart';
import '../../../Utils/Connectivity.dart';
import '../../../Utils/loader.dart';
import '../../../Utils/toast.dart';





class RechargeUpdate extends StatefulWidget {

  String opCode='';
  String amt='';
  List<Plans> plans = [];
  int index;

   RechargeUpdate({Key key,this.opCode,this.amt,this.plans,this.index}) : super(key: key);

  @override
  State<RechargeUpdate> createState() => _RechargeUpdateState();
}

class _RechargeUpdateState extends State<RechargeUpdate> {

var code;
  void initState() {
    super.initState();
    var rng = Random();
    code = rng.nextInt(90000) + 10000;
    print('hhhhhhhhh$code');

  }




  var mobController = TextEditingController();


  apiCall() {
    print(widget.amt);
    RechargeApiService.rechargeApiCall(
        context,
        widget.opCode,
        mobController.text.toString(),
           widget.amt,
        code.toString())
        .then((res) {
      if (res['status'] == 'Success') {
        Navigator.pop(context);
        showToast('${res['status']}');
        Navigator.pop(context);
        Navigator.pop(context);

      } else {
        Navigator.pop(context);
        showToast('${res['message']},${res['opid']}');
      }
    });
  }

  connectionCheck() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        apiCall();
      } else {
        showToast("Please check your internet connection",);

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

          children: [
            Container(
              width: double.infinity,
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
                          "Amount : ${widget.plans[widget.index].amount ?? ''}",
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
                          "Talktime : ${widget.plans[widget.index].talktime ?? ''}",
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
                          "validity : ${widget.plans[widget.index].validity ?? ''}",
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
                          "PlanName : ${widget.plans[widget.index].planName ?? ''}",
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
                          "PlanDescription : ${widget.plans[widget.index].planDescription ?? ''}",
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
                          "DataBenefit : ${widget.plans[widget.index].dataBenefit ?? ''}",
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
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 45,
              child: TextFormField(
                  controller: mobController,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300),
                  decoration: InputDecoration(
                    hintText: "Mobile Number",
                    hintStyle: const TextStyle(
                        fontFamily: "Roboto",
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300),
                    fillColor: greyColor,
                    filled: true,
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 10),
            ),


            const SizedBox(
              height: 20.0,
            ),
            TextButton(
              onPressed: () {
                if (mobController.text.isEmpty ||
                    mobController.text.length < 10) {
                  showToast('provide a valid mobile number');
                } else {
                  loader(context);
                  connectionCheck();
                }
              },
              child: Container(
                height: 45,
                width: size.width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: const Center(
                  child: Text(
                    "Recharge",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto",
                      color: Colors.black,
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
