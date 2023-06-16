import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/Common/constants.dart';
import 'package:opal_money/Controller/houses_apartments_tab_list_screen.dart';
import 'package:toast/toast.dart';
import 'package:opal_money/Model/ModelLandAndPlots.dart';

import '../ApiService/property_details_api.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import '../Utils/toast.dart';
import 'enquirysuccess_screen.dart';

class HousesApartmentsDetailsScreen extends StatefulWidget {
  String id;
  List<Data> listData = [];

  HousesApartmentsDetailsScreen({Key key, this.id, this.listData})
      : super(key: key);

  @override
  State<HousesApartmentsDetailsScreen> createState() =>
      _HousesApartmentsDetailsScreenState();
}

class _HousesApartmentsDetailsScreenState
    extends State<HousesApartmentsDetailsScreen> {
  String img = '', rate = '', loct = '', desc = '';

  @override
  void initState() {
    super.initState();
    landAndPlotListApiCall(widget.id);
  }



  landAndPlotListApiCall(String id) {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        apiCall(id);
      } else {
        showToast("Please check your internet connection",

            );

        return;
      }
    });
  }

  apiCall(String id) {
    PropertyDetailsApiService.propertydetailsApiCall(context, id).then((value) {
      if (value['status'] == 'success') {
        setState(() {
          img = value['details'][0]['image_1'];
          rate =  value['details'][0]['expected_rate'].toString();
          loct =  value['details'][0]['location'];
          desc =  value['details'][0]['description'];

        });
      }
    });
  }

  enquire(BuildContext context) {
    PropertyDetailsApiService.enquireApiCall(
            context, widget.id, Global.shared.id)
        .then((value) {
      showToast(value['message'],
         );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return  EnquirySucessScreen();
          },
        ),
      );
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
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
      bottomSheet: buttonBottom(context),
      body: Container(
        height: size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                width: size.width,
                decoration: const BoxDecoration(
                  color: themeColor,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.network(
                        '${baseURL}images/realestate/$img',
                        fit: BoxFit.fill,
                      ),
                    )),
              ),
              Container(
                height: size.height * 0.65,
                color: Colors.white,
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 20, bottom: 10),
                            child: Text(
                              "\u{20AC}$rate",
                              style: const TextStyle(
                                  color: Colors.indigoAccent,
                                  fontFamily: "Roboto",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 20.0, top: 20.0),
                                child: Image.asset(
                                  "assets/images/share.png",
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.fill,
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/location.png",
                              height: 15,
                              width: 15,
                              fit: BoxFit.fill,
                            ),
                            Text(
                              loct,
                              style: const TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(left: 20.0, top: 50, bottom: 20),
                        child: Text(
                          "Description",
                          style: TextStyle(
                              color: themeColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              fontFamily: "Roboto"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, bottom: 20),
                        child: Text(
                          desc,
                          style: const TextStyle(
                              color: themeColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: "Roboto"),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(left: 20.0, top: 50, bottom: 20),
                        child: Text(
                          "Related Items",
                          style: TextStyle(
                              color: themeColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              fontFamily: "Roboto"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Container(
                          height: 200,
                          width: size.width,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.listData.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    landAndPlotListApiCall(
                                        widget.listData[index].id.toString());
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Container(
                                          height: 180,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black26,
                                                width: .5),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Container(
                                                      height: 80,
                                                      width: size.width,
                                                      decoration:
                                                          const BoxDecoration(),
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          child: Image.network(
                                                            widget.listData[index].image1,
                                                            fit: BoxFit.fill,
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            top: 10,
                                                            bottom: 5),
                                                    child: Text(
                                                      "\u{20AC}${widget.listData[index].expectedRate}",
                                                      style: const TextStyle(
                                                          color: Colors
                                                              .indigoAccent,
                                                          fontFamily: "Roboto",
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            bottom: 20),
                                                    child: Text(
                                                      widget.listData[index]
                                                          .location,
                                                      style: const TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonBottom(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 60,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: themeColor,
          padding: const EdgeInsets.only(left: 50, right: 50),
          primary: Colors.white,
          textStyle: const TextStyle(
            fontSize: 15,
          ),
          // Set this
        ),
        onPressed: () {
          enquire(context);

        },
        child: const Text(
          'Enquire Now',
          style: TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
      ),
    );
  }
}
