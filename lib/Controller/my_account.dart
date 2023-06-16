import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/Controller/update_my_account.dart';

import '../Common/constants.dart';
import 'home_page_screen.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
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
            icon: const Icon(Icons.arrow_back,size: 26,color: Colors.white70,),
            onPressed: () {
              Navigator.pushReplacement(context,  MaterialPageRoute(
                builder: (context) {
                  return const HomePageScreen();
                },
              ),
              );
            },
          ),
        ),

        title:const Text("My Account",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              fontFamily: "Poppins"

          ),
        ),
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(left: 10,right: 10),
        //     child: CircleAvatar(
        //       radius:15.0,
        //       backgroundColor: themeColor,
        //       backgroundImage: AssetImage(
        //         "assets/images/profile_img.png",
        //       ),
        //     ),
        //   ),
        //
        // ],
      ),

      // bottomNavigationBar:BottomNavigationBar(
      //     showSelectedLabels: true,
      //     showUnselectedLabels: true,
      //     selectedFontSize: 10,
      //     unselectedFontSize: 10,
      //     selectedLabelStyle: const TextStyle(color: themeColor),
      //     unselectedLabelStyle: const TextStyle(color: themeColor),
      //     items:  <BottomNavigationBarItem>[
      //       BottomNavigationBarItem(
      //         icon: GestureDetector(
      //           onTap: (){},
      //           child: Padding(
      //             padding: const EdgeInsets.only(bottom: 5.0),
      //             child: Image.asset("assets/images/home_outlined.png",color: themeColor,height: 22,width: 22,),
      //           ),
      //         ),
      //         label: "Home",
      //       ),
      //       BottomNavigationBarItem(
      //
      //         icon: GestureDetector(
      //           onTap: (){},
      //           child: Padding(
      //             padding: const EdgeInsets.only(bottom: 5.0),
      //             child: Image.asset("assets/images/wallet_icon.png",color: themeColor,height: 22,width: 22,),
      //           ),
      //         ),
      //         label: "Wallet",
      //       ),
      //       BottomNavigationBarItem(
      //         icon: GestureDetector(
      //           onTap: (){},
      //           child: Padding(
      //             padding: const EdgeInsets.only(bottom:5.0),
      //             child: Image.asset("assets/images/notification_theme.png",color: themeColor,height: 22,width: 22,),
      //           ),
      //         ),
      //         label: "Notifications",
      //
      //       ),
      //       BottomNavigationBarItem(
      //         icon: GestureDetector(
      //           onTap: (){
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) {
      //                   return const MyAccountScreen();
      //                 },
      //               ),
      //             );
      //           },
      //           child: Padding(
      //             padding: const EdgeInsets.only(bottom:5.0),
      //             child: Image.asset("assets/images/account_nav.png",color: themeColor,height: 22,width: 22,),
      //           ),
      //         ),
      //         label: "My Account",
      //
      //       ),
      //     ],
      //     type: BottomNavigationBarType.fixed,
      //     currentIndex: 0,
      //     backgroundColor: Colors.white,
      //     iconSize: 30,
      //     //onTap: _onItemTapped,
      //     selectedItemColor: themeColor,
      //     unselectedItemColor: Colors.grey[500],
      //     elevation: 20),



      body: Container(
        color: themeColor,
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0,left: 20,right: 20),
              child: Card(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  child: Container(
                    height: 280,
                    width: size.width,
                    color: Colors.white,
                    
                    child: Stack(
                      children: [
                        const Positioned(
                            top: 30,
                            left: 20,
                            child: Text("Hi Admin !",
                            style: TextStyle(
                              color:themeColor,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                              fontSize: 26.0,
                            ),
                            ),
                        ),

                        Positioned(
                          top: 30,
                          right: 20,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context){
                                    return const UpdateMyAccountScreen();
                                  }
                                  ),
                              );
                            },
                              child: Image.asset("assets/images/edit_icon.png",height: 30,width: 30,)),
                        ),

                        const Positioned(
                          top: 90,
                           left: 20,
                            child:CircleAvatar(
                              radius:50.0,
                              backgroundColor: themeColor,
                              backgroundImage: AssetImage(
                                "assets/images/profile_img.png",
                              ),
                            ),
                        ),
                        const Positioned(
                          top: 130,
                          right: 20,
                          child:Text("+91 7864578568",
                            style: TextStyle(color:themeColor,
                            fontSize: 20.0,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
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
      ),
      ),
    );
  }
}
