import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/Common/constants.dart';
import 'package:opal_money/Controller/my_account.dart';
import 'package:opal_money/Controller/my_wallet.dart';

import 'home_page_screen.dart';

class UpdateMyAccountScreen extends StatefulWidget {
  const UpdateMyAccountScreen({Key key}) : super(key: key);

  @override
  State<UpdateMyAccountScreen> createState() => _UpdateMyAccountScreenState();
}

class _UpdateMyAccountScreenState extends State<UpdateMyAccountScreen> {
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
        //       radius:13.0,
        //       backgroundColor: themeColor,
        //       backgroundImage: AssetImage(
        //         "assets/images/profile_img.png",
        //       ),
        //     ),
        //   ),
        //
        // ],
      ),


     // bottomNavigationBar:bottomNav(),


      body: Container(
        height: size.height,
        width: size.width,
        color: themeColor,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0,bottom:20,left: 10,right: 10 ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  child: Container(
                    height: size.height*0.75,
                    width: size.width,
                    color: Colors.white,

                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 20.0,bottom: 20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            SizedBox(
                              height: 140,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Hi Admin !",
                                        style: TextStyle(
                                          color:themeColor,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 26.0,
                                        ),
                                      ),
                                      Image.asset("assets/images/edit_icon.png",height: 22,width: 22,),
                                    ],
                                  ),
                                  const SizedBox(height: 20,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Stack(
                                              children:[
                                                const CircleAvatar(
                                                  radius:40.0,
                                                  backgroundColor: themeColor,
                                                  backgroundImage: AssetImage(
                                                    "assets/images/profile_img.png",
                                                  ),
                                                ),
                                                Positioned(

                                                  top: 60,
                                                  left: 50,
                                                  child: Image.asset("assets/images/plus_rounded.png",height: 20,width: 25,
                                                  ),
                                                ),
                                              ],
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:20.0,left: 50),
                                        child: Column(
                                          children: const [
                                            Text("+91 7678975789",
                                            style: TextStyle(
                                              color: themeColor,
                                              fontWeight: FontWeight.w300,
                                              fontFamily: "Roboto",
                                              fontSize: 14,
                                            ),),
                                            SizedBox(height: 10,),
                                            Text("code: OM/A001",
                                              style: TextStyle(
                                                color: themeColor,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Roboto",
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                const SizedBox(height: 20,),

                                TextFormField(

                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600),
                                    decoration:  InputDecoration(
                                      hintText: "Name",
                                      hintStyle: const TextStyle(
                                          fontFamily: "Poppins",
                                          color: Colors.black26,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w300),
                                      fillColor:greyColor,
                                      filled: true,
                                      counterText: "",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                    maxLength: 30
                                ),

                                const SizedBox(height: 20,),

                                TextFormField(

                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600),
                                    decoration:  InputDecoration(
                                      hintText: "Mobile No",
                                      hintStyle: const TextStyle(
                                          fontFamily: "Poppins",
                                          color: Colors.black26,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w300),
                                      fillColor:greyColor,
                                      filled: true,
                                      counterText: "",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.phone,
                                    maxLength: 10
                                ),

                                const SizedBox(height: 20,),

                                TextFormField(

                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600),
                                    decoration:  InputDecoration(
                                      hintText: "Email",
                                      hintStyle: const TextStyle(
                                          fontFamily: "Poppins",
                                          color: Colors.black26,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w300),
                                      fillColor:greyColor,
                                      filled: true,
                                      counterText: "",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    maxLength: 50
                                ),

                                const SizedBox(height: 20,),

                                TextFormField(

                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                  decoration:  InputDecoration(
                                    hintText: "Message",
                                    hintStyle: const TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.black26,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w300),
                                    fillColor:greyColor,
                                    filled: true,
                                    counterText: "",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                  maxLength: 200,
                                  maxLines: 3,
                                ),
                                const SizedBox(height: 70,),

                                TextButton(
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const MyAccountScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 45,
                                    width: size.width*0.7,
                                    decoration: BoxDecoration(
                                      color: themeColor,
                                      borderRadius: BorderRadius.circular(45),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Update",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Roboto",
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),

                                      ),
                                    ),
                                  ),
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
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomNav(){
    return BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        selectedLabelStyle: const TextStyle(color: themeColor),
        unselectedLabelStyle: const TextStyle(color: themeColor),
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: (){
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
                child: Image.asset("assets/images/home_outlined.png",color: themeColor,height: 22,width: 22,),
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(

            icon: GestureDetector(
              onTap: (){
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
                child: Image.asset("assets/images/wallet_icon.png",color: themeColor,height: 22,width: 22,),
              ),
            ),
            label: "Wallet",
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: (){},
              child: Padding(
                padding: const EdgeInsets.only(bottom:5.0),
                child: Image.asset("assets/images/notification_theme.png",color: themeColor,height: 22,width: 22,),
              ),
            ),
            label: "Notifications",

          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: (){
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
                padding: const EdgeInsets.only(bottom:5.0),
                child: Image.asset("assets/images/account_nav.png",color: themeColor,height: 22,width: 22,),
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
