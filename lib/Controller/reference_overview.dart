import 'package:flutter/material.dart';
import 'package:opal_money/Controller/home_page_screen.dart';
import 'package:opal_money/Controller/my_wallet.dart';
import 'package:toast/toast.dart';

import '../ApiService/reference_overview_api.dart';
import '../Common/constants.dart';
import '../Model/reference_overview_model.dart';
import '../Utils/toast.dart';

class ReferenceOverview extends StatefulWidget {
  final String id;
  const ReferenceOverview({key, this.id}) : super(key: key);

  @override
  State<ReferenceOverview> createState() => _ReferenceOverviewState();
}

class _ReferenceOverviewState extends State<ReferenceOverview> {
  String id, title = 'Reference Overview', status = '';

  @override
  void initState() {
    // TODO: implement initState
    id = widget.id;
    super.initState();
    apiCall('');
  }

  List<Overview> referenceOverview = [];

  apiCall(String sort) {
    ReferenceOverviewApiService.referenceOverviewApiCall(context).then((value) {
      if (value['status'] == '1') {
        setState(() {
          if (sort == '') {
            referenceOverview = ((value["overview"] ?? []) as List)
                .map((li) => Overview.fromJson(li))
                .toList();
          } else if (sort == 'Reffered') {
            referenceOverview = ((value["overview"] ?? []) as List)
                .map((li) => Overview.fromJson(li))
                .toList();
            referenceOverview
                .removeWhere((element) => element.applStatus != sort);
          }else if (sort == 'Inprogress') {
            referenceOverview = ((value["overview"] ?? []) as List)
                .map((li) => Overview.fromJson(li))
                .toList();
            referenceOverview
                .removeWhere((element) => element.applStatus != sort);
          }else if (sort == 'Rejected') {
            referenceOverview = ((value["overview"] ?? []) as List)
                .map((li) => Overview.fromJson(li))
                .toList();
            referenceOverview
                .removeWhere((element) => element.applStatus != sort);
          }else if (sort == 'Completed') {
            referenceOverview = ((value["overview"] ?? []) as List)
                .map((li) => Overview.fromJson(li))
                .toList();
            referenceOverview
                .removeWhere((element) => element.applStatus != sort);
          }
        });
      } else {
        showToast(value['message']);
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
              color: Colors.white70,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              fontFamily: "Poppins"),
        ),
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(left: 10, right: 10),
        //     child: CircleAvatar(
        //       radius: 15.0,
        //       backgroundColor: themeColor,
        //       backgroundImage: AssetImage(
        //         "assets/images/profile_img.png",
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        color: themeColor,
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 35,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            id == "1" ? blueGreyDark : Colors.white,
                        //  padding: const EdgeInsets.only(left: 0, right: 10),
                        primary: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 10,
                          color: id == "1" ? Colors.white : Colors.grey,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          id = "1";
                          title = 'Reference Overview';
                        });
                        apiCall('');
                      },
                      child: Text(
                        'All',
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: id == "1" ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 35,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            id == "2" ? blueGreyDark : Colors.white,
                        //  padding: const EdgeInsets.only(left: 0, right: 10),
                        primary: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 10,
                          color: id == "2" ? Colors.white : Colors.grey,
                        ),
                        // Set this
                      ),
                      onPressed: () {
                        setState(() {
                          id = "2";
                          title = 'Withdraw History';
                          status = 'Reffered';
                        });
                        apiCall(status);
                      },
                      child: Text(
                        'Referred',
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: id == "2" ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 35,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            id == "3" ? blueGreyDark : Colors.white,
                        //  padding: const EdgeInsets.only(left: 0, right: 10),
                        primary: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 10,
                          color: id == "3" ? Colors.white : Colors.grey,
                        ),
                        // Set this
                      ),
                      onPressed: () {
                        setState(() {
                          id = "3";
                          title = 'Withdraw History';
                          status = 'Inprogress';
                        });
                        apiCall(status);
                      },
                      child: Text(
                        'Inprogress',
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: id == "3" ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 35,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            id == "4" ? blueGreyDark : Colors.white,
                        //  padding: const EdgeInsets.only(left: 0, right: 10),
                        primary: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 10,
                          color: id == "4" ? Colors.white : Colors.grey,
                        ),
                        // Set this
                      ),
                      onPressed: () {
                        setState(() {
                          id = "4";
                          title = 'Withdraw History';
                          status = 'Rejected';
                        });
                        apiCall(status);
                      },
                      child: Text(
                        'Dropped',
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: id == "4" ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 35,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor:
                            id == "5" ? blueGreyDark : Colors.white,
                        //  padding: const EdgeInsets.only(left: 0, right: 10),
                        textStyle: TextStyle(
                          fontSize: 10,
                          color: id == "5" ? Colors.white : Colors.black54,
                        ),
                        // Set this
                      ),
                      onPressed: () {
                        setState(() {
                          id = "5";
                          title = 'Withdraw History';
                          status = 'Completed';
                        });
                        apiCall(status);
                      },
                      child: Text(
                        'Completed',
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: id == "5" ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              id == "1" ? all() : sort(status),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget all() {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey[100],
      width: size.width * 1,
      child: Column(
        children: [
          Table(
            border: TableBorder.symmetric(
              outside: BorderSide.none,
              inside: BorderSide.none,
            ),
            columnWidths: const {
              0: FlexColumnWidth(45),
              1: FlexColumnWidth(50),
              2: FlexColumnWidth(75),
              3: FlexColumnWidth(65),
              4: FlexColumnWidth(70),
              5: FlexColumnWidth(50),
            },
            children: [
              TableRow(children: [
                Container(
                  height: 40,
                  color: const Color(0xFF174F78),
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "SlNo",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                    ),
                  ),
                ),
                Container(
                    height: 40,
                    color: const Color(0xFF174F78),
                    padding: const EdgeInsets.only(
                        left: 10, right: 0, top: 10, bottom: 10),
                    child: const Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                      ),
                    )),
                Container(
                  height: 40,
                  color: const Color(0xFF174F78),
                  padding: const EdgeInsets.only(
                      left: 10, right: 5, top: 10, bottom: 10),
                  child: const Text(
                    'Phone No',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  color: const Color(0xFF174F78),
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 10, bottom: 10),
                  child: const Center(
                    child: Text(
                      'Status',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  color: const Color(0xFF174F78),
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 10, bottom: 10),
                  child: const Center(
                    child: Text(
                      'Category',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  color: const Color(0xFF174F78),
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 10, bottom: 10),
                  child: const Center(
                    child: Text(
                      'Amount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
              ])
            ],
          ),
          Table(
            border: const TableBorder(
                verticalInside: BorderSide(
                    width: 0.5, color: themeColor, style: BorderStyle.solid)),
            columnWidths: const {
              0: FlexColumnWidth(45),
              1: FlexColumnWidth(50),
              2: FlexColumnWidth(75),
              3: FlexColumnWidth(65),
              4: FlexColumnWidth(70),
              5: FlexColumnWidth(50),
            },
            children: List.generate(referenceOverview.length, (index){
              int count = index+1;
              return TableRow(
                children: [
                  Container(
                      color: referenceOverview[index].id % 2 == 0
                          ? const Color(0xFFC9C9C9)
                          : Colors.grey[100],
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 10, right: 10),
                      child: Text(
                        count.toString(),
                        style: const TextStyle(color: themeColor, fontSize: 10),
                      )),
                  Container(
                      color:  referenceOverview[index].id % 2 == 0
                          ? const Color(0xFFC9C9C9)
                          : Colors.grey[100],
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 10, right: 10),
                      child: Text(
                        referenceOverview[index].name.toString(),
                        style: const TextStyle(color: themeColor, fontSize: 10),
                      )),
                  Container(
                      color:  referenceOverview[index].id % 2 == 0
                          ? const Color(0xFFC9C9C9)
                          : Colors.grey[100],
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 10, right: 10),
                      child: Text(
                        referenceOverview[index].contact.toString(),
                        style: const TextStyle(color: themeColor, fontSize: 10),
                      )),
                  Container(
                      color:  referenceOverview[index].id % 2 == 0
                          ? const Color(0xFFC9C9C9)
                          : Colors.grey[100],
                      padding: const EdgeInsets.only(
                          top: 11, bottom: 11, left: 10, right: 10),
                      child: Container(
                        height: 20,
                        width: 30,
                        decoration: BoxDecoration(
                            color:  referenceOverview[index].applStatus == "Reffered"
                                ? Colors.blue
                                :  referenceOverview[index].applStatus == "Inprogress"
                                    ? Colors.lime[400]
                                    :  referenceOverview[index].applStatus == "Completed"
                                        ? Colors.green[800]
                                        :  referenceOverview[index].applStatus == "Rejected"
                                            ? Colors.red
                                            : Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Text(
                            referenceOverview[index].applStatus.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      )),
                  Container(
                      color:  referenceOverview[index].id % 2 == 0
                          ? const Color(0xFFC9C9C9)
                          : Colors.grey[100],
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 10, right: 10),
                      child: Text(
                        referenceOverview[index].type.toString(),
                        style: const TextStyle(color: themeColor, fontSize: 10),
                      )),
                  Container(
                      color:  referenceOverview[index].id % 2 == 0
                          ? const Color(0xFFC9C9C9)
                          : Colors.grey[100],
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 10, right: 10),
                      child: Text(
                        referenceOverview[index].amount.toString(),
                        style: const TextStyle(color: themeColor, fontSize: 10),
                      )),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget sort(String id) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey[100],
      width: size.width * 1,
      child: Column(
        children: [
          Table(
            border: TableBorder.symmetric(
              outside: BorderSide.none,
              inside: BorderSide.none,
            ),
            columnWidths: const {
              0: FlexColumnWidth(45),
              1: FlexColumnWidth(50),
              2: FlexColumnWidth(75),
              3: FlexColumnWidth(65),
            },
            children: [
              TableRow(children: [
                Container(
                  height: 40,
                  color: const Color(0xFF174F78),
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    "SlNo",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                    ),
                  ),
                ),
                Container(
                    height: 40,
                    color: const Color(0xFF174F78),
                    padding: const EdgeInsets.only(
                        left: 10, right: 0, top: 10, bottom: 10),
                    child: const Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                      ),
                    )),
                Container(
                  height: 40,
                  color: const Color(0xFF174F78),
                  padding: const EdgeInsets.only(
                      left: 10, right: 5, top: 10, bottom: 10),
                  child: const Text(
                    'Phone No',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  color: const Color(0xFF174F78),
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 10, bottom: 10),
                  child: const Center(
                    child: Text(
                      'Category',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
              ])
            ],
          ),
          Table(
            border: const TableBorder(
                verticalInside: BorderSide(
                    width: 0.5, color: themeColor, style: BorderStyle.solid)),
            columnWidths: const {
              0: FlexColumnWidth(45),
              1: FlexColumnWidth(50),
              2: FlexColumnWidth(75),
              3: FlexColumnWidth(65),
            },
            children: List.generate(referenceOverview.length, (index){
              int count = index+1;

              return TableRow(
                children: [
                  Container(
                      color:  referenceOverview[index].id % 2 == 0
                          ? const Color(0xFFC9C9C9)
                          : Colors.grey[100],
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 10, right: 10),
                      child: Text(
                       count.toString(),
                        style: const TextStyle(color: themeColor, fontSize: 10),
                      )),
                  Container(
                      color:  referenceOverview[index].id % 2 == 0
                          ? const Color(0xFFC9C9C9)
                          : Colors.grey[100],
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 10, right: 10),
                      child: Text(
                        referenceOverview[index].name.toString(),
                        style: const TextStyle(color: themeColor, fontSize: 10),
                      )),
                  Container(
                      color:  referenceOverview[index].id % 2 == 0
                          ? const Color(0xFFC9C9C9)
                          : Colors.grey[100],
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 10, right: 10),
                      child: Text(
                        referenceOverview[index].contact.toString(),
                        style: const TextStyle(color: themeColor, fontSize: 10),
                      )),
                  Container(
                      color:  referenceOverview[index].id % 2 == 0
                          ? const Color(0xFFC9C9C9)
                          : Colors.grey[100],
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 10, right: 10),
                      child: Text(
                        referenceOverview[index].type.toString(),
                        style: const TextStyle(color: themeColor, fontSize: 10),
                      )),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
