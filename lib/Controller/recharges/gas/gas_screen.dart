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

class Gas extends StatefulWidget {
  const Gas({Key key}) : super(key: key);

  @override
  State<Gas> createState() => _GasState();
}

class _GasState extends State<Gas> {
  var dthnmbrController = TextEditingController();
  var dthamtController = TextEditingController();

  List<GasModel> networks = [];
  String opName = 'Haryana City Gas';
  String opCode = 'HCG';
  String blnceAmt = '';
  var code;

  @override
  void initState() {
    super.initState();
    var rng = Random();
    code = rng.nextInt(90000) + 10000;
    //balance();
    networks = [
      GasModel(name: 'Haryana City Gas', code: 'HCG', service: 'Gas'),
      GasModel(name: 'Mahanagar Gas	', code: 'MG', service: 'Gas'),
      GasModel(name: 'Adani Gas', code: 'AG', service: 'Gas'),
      GasModel(name: 'Gujarat Gas	', code: 'GG', service: 'Gas'),
      GasModel(name: 'Indraprastha Gas', code: 'IG', service: 'Gas'),
      GasModel(name: 'Sabarmati Gas	', code: 'SMG', service: 'Gas'),
      GasModel(name: 'Siti Gas UP	', code: 'SEG', service: 'Gas'),
      GasModel(name: 'Avantika Gas', code: 'AVGL', service: 'Gas'),
      GasModel(name: 'Indian Oil Gas	', code: 'IOGL', service: 'Gas'),
      GasModel(name: 'Hp Gas Booking', code: 'Hpgas', service: 'Gas'),
      GasModel(name: 'Indane Gas Booking', code: 'Indanegas', service: 'Gas'),
      GasModel(name: 'Bharat Gas Booking	', code: 'Bharatgas', service: 'Gas'),
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

  apiCall(String amt) {
    RechargeApiService.rechargeApiCall(context, opCode,
            dthnmbrController.text.toString(), amt, code.toString())
        .then((res) {
      if (res['status'] == 'Success') {
        Navigator.pop(context);
        showToast('${res['status']}',
           );
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        showToast('${res['message']},${res['opid']}',
          );
      }
    });
  }

  connectionCheck(String amt) {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        apiCall(amt);
      } else {
        showToast("Please check your internet connection",
          );

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
          "Gas",
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
        child: SingleChildScrollView(
          child: Column(
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
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
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
                            });
                          },
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
                        autofocus: true,
                        controller: dthnmbrController,
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
                  SizedBox(
                    height: 45,
                    child: TextFormField(
                        autofocus: true,
                        controller: dthamtController,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                          hintText: "Amount",
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
                      if (dthnmbrController.text.isEmpty) {
                        showToast('provide a valid  number',
                           );
                      } else if (dthamtController.text.isEmpty) {
                        showToast('provide a amount',
                           );
                      } else {
                        loader(context);
                        connectionCheck(dthamtController.text.toString());
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
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
