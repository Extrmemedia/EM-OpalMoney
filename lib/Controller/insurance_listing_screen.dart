import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/ApiService/commonListApiService.dart';
import 'package:opal_money/Common/constants.dart';
import 'package:opal_money/Controller/insurance_plan_listing_screen.dart';
import 'package:opal_money/Model/ModelCommonList.dart';
import 'package:toast/toast.dart';

import '../Utils/Connectivity.dart';
import '../Utils/toast.dart';
import 'home_page_screen.dart';

class InsuranceListingScreen extends StatefulWidget {
  final String catId;
  final String title;

  const InsuranceListingScreen({key, this.catId, this.title}) : super(key: key);

  @override
  State<InsuranceListingScreen> createState() => _InsuranceListingScreenState();
}

class _InsuranceListingScreenState extends State<InsuranceListingScreen> {
  ModelCommonList model;

  @override
  void initState() {
    super.initState();
    commonListApiCall();
  }

  commonListApiCall() {
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
    CommonListApiService.commonListApiCall(context, widget.catId)
        .then((result) async {
      try {
        //showToast(result.message.toString(),
        // gravity: Toast.BOTTOM, duration: 2);
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

  Future<ModelCommonList> getCommonList() async {
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
              //   radius:13.0,
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
          SizedBox(
            height: size.height * 0.8,
            child: FutureBuilder(
              future: getCommonList(),
              builder: (BuildContext context, snapshot) {
                // print("snapshot"+snapshot.data.toString());
                if (snapshot.hasData) {
                  return ListView.separated(
                    itemCount: model.data.length,
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          print('dgdgdgdgd ${widget.catId}');
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return InsurancePlanListingScreen(
                              catId: widget.catId,
                              title: model.data[index].subCat,
                              subcatId: model.data[index].id.toString(),
                            );
                          }));
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 0,
                          child: Container(
                            height: 120,
                            width: size.width,
                            child: Center(
                              child: ListTile(
                                leading: CachedNetworkImage(
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fill,
                                    imageUrl: model.data[index].subcatImage,
                                    placeholder: (context, url) => Container(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                          'assets/images/no_image.png',
                                          scale: 4.0,
                                        )),
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    model.data[index].subCat.toUpperCase(),
                                    style: const TextStyle(
                                      color: Color(0xFF0A1E84),
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                    ),
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
