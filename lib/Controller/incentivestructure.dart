import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:opal_money/Controller/home_page_screen.dart';
import 'package:opal_money/Controller/registrationscreen.dart';
import 'package:toast/toast.dart';

import '../ApiService/partimeEmployIncentiveApi.dart';
import '../Common/constants.dart';
import '../Model/ModelPartimeEmploySinctvStructure.dart';
import '../Utils/Connectivity.dart';
import '../Utils/toast.dart';

class IncentiveStructure extends StatefulWidget {

  String userType='';
  List<ModelPartimeemployIncentiveStructure> details = [];


  IncentiveStructure({this.userType,this.details});

  @override
  State<IncentiveStructure> createState() => _IncentiveStructureState();
}

class _IncentiveStructureState extends State<IncentiveStructure> {
  final List<Map> _users = [
    {'sl': 1, 'name': 'Trading Account', 'employees': '12a/c'},
    {'sl': 2, 'name': 'Life Insurance', 'employees': '2 Nos'},
    {'sl': 3, 'name': 'Health Insurance', 'employees': '2 Nos'},
    {'sl': 4, 'name': 'Vehicle Insurance', 'employees': '4Nos'},
    {'sl': 5, 'name': 'Home Loan', 'employees': '1 No'},
    {'sl': 6, 'name': 'Personal Loan', 'employees': '25 + 225'},
    {'sl': 7, 'name': 'Educational Loan', 'employees': '25+225'},
    {'sl': 8, 'name': 'MBBS Study Abroad', 'employees': '25+225'},
    {'sl': 9, 'name': 'Overseas Job Consultancy', 'employees': '25+225'},
    {'sl': 10, 'name': 'Real Estate', 'employees': '25+225'}
  ];
  @override
  void initState() {
    super.initState();

  }



  partimeEmployInctiveStructureApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();

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
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: themeColor,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 26,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text(
          "Incentive Structure",
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
      body: Container(
        color: themeColor,
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10, top: 15, bottom: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 20, left: 10, right: 20),
                  child: Html(
                    data: widget.details.isEmpty ? '' : widget.details[0].details,
                    defaultTextStyle: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.grey[100],
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Table(
                          border: const TableBorder(
                              verticalInside: BorderSide(
                                  width: 0.3,
                                  color: Colors.grey,
                                  style: BorderStyle.solid)),
                          columnWidths: const {
                            0: FlexColumnWidth(25),
                            1: FlexColumnWidth(76),
                            2: FlexColumnWidth(45),
                          },
                          children: [
                            TableRow(children: [
                              Container(
                                  height: 50,
                                  color: const Color(0xFF174F78),
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: const Center(
                                      child: Text(
                                    "Sl\nNo",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ))),
                              Container(
                                  height: 50,
                                  color: const Color(0xFF174F78),
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: const Center(
                                      child: Text(
                                    "Categories",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ))),
                              Container(
                                  height: 50,
                                  color: const Color(0xFF174F78),
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: const Center(
                                      child: Text(
                                    "Employees\n(Parttime)",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ))),
                              Container(
                                  height: 50,
                                  color: const Color(0xFF174F78),
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: const Center(
                                      child: Text(
                                    "Referer",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ))),
                              Container(
                                  height: 50,
                                  color: const Color(0xFF174F78),
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: const Center(
                                      child: Text(
                                    "Customers",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ))),
                            ]),
                          ],
                        ),
                        Table(
                          border: const TableBorder(
                              verticalInside: BorderSide(
                                  width: 0.5,
                                  color: themeColor,
                                  style: BorderStyle.solid)),
                          columnWidths: const {
                            0: FlexColumnWidth(25),
                            1: FlexColumnWidth(76),
                            2: FlexColumnWidth(45),
                          },
                          children: _users.map((user) {
                            return TableRow(children: [
                              Container(
                                  color: _users.indexOf(user) % 2 == 0
                                      ? Colors.grey[100]
                                      : const Color(0xFFE0E0E0),
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 2, right: 2),
                                  child: Center(
                                      child: Text(
                                    user['sl'].toString(),
                                    style: const TextStyle(
                                        color: themeColor, fontSize: 10),
                                  ))),
                              Container(
                                  color: _users.indexOf(user) % 2 == 0
                                      ? Colors.grey[100]
                                      : const Color(0xFFE0E0E0),
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 5, right: 2),
                                  child: Text(
                                    user['name'],
                                    style: const TextStyle(
                                        color: themeColor, fontSize: 10),
                                  )),
                              Container(
                                  color: _users.indexOf(user) % 2 == 0
                                      ? Colors.grey[100]
                                      : const Color(0xFFE0E0E0),
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, left: 10, right: 2),
                                  child: Center(
                                    child: Text(
                                      user['employees'],
                                      style: const TextStyle(
                                          color: themeColor, fontSize: 10),
                                    ),
                                  )),
                            ]);
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          primary: Colors.black,
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Close',
                          style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
