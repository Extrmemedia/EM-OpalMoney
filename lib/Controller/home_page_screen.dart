import 'package:flutter/material.dart';
import 'package:opal_money/ApiService/live_url_api.dart';
import 'package:opal_money/Common/constants.dart';
import 'package:opal_money/Controller/about_us_screen.dart';
import 'package:opal_money/Controller/contact_us.dart';
import 'package:opal_money/Controller/incentive_business_structure_screen.dart';


import 'package:opal_money/Controller/my_business_screen.dart';
import 'package:opal_money/Controller/my_profile.dart';
import 'package:opal_money/Controller/my_referral_income.dart';
import 'package:opal_money/Controller/my_wallet.dart';
import 'package:opal_money/Controller/recharges/mobile/recharge_screen.dart';

import 'package:opal_money/Controller/update_my_account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


import '../Model/ModelLogin.dart';

import 'dashboard_screen.dart';
import 'login_screen.dart';
import 'notification.dart';
import 'recharges/recharge_home.dart';

class HomePageScreen extends StatefulWidget {
  final String userid;
  final String agent;
  const HomePageScreen({Key, this.userid, this.agent}) : super();

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  String token;
  int userId;
  String url='';
  ModelLogin modelLogin;
  final GlobalKey<FormState> _formKey = GlobalKey();
  int i = 0;
   List<Widget> _widgetOptions = <Widget> [const Dashboard(), const MyWalletScreen(),const NotificationScreen(), const MyProfileScreen()];
  @override
  void initState() {
    super.initState();

    urlApi();
  }
  urlApi() {
    UrlApiService.urlApiCall(context).then((value) {
      setState(() {
        url = value['data'][0]['link'].toString();
        print('url  '+url);
      });



    });

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themeColor,
      appBar: i==0? AppBar(
        toolbarHeight: 80,
        titleSpacing: 5,
        shadowColor: const Color(0xFF0105FC),
        automaticallyImplyLeading: false,
        elevation: 20,
        backgroundColor: themeColor,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              size: 37,
              color: Colors.white70,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Image.asset(
            "assets/images/logo_trans.png",
            height: 100,
            width: size.width * 0.5,
          ),
        ),
        actions: [
          InkWell(
            onTap: (){
              print(url);
              String _url = 'https://www.mcxindia.com/market-data/market-watch';
              _launchURL(url);

            },
            child: Image.asset(
              "assets/images/live_new.jpg",
              height: 30,
              width: 40,
              fit: BoxFit.contain,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ContactusScreesn();
                  },
                ),
              );
            },
            child:  Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Container(),
              // child: CircleAvatar(
              //   radius: 13.0,
              //   backgroundColor: themeColor,
              //   backgroundImage: AssetImage(
              //     "assets/images/profile_img.png",
              //   ),
              // ),
            ),
          ),
        ],
      ):null,
      drawer: menuNav(),
      bottomNavigationBar: bottomNav(),
      body: Center(child:_widgetOptions.elementAt(i)),
    );
  }

  void _launchURL(String _url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';


  Widget menuNav() {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0)),
        color: themeColor,
        border: Border.all(
          width: 2.0,
          // assign the color to the border color
          color: Colors.white,
        ),
      ),
      height: size.height/1.6,
      width: size.width/1.6,
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12)),
        ),
        backgroundColor: themeColor,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Scrollbar(

              child: ListView(
                
                padding: const EdgeInsets.only(top: 58.0,right: 45.0,bottom: 10.0),
                children: [

                  ListTile(

                    title: const Text(
                      'Personal Details',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    visualDensity: const VisualDensity(vertical: 0.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const MyProfileScreen();
                          },
                        ),
                      );
                    },
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 0.2,
                    thickness: 0.2,
                  ),
                  ListTile(
                    title: const Text(
                      'Wallet',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    visualDensity: const VisualDensity(vertical: 0.0),
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
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 0.2,
                    thickness: 0.2,
                  ),

                  ListTile(
                    title: const Text(
                      'Recharge',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    visualDensity: const VisualDensity(vertical: 0.0),
                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return  const RechargeHome();
                          },
                        ),
                      );


                    },
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 0.2,
                    thickness: 0.2,
                  ),

                  ListTile(
                    title: const Text(
                      'Business structure',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    visualDensity: const VisualDensity(vertical: 0.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const IncentiveBusinessStructureScreen();
                          },
                        ),
                      );
                    },
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 0.2,
                    thickness: 0.2,
                  ),

                  ListTile(
                    title: const Text(
                      'My Business',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    visualDensity: const VisualDensity(vertical: 0.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const MyBusinessScreen();
                          },
                        ),
                      );
                    },
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 0.2,
                    thickness: 0.2,
                  ),

                  ListTile(
                    title: const Text(
                      'My Referral income',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    visualDensity: const VisualDensity(vertical: 0.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const MyReferralIncomeScreen();
                          },
                        ),
                      );
                    },
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 0.2,
                    thickness: 0.2,
                  ),

                  ListTile(
                    title: const Text(
                      'About us',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    visualDensity: const VisualDensity(vertical: 0.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const AboutUsScreen();
                          },
                        ),
                      );
                    },
                  ),
                  // const Divider(color: themeColor,height: 0.2,thickness: 0.2,),
                  // ListTile(
                  //   title: const Text('Settings',style: TextStyle(color: themeColor,fontFamily: "Roboto",fontSize: 16,fontWeight: FontWeight.w400),),
                  //   visualDensity: const VisualDensity(vertical: 1),
                  //   onTap: () {
                  //     Navigator.push(context,
                  //       MaterialPageRoute(builder: (context){
                  //         return const RechargeScreen();
                  //       },
                  //       ),
                  //     );
                  //   },
                  // ),
                  const Divider(
                    color: Colors.white,
                    height: 0.2,
                    thickness: 0.2,
                  ),

                  ListTile(
                    title: const Text(
                      'Contact',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    visualDensity: const VisualDensity(vertical: 0.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const ContactusScreesn();
                          },
                        ),
                      );
                    },
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 0.5,
                    thickness: 0.2,
                  ),

                  ListTile(
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Roboto",
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    visualDensity: const VisualDensity(vertical: 0.0),
                    onTap: () async {
                      // LoginScreen()
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      await pref.clear();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                  // const Divider(
                  //   color: Colors.white,
                  //   height: 0.5,
                  //   thickness: 0.2,
                  // ),
                ],
              ),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.clear,color: Colors.white,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child:

                    Image.asset(
                      "assets/images/settings.png",
                      color: Colors.white,
                      height: 25,
                      width: 25,
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }


  Widget bottomNav() {
    return BottomNavigationBar(

        onTap: (index) {
          setState(() {
            i = index;
            print(i);
          });
        },

        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        selectedLabelStyle: const TextStyle(color: themeColor),
        unselectedLabelStyle: const TextStyle(color: themeColor),

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Image.asset(
                i==0?  "assets/images/home.png":"assets/images/home_outlined.png",
                color: themeColor,
                height: 22,
                width: 22,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Image.asset(
               i==1? "assets/images/wallet_nav.png":"assets/images/wallet_icon.png",
                color: themeColor,
                height: 22,
                width: 22,
              ),
            ),
            label: "Wallet",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Image.asset(
                "assets/images/notification_theme.png",
                color: themeColor,
                height: 22,
                width: 22,
              ),
            ),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Image.asset(
               i==3? "assets/images/account_nav.png":"assets/images/my_account.png",
                color: themeColor,
                height: 22,
                width: 22,
              ),
            ),
            label: "My Profile",
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: i,
        backgroundColor: Colors.white,
        iconSize: 30,
        //onTap: _onItemTapped,
        selectedItemColor: themeColor,
        unselectedItemColor: Colors.grey[500],
        elevation: 20);
  }

// Widget registration(){
//   Padding(
//     padding: const EdgeInsets.only(top:10.0,bottom: 10,left: 10,right: 10),
//     child: GestureDetector(
//       onTap: (){
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
//           return const MyWalletScreen();
//         }));
//       },
//       child: Container(
//         height: 170,
//         //width: size.width,
//         color: themeColor,
//         child: Stack(
//           children: [
//             Card(
//               elevation: 2.0,
//               shadowColor: themeColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(20.0),
//                 ),
//                 child: Image.asset("assets/images/regback.png",
//                   fit: BoxFit.fill,
//
//                 ),
//               ),
//             )
//
//           ],
//
//         ),
//
//       ),
//     ),
//   );
// }

}
