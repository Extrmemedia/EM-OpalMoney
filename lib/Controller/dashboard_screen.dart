import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:opal_money/ApiService/live_url_api.dart';
import 'package:opal_money/Controller/my_wallet.dart';
import 'package:opal_money/Controller/partimemply_agent_expaired.dart';
import 'package:opal_money/Controller/real_estate_screen.dart';
import 'package:opal_money/Controller/registrationscreen.dart';
import 'package:opal_money/Controller/subscription_renewal.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toast/toast.dart';
import '../ApiService/checkregistereduserApiService.dart';
import '../ApiService/subscriptionRenewalApiService.dart';
import '../ApiService/version_check.dart';
import '../Common/constants.dart';
import '../Utils/Connectivity.dart';
import '../Utils/toast.dart';
import 'create_account_screen.dart';
import 'insurance_listing_screen.dart';
import 'job_registration.dart';
import 'matrimonial_registration.dart';
import 'payment_screen.dart';
import 'trading_account_details_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String localVersion = '3';
  String url = '';
  int _currentIndex = 0;
  final List<String> imagesList = [
    'assets/images/carousel_three_bg.png',
    'assets/images/carousel_one_bg.png',
    'assets/images/carousel_two_bg.png'
  ];

  final List<String> imagesBottom = [
    'assets/images/carousel.png',
    'assets/images/real.png',
    'assets/images/matrimonial_reg.png',
    'assets/images/job_carousel.png'
  ];

  String _agent = '';
  String job = '';

  @override
  void initState() {
    super.initState();
    loginApiCall();
    versionCheck();
  }

  loginApiCall() {
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
    CheckregisteredUserApiService.userReistrationApiCall(context, '')
        .then((result) async {
      if (result['status'] == '2') {
        showDialog(
          barrierColor: const Color(0xff4242432),
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return WillPopScope(
                onWillPop: () async => false, child: _alertDialog());
          },
        );

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return  SubscriptionRenewel();
        //     },
        //   ),
        // );

      } else {
        try {
          setState(() {
            _agent = result['status'].toString();
            print('fjfjfjfj' + _agent.toString());
          });
          return _agent;
        } catch (e) {
          //await progressDialog.hide();
        }
      }
    });
    CheckregisteredUserApiService.consultancyApiCall(context, '')
        .then((result) async {
      if (result['status'] == '2') {
        showDialog(
          barrierColor: const Color(0xff4242432),
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return WillPopScope(
                onWillPop: () async => false, child: _alertDialog());
          },
        );

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return  SubscriptionRenewel();
        //     },
        //   ),
        // );

      } else {
        try {
          setState(() {
            job = result['status'].toString();
            print('fjfjfjfj' + job.toString());
          });
          return job;
        } catch (e) {
          //await progressDialog.hide();
        }
      }
    });
  }

  versionCheck() {
    VersionApiService.versionApiCall(context).then((res) {
      if (res['status'] == '1') {
        if (int.parse(res['data'][0]['android']) > int.parse(localVersion)) {
          _version(context);
        }
      }
    });
  }

  _version(BuildContext context) {
    Alert(
      onWillPopActive: true,
      closeFunction: () {},
      closeIcon: const Icon(
        Icons.key,
        color: Colors.transparent,
      ),
      context: context,
      type: AlertType.info,
      title: "Version Update",
      desc: "New version of app is available",
      buttons: [
        DialogButton(
          color: themeColor,
          child: const Text(
            "Update Now",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            LaunchReview.launch(
              androidAppId: 'com.opalmoneyindia.app',
            );
          },
        ),
      ],
    ).show().then((value) {
      // print('kkkkkkkkk');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ToastContext().init(context);

    return Container(
      height: size.height,
      width: size.width,
      color: themeColor,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.8,
                aspectRatio: 16 / 8,
                autoPlay: true,
                height: 180,
                onPageChanged: (index, reason) {
                  setState(
                    () {
                      _currentIndex = index;
                    },
                  );
                },
              ),
              items: imagesList
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Card(
                        elevation: 2.0,
                        shadowColor: themeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          child: Image.asset(
                            item,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imagesList.map((urlOfItem) {
                int index = imagesList.indexOf(urlOfItem);
                return Container(
                  width: 5.0,
                  height: 5.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 3.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.green : Colors.white,
                  ),
                );
              }).toList(),
            ),
            const Divider(
              color: Color(0xFFD3D3D3),
              thickness: 0.5,
            ),
            //registration(),
            Visibility(
                visible: _agent == '0' ? true : false,
                child: registration(context)),
            Visibility(
                visible: job == '0' ? true : false, child: jobCons(context)),

            tradingAccount(),
            const Divider(
              color: Color(0xFFD3D3D3),
              thickness: 0.5,
            ),
            insurance(),
            const Divider(
              color: Color(0xFFD3D3D3),
              thickness: 0.5,
            ),

            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 10, left: 10, right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const MyWalletScreen();
                  }));
                },
                child: Container(
                  height: 130,
                  width: size.width,
                  color: themeColor,
                  child: Card(
                    elevation: 2.0,
                    shadowColor: themeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      child: Image.asset(
                        "assets/images/wallet_bg.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const Divider(
              color: Color(0xFFD3D3D3),
              thickness: 0.5,
            ),

            loanSchemes(),
            const Divider(
              color: Color(0xFFD3D3D3),
              thickness: 0.5,
            ),

            otherServices(),
            const Divider(
              color: Color(0xFFD3D3D3),
              thickness: 0.5,
            ),

            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 0.37,
                aspectRatio: 16 / 8,
                height: 100,
                clipBehavior: Clip.hardEdge,
                onPageChanged: (index, reason) {
                  setState(
                    () {
                      _currentIndex = index;
                    },
                  );
                },
              ),
              items: imagesBottom
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: InkWell(
                        onTap: () {
                          if (item == 'assets/images/carousel.png') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const InsuranceListingScreen(
                                    catId: "8",
                                    title: "Study Abroad",
                                  );
                                },
                              ),
                            );
                          } else if (item == 'assets/images/real.png') {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const RealEstateScreen();
                            }));
                          } else if (item ==
                              'assets/images/matrimonial_reg.png') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MatrimonialRegistrationScreen()));


                          } else {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const JobRegistrationScreen();
                            }));
                          }
                        },
                        child: Card(
                          margin: const EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                          ),
                          elevation: 2.0,
                          shadowColor: themeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            child: Image.asset(
                              item,
                              width: size.width * 0.4,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget tradingAccount() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 0.0),
            child: Text(
              "Trading Account:",
              style: TextStyle(
                color: Color(0xFFD3D3D3),
                fontSize: 16.0,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            width: size.width,
            color: themeColor,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 25.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const CreateAccountScreen();
                              },
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 28.0,
                          backgroundColor: bgCircleColor,
                          child: Center(
                            child: Image.asset(
                              "assets/images/create_account.png",
                              height: 32,
                              width: 32,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        width: 70,
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                              color: Color(0xFFD3D3D3),
                              fontSize: 11,
                              fontFamily: "Roboto"),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const TradingAccountDetailsScreen();
                          },
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 28.0,
                          backgroundColor: bgCircleColor,
                          child: Center(
                            child: Image.asset(
                              "assets/images/details.png",
                              height: 32,
                              width: 32,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          width: 70,
                          child: Text(
                            "Details",
                            style: TextStyle(
                                color: Color(0xFFD3D3D3),
                                fontSize: 11,
                                fontFamily: "Roboto"),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget insurance() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 0.0),
            child: Text(
              "Insurance",
              style: TextStyle(
                color: Color(0xFFF1C3EA),
                fontSize: 16.0,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            width: size.width,
            color: themeColor,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 25),
                  child: Column(
                    children: [
                      GestureDetector(
                        child: CircleAvatar(
                          radius: 28.0,
                          backgroundColor: bgCircleColor,
                          child: Center(
                            child: Image.asset(
                              "assets/images/life.png",
                              height: 32,
                              width: 32,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const InsuranceListingScreen(
                              catId: "1",
                              title: "Life Insurance",
                            );
                          }));
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        width: 70,
                        child: Text(
                          "Life",
                          style: TextStyle(
                              color: Color(0xFFD3D3D3),
                              fontSize: 11,
                              fontFamily: "Roboto"),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 25.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const InsuranceListingScreen(
                              catId: "2",
                              title: "Health Insurance",
                            );
                          },
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 28.0,
                          backgroundColor: bgCircleColor,
                          child: Center(
                            child: Image.asset(
                              "assets/images/health.png",
                              height: 32,
                              width: 32,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          width: 70,
                          child: Text(
                            "Health",
                            style: TextStyle(
                                color: Color(0xFFD3D3D3),
                                fontSize: 11,
                                fontFamily: "Roboto"),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 25.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const InsuranceListingScreen(
                              catId: "3",
                              title: "Vehicle Insurance",
                            );
                          },
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 28.0,
                          backgroundColor: bgCircleColor,
                          child: Center(
                            child: Image.asset(
                              "assets/images/vehicle.png",
                              height: 35,
                              width: 35,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          width: 70,
                          child: Text(
                            "Vehicle",
                            style: TextStyle(
                                color: Color(0xFFD3D3D3),
                                fontSize: 11,
                                fontFamily: "Roboto"),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget loanSchemes() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              "Loan Schemes",
              style: TextStyle(
                color: Color(0xFFF1C3EA),
                fontSize: 16.0,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            width: size.width,
            color: themeColor,
            child: Center(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const InsuranceListingScreen(
                                catId: "4",
                                title: "Housing Loan",
                              );
                            },
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 28.0,
                            backgroundColor: bgCircleColor,
                            child: Center(
                              child: Image.asset(
                                "assets/images/housing_new.png",
                                height: 32,
                                width: 32,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const SizedBox(
                            width: 70,
                            child: Text(
                              "Housing",
                              style: TextStyle(
                                  color: Color(0xFFD3D3D3),
                                  fontSize: 11,
                                  fontFamily: "Roboto"),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 25.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const InsuranceListingScreen(
                                catId: "5",
                                title: "Personal Loan",
                              );
                            },
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 28.0,
                            backgroundColor: bgCircleColor,
                            child: Center(
                              child: Image.asset(
                                "assets/images/personal.png",
                                height: 32,
                                width: 32,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const SizedBox(
                            width: 70,
                            child: Text(
                              "Personal",
                              style: TextStyle(
                                  color: Color(0xFFD3D3D3),
                                  fontSize: 11,
                                  fontFamily: "Roboto"),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 25.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const InsuranceListingScreen(
                                catId: "6",
                                title: "Vehicle Loan",
                              );
                            },
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 28.0,
                            backgroundColor: bgCircleColor,
                            child: Center(
                              child: Image.asset(
                                "assets/images/car.png",
                                height: 36,
                                width: 36,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const SizedBox(
                            width: 70,
                            child: Text(
                              "Vehicle",
                              style: TextStyle(
                                  color: Color(0xFFD3D3D3),
                                  fontSize: 11,
                                  fontFamily: "Roboto"),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 0.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const InsuranceListingScreen(
                                catId: "7",
                                title: "Educational Loan",
                              );
                            },
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 28.0,
                            backgroundColor: bgCircleColor,
                            child: Center(
                              child: Image.asset(
                                "assets/images/educational.png",
                                height: 32,
                                width: 32,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const SizedBox(
                            width: 70,
                            child: Text(
                              "Educational",
                              style: TextStyle(
                                  color: Color(0xFFD3D3D3),
                                  fontSize: 11,
                                  fontFamily: "Roboto"),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget otherServices() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              "Other Services",
              style: TextStyle(
                color: Color(0xFFF1C3EA),
                fontSize: 16.0,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            width: size.width,
            color: themeColor,
            child: Center(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const InsuranceListingScreen(
                                catId: "8",
                                title: "Study Abroad",
                              );
                            },
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 28.0,
                            backgroundColor: bgCircleColor,
                            child: Center(
                              child: Image.asset(
                                "assets/images/studyabroad_logo.png",
                                height: 32,
                                width: 32,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const SizedBox(
                            width: 68,
                            child: Text(
                              "Study\nAbroad",
                              style: TextStyle(
                                  color: Color(0xFFD3D3D3),
                                  fontSize: 11,
                                  fontFamily: "Roboto"),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 25.0,
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const RealEstateScreen();
                            }));
                          },
                          child: CircleAvatar(
                            radius: 28.0,
                            backgroundColor: bgCircleColor,
                            child: Center(
                              child: Image.asset(
                                "assets/images/real_estate.png",
                                height: 32,
                                width: 32,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          width: 70,
                          child: Text(
                            "Real Estate\n Services",
                            style: TextStyle(
                                color: Color(0xFFD3D3D3),
                                fontSize: 11,
                                fontFamily: "Roboto"),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 25.0,
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const MatrimonialRegistrationScreen()));

                          },
                          child: CircleAvatar(
                            radius: 28.0,
                            backgroundColor: bgCircleColor,
                            child: Center(
                              child: Image.asset(
                                "assets/images/matrimony.png",
                                height: 32,
                                width: 32,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          width: 70,
                          child: Text(
                            "Matrimonial\nRegistration",
                            style: TextStyle(
                                color: Color(0xFFD3D3D3),
                                fontSize: 11,
                                fontFamily: "Roboto"),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 0.0,
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const JobRegistrationScreen();
                            }));
                          },
                          child: CircleAvatar(
                            radius: 28.0,
                            backgroundColor: bgCircleColor,
                            child: Center(
                              child: Image.asset(
                                "assets/images/job_consultancy.png",
                                height: 32,
                                width: 32,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          width: 70,
                          child: Text(
                            "Job\nConsultancy",
                            style: TextStyle(
                                color: Color(0xFFD3D3D3),
                                fontSize: 11,
                                fontFamily: "Roboto"),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget registration(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 10.0,
        bottom: 10,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen()))
              .then((value) => apiFunc());
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          child: Container(
            height: 82.0,
            width: double.infinity,
            color: const Color(0xffefc5eb),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Register As',
                  style: TextStyle(
                      color: Color(0xFF56068c),
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Roboto"),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Text(
                  'Part-Time Employee / Agent',
                  style: TextStyle(
                      color: Color(0xFF3d3d3d),
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                      fontFamily: "Roboto"),
                ),
              ],
            ),
          ),

          // Image.asset(
          //   "assets/images/regback.png",
          //   fit: BoxFit.fill,
          // ),
        ),
      ),
    );
  }

  Widget jobCons(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 10.0,
        bottom: 10,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const JobRegistrationScreen();
          }));
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          child: Container(
            height: 82.0,
            width: double.infinity,
            color: const Color(0xffefc5eb),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Register As',
                  style: TextStyle(
                      color: Color(0xFF56068c),
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Roboto"),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Text(
                  'Job Consultancy',
                  style: TextStyle(
                      color: Color(0xFF3d3d3d),
                      fontWeight: FontWeight.w500,
                      fontSize: 17.0,
                      fontFamily: "Roboto"),
                ),
              ],
            ),
          ),

          // Image.asset(
          //   "assets/images/regback.png",
          //   fit: BoxFit.fill,
          // ),
        ),
      ),
    );
  }

  Widget _alertDialog() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 30, right: 10, bottom: 5, top: 150),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          child: Container(
            height: 400,
            width: 300,
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.asset(
                      "assets/images/expire.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'SORRY!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Your Part-Time Employee / Agent \nAccount is Expired',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'If you want to continue',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () {
                          subscriptionrenewelApiCall();
                        },
                        child: Container(
                          height: 30,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Re-Register",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Or',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'If you want to be a user please contactus\n 7356255173',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  subscriptionrenewelApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        subApi();
      } else {
        showToast(
          "Please check your internet connection",
        );

        return;
      }
    });
  }

  subApi() {
    SubscriptionRenewalApiService.subscriptionRenewal(context)
        .then((result) async {
      try {
        if (result['status'] == "success") {
          showToast(
            result['status'],
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PaymentScreen(
                  orderid: result['orderid'],
                  name: result['username'],
                  amt: result['amount'],
                );
              },
            ),
          );
        } else {
          showToast(
            result['status'],
          );
        }
      } catch (e) {
        //await progressDialog.hide();
      }
    });
  }
}
