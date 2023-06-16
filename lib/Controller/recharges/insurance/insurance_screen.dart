import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opal_money/Common/constants.dart';
import 'package:opal_money/Utils/loader.dart';
import 'package:toast/toast.dart';

import '../../../ApiService/recharge_api.dart';
import '../../../Model/plans.dart';
import '../../../Model/providers.dart';
import '../../../Utils/Connectivity.dart';
import '../../../Utils/toast.dart';

class Insurance extends StatefulWidget {
  const Insurance({Key key}) : super(key: key);

  @override
  State<Insurance> createState() => _InsuranceState();
}

class _InsuranceState extends State<Insurance> {
  var policyController = TextEditingController();
  var amtController = TextEditingController();
  var dobTextController = TextEditingController();

  List<Insurances> networks = [];
  String opName = 'ICICI Prudential Insurance';
  String opCode = 'ICP';
  String blnceAmt = '';
  var code;

  @override
  void initState() {
    super.initState();
    var rng = Random();
    code = rng.nextInt(90000) + 10000;
   // balance();
    networks = [
      Insurances(
          name: 'ICICI Prudential Insurance',
          code: 'ICP',
          service: 'Insurance'),
      Insurances(
          name: 'Tata AIA Insurance	', code: 'TAI', service: 'Insurance'),
      Insurances(
          name: 'Life Insurance Corporation of India	',
          code: 'LICOF',
          service: 'Insurance'),
      Insurances(
          name: 'Aditya Birla Sun Life Insurance',
          code: 'ABSL',
          service: 'Insurance'),
      Insurances(name: 'Aviva Life', code: 'AVLI', service: 'Insurance'),
      Insurances(
          name: 'Bajaj Allianz Life Insurance',
          code: 'BALI',
          service: 'Insurance'),
      Insurances(
          name: 'Bharti AXA Life Insurance',
          code: 'AXLI',
          service: 'Insurance'),
      Insurances(
          name: 'Canara HSBC OBC Life Insurance',
          code: 'CHOL',
          service: 'Insurance'),
      Insurances(
          name: 'Edelweiss Tokio Life Insurance	',
          code: 'ETLI',
          service: 'Insurance'),
      Insurances(
          name: 'Exide Life Insurance	', code: 'EXLI', service: 'Insurance'),
      Insurances(
          name: 'Future Generali India Life Insurance Company Limited		',
          code: 'FGIL	',
          service: 'Insurance'),
      Insurances(
          name: 'HDFC Life Insurance	', code: 'HDFC	', service: 'Insurance'),
      Insurances(
          name: 'IDBI Federal Life Insurance		',
          code: 'IDBI	',
          service: 'Insurance'),
      Insurances(
          name: 'Max Life Insurance			', code: 'MAXL		', service: 'Insurance'),
      Insurances(
          name: 'PNB MetLife Insurance			',
          code: 'PNBM		',
          service: 'Insurance'),
      Insurances(
          name: 'Pramerica Life Insurance		',
          code: 'PRLI		',
          service: 'Insurance'),
      Insurances(
          name: 'Reliance Nippon Life Insurance			',
          code: 'RNLI		',
          service: 'Insurance'),

      Insurances(
          name: 'SBI Life Insurance			',
          code: 'SBIL			',
          service: 'Insurance'), Insurances(
          name: 'Shriram Life Insurance Co Ltd		',
          code: 'SLIC			',
          service: 'Insurance'),
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
    RechargeApiService.rechargeXtraApiCall(
            context, opCode, '', amt, code.toString(),dobTextController.text.toString())
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
          "Insurance",
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
                      style: const TextStyle(color: Colors.black, fontSize: 12),
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
                    controller: policyController,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300),
                    decoration: InputDecoration(
                      hintText: 'Enter customer policy number',
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
                    maxLength: 30),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 45,
                child: TextFormField(
                    autofocus: true,
                    controller: amtController,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300),
                    decoration: InputDecoration(
                      hintText: 'Enter amount',
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
                    maxLength: 30),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: size.width * 0.39,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: dobTextController,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                          hintText: "DOB",
                          hintStyle: const TextStyle(
                              fontFamily: "Roboto",
                              color: Colors.black54,
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
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime pickedDate = await showDatePicker(
                            context: context, initialDate: DateTime.now(),
                            firstDate: DateTime(
                                1950), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              dobTextController.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "YYYY-MM-DD",
                      style: TextStyle(
                          fontFamily: "Roboto",
                          color: Colors.black54,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
                onPressed: () {
                  if (policyController.text.isEmpty) {
                    showToast('provide a valid policy number',
                       );
                  } else if (amtController.text.isEmpty) {
                    showToast('provide a valid amount',
                    );
                  } else if (dobTextController.text.isEmpty) {
                    showToast('provide a DOB',
                       );
                  } else {
                    loader(context);
                    connectionCheck(amtController.text);
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
        ),
      ),
    );
  }
}
