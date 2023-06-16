import 'package:flutter/material.dart';

import '../../Common/constants.dart';
import 'dth/dth_screen.dart';
import 'electricity/electricity_screen.dart';
import 'gas/gas_screen.dart';
import 'insurance/insurance_screen.dart';
import 'mobile/recharge_screen.dart';

class RechargeHome extends StatefulWidget {
  const RechargeHome({Key key}) : super(key: key);

  @override
  State<RechargeHome> createState() => _RechargeHomeState();
}

class _RechargeHomeState extends State<RechargeHome> {
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
        title: const Text(
          "Recharge",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              fontFamily: "Poppins"),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                        return const RechargeScreen();
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
                        child: const Center(
                          child: Text(
                            "Recharge",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontSize: 18.0,
                            ),
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
                        return const DthScreen();
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
                        child: const Center(
                          child: Text(
                            "DTH",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontSize: 18.0,
                            ),
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
                        return const Insurance();
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
                        child: const Center(
                          child: Text(
                            "Insurance",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontSize: 18.0,
                            ),
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
                        return const Electricity();
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
                        child: const Center(
                          child: Text(
                            "Electricity",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontSize: 18.0,
                            ),
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
                        return const Gas();
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
                        child: const Center(
                          child: Text(
                            "Gas",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Card(
                  elevation: 0,
                  color: Colors.transparent,
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
                        child: const Center(
                          // child:
                          // Text(
                          //   "Fastag",
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.w400,
                          //     fontFamily: "Roboto",
                          //     fontSize: 18.0,
                          //   ),
                          // ),
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
        ],
      ),
    );
  }
}
