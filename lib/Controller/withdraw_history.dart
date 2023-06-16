import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import '../ApiService/withdraw_history_api.dart';
import '../Common/constants.dart';
import '../Model/withdraw_history_model.dart';
import '../Utils/toast.dart';

class WithdrawHistoryScreen extends StatefulWidget {
  const WithdrawHistoryScreen({Key key}) : super(key: key);

  @override
  State<WithdrawHistoryScreen> createState() => _WithdrawHistoryScreenState();
}

class _WithdrawHistoryScreenState extends State<WithdrawHistoryScreen> {
String balance='';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCall();
  }

  List<History> history = [];

  apiCall() {
    WithDrawHistoryApiService.withdrawHistoryApiCall(context).then((value) {
      if (value['status'] == '1') {
        setState(() {
          balance = value['balance'].toString();
            history = ((value["history"] ?? []) as List)
                .map((li) => History.fromJson(li))
                .toList();
          var formatter = new DateFormat('dd-MM-yyyy');

               });
      } else if(history.isEmpty) {
        showToast('message',);
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
        title: const Text(
          "Withdraw History",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              fontFamily: "Poppins"),
        ),
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(left: 10, right: 10),
        //     child: CircleAvatar(
        //       radius: 13.0,
        //       backgroundColor: themeColor,
        //       backgroundImage: AssetImage(
        //         "assets/images/profile_img.png",
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Container(
        color: themeColor,
        height: size.height,
        width: size.width,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10.0, right: 10, top: 15, bottom: 30),
          child: Container(
            // color: Colors.grey[100],
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      child: SizedBox(
                        height: 90,
                        width: size.width * 1.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Available Balance",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",
                                  fontSize: 15.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:  [
                                  const Text(
                                    "Balance",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Roboto",
                                        fontSize: 20.0,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(width: 15),
                                  const Text(
                                    "\u{20B9}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Roboto",
                                        fontSize: 20.0,
                                        color: Colors.green),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    balance,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Roboto",
                                        fontSize: 20.0,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.7,
                    child: FutureBuilder(
                      //   future: getCommonList(),
                      builder: (BuildContext context, snapshot) {
                        return ListView.separated(
                          itemCount: history.length,
                          padding: const EdgeInsets.only(
                            top: 30,
                            bottom: 20,
                          ),
                          itemBuilder: (ctx, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                child: Container(
                                  width: size.width * 1.0,
                                  child: Center(
                                    child: ListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ExpansionTile(
                                              title: Column(
                                                children: [
                                                  Row(
                                                    children:  [
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      const Icon(
                                                        Icons
                                                            .calendar_today_rounded,
                                                        color: Colors.grey,
                                                        size: 15,
                                                      ),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(
                                                        history[index].date,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                "Roboto",
                                                            fontSize: 10.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                   Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0),
                                                    child:  Text(
                                                      "You have used Rs,${history[index].amount} from your wallet from your last withdraw",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,

                                                          fontFamily: "Roboto",
                                                          fontSize: 12.0,
                                                          color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // children: <Widget>[
                                              //   Column(
                                              //     children:
                                              //         // _buildExpandableContent(),
                                              //   ),
                                              // ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildExpandableContent() {
    List<Widget> columnContent = [];
    columnContent.add(
      ListTile(
        title: Container(
            height: 300,
            width: 100,
            //color: Colors.grey,
            child: ListView.separated(
              itemCount: 3,
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 20,
              ),
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    color: Colors.white,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Container(
                      child: Center(
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Icon(
                                      Icons.calendar_today_rounded,
                                      color: Colors.grey,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Oct 31, 2021 ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Roboto",
                                          fontSize: 10.0,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: const Text(
                                    "You have used Rs,500 from your wallet from your last withdraw",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Roboto",
                                        fontSize: 12.0,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 10,
                );
              },
            )),
      ),
    );

    return columnContent;
  }
}
