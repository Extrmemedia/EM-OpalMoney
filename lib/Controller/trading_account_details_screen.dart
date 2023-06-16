import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:opal_money/Common/constants.dart';
import 'package:opal_money/Controller/home_page_screen.dart';
import 'package:toast/toast.dart';

import '../ApiService/tr_ac_details_api.dart';
import '../Model/trading_ac_details_mdl.dart';
import '../Utils/html_trimmer.dart';
import '../Utils/toast.dart';

class TradingAccountDetailsScreen extends StatefulWidget {
  const TradingAccountDetailsScreen({Key key}) : super(key: key);

  @override
  State<TradingAccountDetailsScreen> createState() =>
      _TradingAccountDetailsScreenState();
}

class _TradingAccountDetailsScreenState
    extends State<TradingAccountDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCall();
  }

  List<TrAcDetails> details = [];

  apiCall() {
    TrAcApiService.tracApiCall(context).then((value) {
      if (value['status'] == '1') {
        setState(() {
          details = ((value["data"] ?? []) as List)
              .map((li) => TrAcDetails.fromJson(li))
              .toList();
        });
      } else {
        showToast(value['message'],);
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
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text(
          "Trading Account Details",
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
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          color: themeColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 20, left: 20, right: 20),
                  child: SizedBox(
                    height: 200,
                    width: size.width,
                    child: Card(
                      color: const Color(0xFFEAE7FF),
                      elevation: 2.0,
                      shadowColor: const Color(0xFFEAE7FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: details.isEmpty? "":baseURL + details[0].image,
                              placeholder: (context, url) => Container(),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: Text(
                                  'No Image',
                                  style: TextStyle(
                                      color: themeColor,
                                      fontSize: 14,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            )

                            // Image.network(imageUrl+details[0].image,
                            //
                            //   fit: BoxFit.fill,
                            //
                            // ),
                            ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 20, left: 20, right: 20),                  child: Html(
                    data: details.isEmpty?'':details[0].details,
                    defaultTextStyle:   const TextStyle(
                              color: Colors.white,
                              fontFamily:"Poppins",
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                            ),
linkStyle: const TextStyle(
              color: Colors.white,
              fontFamily:"Poppins",
              fontWeight: FontWeight.normal,
              fontSize: 14.0,
            ),
useRichText: false,
    //backgroundColor: Colors.white,
                  ),
                )
                // Text( trimHtmlContent(  details[0].details),
                //           style: const TextStyle(
                //             color: Colors.white,
                //             fontFamily:"Poppins",
                //             fontWeight: FontWeight.normal,
                //             fontSize: 14.0,
                //           ),)

                // Container(
                //   height: 50,
                //   child: Center(
                //     child: ListTile(
                //       minLeadingWidth: 5,
                //       leading:  bullet(),
                //       title: const Text('Equity, Commodity & Currency (3 in 1 account) with No account opening charge',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontFamily:"Poppins",
                //           fontWeight: FontWeight.normal,
                //           fontSize: 14.0,
                //         ),),
                //     ),
                //   ),
                // ),
                // ListTile(
                //   minLeadingWidth: 5,
                //   leading: bullet(),
                //   title:const Text('[3 in 1] trading account within 3 hour will get opened once submitted the correct proofs.',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontFamily:"Poppins",
                //       fontWeight: FontWeight.normal,
                //       fontSize: 14.0,
                //     ),),
                // ),
                //
                // ListTile(
                //   minLeadingWidth: 5,
                //   leading: bullet(),
                //   title:const Text('Mobile trading application @ free of cost.',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontFamily:"Poppins",
                //       fontWeight: FontWeight.normal,
                //       fontSize: 14.0,
                //     ),),
                // ),
                //
                // ListTile(
                //   minLeadingWidth: 5,
                //   leading: bullet(),
                //   title:const Text('Lowest Brokerage.',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontFamily:"Poppins",
                //       fontWeight: FontWeight.normal,
                //       fontSize: 14.0,
                //     ),),
                // ),
                //
                // ListTile(
                //   minLeadingWidth: 5,
                //   leading: bullet(),
                //   title:const Text('Online & Offline trading facility; for new traders online trading coaching facility provides.',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontFamily:"Poppins",
                //       fontWeight: FontWeight.normal,
                //       fontSize: 14.0,
                //     ),),
                // ),
                //
                //
                // ListTile(
                //   minLeadingWidth: 5,
                //   leading: bullet(),
                //   title:const Text('Providing back office software for contract note details, fund payout & Payin.',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontFamily:"Poppins",
                //       fontWeight: FontWeight.normal,
                //       fontSize: 14.0,
                //     ),),
                // ),
                //
                //
                // ListTile(
                //   minLeadingWidth: 5,
                //   leading: bullet(),
                //   title:const Text('Payout will be processed on the same day.',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontFamily:"Poppins",
                //       fontWeight: FontWeight.normal,
                //       fontSize: 14.0,
                //     ),),
                // ),
                //
                //
                // ListTile(
                //   minLeadingWidth: 5,
                //   leading: bullet(),
                //   title:const Text('Research calls and news we provide at free of cost with 80% accuracy through whatsapp and SMS.',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontFamily:"Poppins",
                //       fontWeight: FontWeight.normal,
                //       fontSize: 14.0,
                //     ),),
                // ),
                //
                //
                // ListTile(
                //   minLeadingWidth: 5,
                //   leading: bullet(),
                //   title:const Text('COVER ORDER AND BRACKET ORDER FACILITY ALSO AVAILABLE',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontFamily:"Poppins",
                //       fontWeight: FontWeight.normal,
                //       fontSize: 14.0,
                //     ),),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bullet() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 5.0,
        width: 5.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
