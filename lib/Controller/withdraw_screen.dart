import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/Controller/home_page_screen.dart';
import 'package:opal_money/Controller/my_wallet.dart';
import 'package:opal_money/Controller/withdraw_sucess.dart';

import '../Common/constants.dart';

class WithDrawScreen extends StatefulWidget {

  const WithDrawScreen({Key key}) : super(key: key);

  @override
  State<WithDrawScreen> createState() => _WithDrawScreenState();
}

class _WithDrawScreenState extends State<WithDrawScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
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
                  return const
                  MyWalletScreen();
                },
              ),
              );
            },
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

      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 10, top: 100, bottom: 5),

        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Container(
                height: 550,
                width: 400,
                color: themeColor,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      child: Image.asset("assets/images/withdrawback.png",
                        fit: BoxFit.fill,

                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 40, top: 30, bottom: 20),
                        child: Image.asset("assets/images/withdramsg.png",)),
                    Positioned(
                      top: 100,
                      right: 160,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                               return const MyWalletScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(45),

                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Roboto",
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 100,
                      right: 50,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const WithDrawSucessScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 90,
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
                                  "Ok",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
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
                    ),


                  ],

                ),
              ),
            //  Center(child: Image.asset("assets/images/withdraw_success.png",height: size.height*0.4,width: size.width*0.9,)),
            ],
          ),
        ),
      ),
    );
  }
}



