import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../ApiService/notification_api.dart';
import '../ApiService/withdraw_history_api.dart';
import '../Common/constants.dart';
import '../Model/notification_model.dart';
import '../Model/withdraw_history_model.dart';
import '../Utils/toast.dart';
import 'home_page_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String balance='';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCall();
  }

  List<Notifications> notification = [];

  apiCall() {
    NotificationApiService.notificationApiCall(context).then((value) {
      if (value['status'] == '1') {
        setState(() {
          notification = ((value["data"] ?? []) as List)
              .map((li) => Notifications.fromJson(li))
              .toList();
        });
      } else {
        showToast(value['message'],);
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HomePageScreen();
                  },
                ),
              );            },
          ),
        ),
        title: const Text(
          "Notifications",
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
          child: FutureBuilder(
            builder: (BuildContext context, snapshot) {
              return ListView.separated(
                itemCount: notification.length,
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children:  [

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
                                              notification[index].date,
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
                                              left: 0.0),
                                          child:  Text(
                                            notification[index].heading,
                                            style: const TextStyle(
                                                fontWeight:
                                                FontWeight.w400,
                                                fontFamily: "Roboto",
                                                fontSize: 12.0,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    children: <Widget>[
                                      Column(
                                        children:
                                        _buildExpandableContent(index),
                                      ),
                                    ],
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
      ),
    );
  }

  _buildExpandableContent(int index) {
    List<Widget> columnContent = [];
    columnContent.add(
      ListTile(
        title: Container(
            //height: 300,
            width: 100,
            //color: Colors.grey,
            child:  GestureDetector(
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
                            child: Text(notification[index].description)
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

            )),

    );

    return columnContent;
  }
}
