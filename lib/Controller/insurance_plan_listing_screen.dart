import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/ApiService/planListApiService.dart';
import 'package:opal_money/Controller/create_account_screen.dart';
import 'package:opal_money/Controller/enquiry_form.dart';
import 'package:opal_money/Controller/health_insurance_application_form.dart';
import 'package:opal_money/Controller/home_plan_details.dart';
import 'package:opal_money/Controller/insurance_listing_screen.dart';
import 'package:opal_money/Controller/life_insurance_application_form.dart';
import 'package:opal_money/Controller/life_insurance_plan_details.dart';
import 'package:opal_money/Controller/vehicleinsurance_applictn.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Model/ModelPlanList.dart';
import '../Utils/Connectivity.dart';
import '../Utils/toast.dart';
import 'homeLoan_applictn.dart';

class InsurancePlanListingScreen extends StatefulWidget {
  final String catId;
  final String subcatId;
  final String title;

  const InsurancePlanListingScreen({key, this.catId, this.subcatId, this.title})
      : super(key: key);

  @override
  State<InsurancePlanListingScreen> createState() =>
      _InsurancePlanListingScreenState();
}

class _InsurancePlanListingScreenState
    extends State<InsurancePlanListingScreen> {
  ModelPlanList model;

  @override
  void initState() {
    super.initState();
    planListApiCall();
  }

  planListApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        apiFunc();
      } else {
        showToast(
          "Please check your internet connection",
        );

        return;
      }
    });
  }

  apiFunc() {
    PlanListApiService.planListApiCall(context, widget.subcatId)
        .then((result) async {
      try {
        // showToast(result.message.toString(),
        //    );

        // progressDialog.hide();
        if (result.success) {
          setState(() {
            model = result;
          });
          // showToast((result.message), gravity: Toast.BOTTOM, duration: 2);
        }
        // await progressDialog.hide();
        // showToast((result.message), gravity: Toast.BOTTOM, duration: 2);
      } catch (e) {
        //await progressDialog.hide();
      }
    });
  }

  Future<ModelPlanList> getPlanList() async {
    return model;
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
        title: Text(
          widget.title,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              fontFamily: "Poppins"),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
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
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 1,
            thickness: 0.5,
            color: Colors.white,
          ),
          Flexible(
            child: FutureBuilder(
              future: getPlanList(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 10, right: 10),
                      itemBuilder: (ctx, index) {
                        return Card(
                          color: Colors.white,
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height:100,
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CachedNetworkImage(
                                        width: 100,
                                        height: 80,

                                        fit: BoxFit.cover,
                                        imageUrl: model.data[index].planImage,
                                        placeholder: (context, url) => Container(),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                              'assets/images/no_image.png',
                                              scale: 4.0,
                                            )),
                                  ),
                                ),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model.data[index].plan.length > 60
                                            ? '${model.data[index].plan.substring(0, 60)}...'
                                            : model.data[index].plan,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          //  overflow: TextOverflow.ellipsis,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          print('fhfhfhfh ' + widget.catId);
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return LifeInsurancePlanDetails(
                                              catId: widget.catId,
                                              planId: model.data[index].id
                                                  .toString(),
                                              subcatId: widget.subcatId,
                                              title: model.data[index].subCat,
                                              plan: model.data[index].plan
                                                  .toString(),
                                              description:
                                                  model.data[index].description,
                                              image:
                                                  model.data[index].planImage,
                                            );
                                          }));
                                        },
                                        child: RichText(
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                          text: TextSpan(
                                            // Note: Styles for TextSpans must be explicitly defined.
                                            // Child text spans will inherit styles from parent

                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 14.0,
                                              color: Colors.grey,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    "${model.data[index].description.substring(0, 90)}...",
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: "Roboto",
                                                ),
                                              ),
                                              const TextSpan(
                                                  text: 'Know More',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                    fontSize: 12,
                                                    fontFamily: "Roboto",
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            child: Center(
                                              child: Row(
                                                children: const [
                                                  Text(
                                                    "Enquiry ",
                                                    style: TextStyle(
                                                        color: themeColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "Roboto"),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 12,
                                                    color: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return EnquiryFormScreen(
                                                  catId: widget.subcatId,
                                                  subcatId: widget.subcatId,
                                                  planId: model.data[index].id
                                                      .toString(),
                                                  title:
                                                      model.data[index].subCat,
                                                );
                                              }));
                                            },
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.0, right: 10),
                                            child: Text(
                                              "|",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              widget.catId == "1"
                                                  ? Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                      return LifeInsuranceApplicationForm(
                                                        catId: widget.catId,
                                                        subcatId: widget.subcatId,
                                                        planId: model
                                                            .data[index].id
                                                            .toString(),
                                                      );
                                                    }))
                                                  :  widget.catId == "2"
                                                      ? Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                          return HealthInsuranceApplicationForm(
                                                            catId: widget.catId,
                                                            subcatId: widget.subcatId,
                                                            planId: model
                                                                .data[index].id
                                                                .toString(),
                                                          );
                                                        }))
                                                      :  widget.catId == "3"
                                                          ? Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                              return const VehicleInsuranceApplication();
                                                            }))
                                                  :  widget.catId == "4"
                                                  ? Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) {
                                                        return HomeLoanApplicationForm(
                                                          catId: widget.catId,
                                                          subcatId: widget.subcatId,
                                                          planId: model
                                                              .data[index].id
                                                              .toString(),
                                                        );
                                                      }))
                                                          : showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                content: Stack(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                    Image.asset(
                                                                      "assets/images/recharge.png",
                                                                      height:
                                                                          170,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                            },
                                            child: Row(
                                              children: const [
                                                Text(
                                                  "Apply Now",
                                                  style: TextStyle(
                                                      color: themeColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Roboto"),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 12,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // const Positioned(
                                //     top: 80,
                                //     right: 35,
                                //     child:  Text("Know More",
                                //       style: TextStyle(
                                //           color: Colors.black,
                                //           fontSize: 13,
                                //           fontWeight: FontWeight.w500,
                                //           fontFamily: "Roboto"
                                //       ),)),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: model.data.length);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
