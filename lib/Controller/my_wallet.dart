import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/Common/constants.dart';
import 'package:opal_money/Controller/home_page_screen.dart';
import 'package:opal_money/Controller/reference_overview.dart';
import 'package:opal_money/Controller/update_my_account.dart';
import 'package:opal_money/Controller/withdraw_history.dart';
import 'package:opal_money/Controller/withdraw_screen.dart';
import 'package:toast/toast.dart';

import '../ApiService/mywalletApiService.dart';
import '../Utils/Connectivity.dart';
import '../Utils/toast.dart';
import 'contact_us.dart';
import 'my_account.dart';

class MyWalletScreen extends StatefulWidget {
  final String userid;
  final String status;
  final int earnings;
  final int balance;
  final int reffered;
  final int pending;
  final int rejected;
  final int completed;
  const MyWalletScreen(
      {Key,
      this.userid,
      this.status,
      this.earnings,
      this.balance,
      this.reffered,
      this.pending,
      this.rejected,
      this.completed})
      : super();

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  String status = '';
  String _earnings = '';
  String _balance = '';
  String _reffered = '';
  String _pending = '';
  String _rejected='';
  String _completed='';

  @override
  void initState() {
    super.initState();
    mywalletApiCall();
  }



  mywalletApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        apiFunc();
      } else {
        showToast("Please check your internet connection",
          );

        return;
      }
    });
  }

  apiFunc() {
    MyWalletApiService.mywalletApiCall(context, widget.userid)
        .then((result) async {
      try {

      //  earnings = result['earnings'].toString();
        setState(() {

          _earnings = result['earnings'].toString();
          print('dddd'+_earnings.toString());
          _balance = result['balance'].toString();
          _reffered= result['reffered'].toString();
           _pending = result['pending'].toString();
          _rejected = result['rejected'].toString();
          _completed= result['completed'].toString();
       });

       // return _earnings;
      } catch (e) {
        //await progressDialog.hide();
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
                );
              },
            ),
          ),
          title: const Text(
            "My Wallet",
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
        backgroundColor: themeColor,
       // bottomNavigationBar: bottomNav(),
        body: Container(
          color: themeColor,
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        child: Container(
                          height: 220,
                          width: size.width,
                          color: Colors.white,
                          child: Stack(
                            children: [
                              const Positioned(
                                top: 30,
                                left: 20,
                                child: Text(
                                  "Total Earnings",
                                  style: TextStyle(
                                    color: themeColor,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 20,
                                right: 10,
                                child: Image.asset(
                                  "assets/images/gold_coin.png",
                                  height: 70,
                                  width: 80,
                                ),
                              ),
                               Positioned(
                                top: 60,
                                left: 20,
                                child: Text(
                                    "\u{20B9}"+ _earnings,
                                  style: TextStyle(
                                    color: Color(0xFF0F7F08),
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 22.0,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 100,
                                right: 10,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const WithDrawScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: themeColor,
                                      borderRadius: BorderRadius.circular(45),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Withdraw",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontFamily: "Roboto",
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 160,
                                right: 10,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const WithdrawHistoryScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: themeColor,
                                      borderRadius: BorderRadius.circular(45),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "History",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontFamily: "Roboto",
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 100,
                                  child: Container(
                                    width: size.width,
                                    height: 1.0,
                                    color: Colors.grey,
                                  )),
                              const Positioned(
                                top: 120,
                                left: 20,
                                child: Text(
                                  "Withdraw",
                                  style: TextStyle(
                                    color: themeColor,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                               Positioned(
                                top: 150,
                                left: 20,
                                child: Text(
                                  "\u{20B9}"+ _balance,
                                  style: TextStyle(
                                    color: Color(0xFF0F7F08),
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 22.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ReferenceOverview(id: "2");
                                },
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              child: Center(
                                child: SizedBox(
                                  height: 90,
                                  width: size.width * 0.45,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children:  [
                                        const Text(
                                          "Referred",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Roboto",
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          _reffered.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Roboto",
                                              fontSize: 25.0,
                                              color: Colors.blue),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ReferenceOverview(id: "3");
                                },
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              child: Center(
                                child: SizedBox(
                                  height: 90,
                                  width: size.width * 0.45,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children:  [
                                        const Text(
                                          "Inprogress",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Roboto",
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          _pending.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Roboto",
                                              fontSize: 25.0,
                                              color: Colors.lime),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ReferenceOverview(id: "4");
                                },
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              child: Center(
                                child: SizedBox(
                                  height: 90,
                                  width: size.width * 0.45,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children:  [
                                        const Text(
                                          "Dropped",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Roboto",
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          _rejected.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Roboto",
                                              fontSize: 25.0,
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ReferenceOverview(id: "5");
                                },
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              child: Center(
                                child: SizedBox(
                                  height: 90,
                                  width: size.width * 0.45,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children:  [
                                        const Text(
                                          "Converted",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Roboto",
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          _completed.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Roboto",
                                              fontSize: 22.0,
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const ReferenceOverview(id: "1");
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: const Color(0xFF174F78),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: const Center(
                      child: Text(
                        "Reference Overview",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ));
  }

  Widget bottomNav() {
    return BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        selectedLabelStyle: const TextStyle(color: themeColor),
        unselectedLabelStyle: const TextStyle(color: themeColor),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const HomePageScreen();
                    },
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Image.asset(
                  "assets/images/home_outlined.png",
                  color: themeColor,
                  height: 22,
                  width: 22,
                ),
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const MyWalletScreen();
                    },
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Image.asset(
                  "assets/images/wallet_nav.png",
                  color: themeColor,
                  height: 22,
                  width: 22,
                ),
              ),
            ),
            label: "Wallet",
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Image.asset(
                  "assets/images/notification_theme.png",
                  color: themeColor,
                  height: 22,
                  width: 22,
                ),
              ),
            ),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const UpdateMyAccountScreen();
                    },
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Image.asset(
                  "assets/images/my_account.png",
                  color: themeColor,
                  height: 22,
                  width: 22,
                ),
              ),
            ),
            label: "My Account",
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        backgroundColor: Colors.white,
        iconSize: 30,
        //onTap: _onItemTapped,
        selectedItemColor: themeColor,
        unselectedItemColor: Colors.grey[500],
        elevation: 20);
  }
}
