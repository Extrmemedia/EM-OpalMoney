import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/Controller/home_page_screen.dart';
import 'package:opal_money/Controller/my_wallet.dart';
import 'package:toast/toast.dart';

import '../ApiService/withdrawApiService.dart';
import '../Common/constants.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import '../Utils/toast.dart';

class WithDrawSucessScreen extends StatefulWidget {
  final String userid;
  final String status;
  final String message;
  const WithDrawSucessScreen({Key key, this.userid, this.status, this.message})
      : super(key: key);

  @override
  State<WithDrawSucessScreen> createState() => _WithDrawSucessScreenState();
}

class _WithDrawSucessScreenState extends State<WithDrawSucessScreen> {
  String _message = '';

  @override
  void initState() {
    super.initState();
    withdrawApiCall();
  }


  withdrawApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        apiWithdrawFunc();
      } else {
        showToast("Please check your internet connection");

        return;
      }
    });
  }

  apiWithdrawFunc() {
    String user_id = Global.shared.userId;
    print("user_id $user_id");

    WithdrawApiService.withdrawApiCall(context, user_id).then((result) async {
      try {
        setState(() {
          _message = result['message'].toString();
          print('dddd' + _message.toString());
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const MyWalletScreen();
                  },
                ),
              );
            },
          ),
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
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),

         child: Center(
              child:  Container(
            height: 400,
            width: 300,
            color: themeColor,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  child: Image.asset("assets/images/withdrawsuccs.png",
                    fit: BoxFit.fill,

                  ),
                ),
                // Padding(
                //     padding: EdgeInsets.only(left: 100,bottom: 50, ),
                //     child: Image.asset("assets/images/withdrawsucs2.png",)),


              ],

            ),
          ),),

      ),
    );
  }
}
