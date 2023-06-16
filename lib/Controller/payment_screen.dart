import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:opal_money/Utils/loader.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toast/toast.dart';
import '../ApiService/payment_api.dart';
import '../ApiService/secret_key_api.dart';
import '../Common/constants.dart';
import '../Utils/toast.dart';

class PaymentScreen extends StatefulWidget {
  String name = '';
  String orderid = '';
  String amt = '';
  String consultancyId = '';
  String screen = '';

  PaymentScreen(
      {Key key,
      this.orderid,
      this.name,
      this.amt,
      this.screen,
      this.consultancyId})
      : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool back = true;
  String secret = '';
 String orderId ='';
  Map<String, dynamic> paymentIntentData;

  @override
  void initState() {
    super.initState();
  paymentSuccess(widget.orderid);
  }

  razorPay() {
    Razorpay razorpay = Razorpay();
    var options = {
      'key': secret,
      'order_id':orderId,
      'amount': calculateAmount(widget.amt),
      'name': 'OpalMoney',
      'description': '',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
    );
    // return WillPopScope(
    //   onWillPop: () async => true,
    //   child: Scaffold(
    //     backgroundColor: themeColor,
    //     appBar: AppBar(
    //       centerTitle: true,
    //       elevation: 0,
    //       backgroundColor: Colors.white,
    //       leading: Builder(
    //         builder: (context) => IconButton(
    //           icon: const Icon(
    //             Icons.arrow_back,
    //             size: 26,
    //             color: Colors.transparent,
    //           ),
    //           onPressed: () {
    //             // Navigator.pop(context);
    //           },
    //         ),
    //       ),
    //       title: const Text(
    //         "Payment",
    //         style: TextStyle(
    //             color: Colors.black,
    //             fontWeight: FontWeight.w500,
    //             fontSize: 16.0,
    //             fontFamily: "Poppins"),
    //       ),
    //     ),
    //     body: Container(
    //       height: size.height,
    //       width: size.width,
    //       color: Colors.white,
    //       child: Center(
    //         child: TextButton(
    //           onPressed:
    //               () async {
    //
    //           },
    //           child: Container(
    //             height: 45,
    //             width: size.width * 0.7,
    //             decoration: BoxDecoration(
    //               color: themeColor,
    //               borderRadius: BorderRadius.circular(45),
    //             ),
    //             child: const Center(
    //               child: Text(
    //                 "Pay Now",
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.w400,
    //                   fontFamily: "Roboto",
    //                   color: Colors.white,
    //                   fontSize: 16,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  paymentSuccess(String id) {
    if (widget.screen != 'jobconsultancy') {
      PaymentApiService.paymentApiCall(
              context, widget.name, widget.orderid, widget.amt, id)
          .then((value) {
        setState(() {
          orderId = value['order_id'];
        });
        RazorkeyApiService.secretkeyApiCall(context).then((value) {
          setState(() {
            secret = value['key'];
          });
          razorPay();
        });

      });
    } else {
      PaymentApiService.jobApiCall(
        context,
        widget.consultancyId,
        widget.amt,
      ).then((value) {
        setState(() {
          orderId = value['order_id'];
        });
        RazorkeyApiService.secretkeyApiCall(context).then((value) {
          setState(() {
            secret = value['key'];
          });
          razorPay();
        });

      });
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */

    _version(context);
    //paymentSuccess(response.paymentId);

    // showAlertDialog(
    //     context, "Payment Successful", "Payment ID: ${response.paymentId}");
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
      type: AlertType.success,
      title: "Payment Success",
      desc: "Your payment is successful",
      buttons: [
        DialogButton(
          color: themeColor,
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ],
    ).show().then((value) {
      // print('kkkkkkkkk');
    });
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((value) {
      // cntrl.loader.value = true;
      // cntrl.examCourse().then((value) {
      //   if (value['status'] == 1) {
      //
      //   }
      // });
    });
  }
}
//
//   Future<void> makePayment() async {
//     try {
//       paymentIntentData = await createPaymentIntent(widget.amt, 'INR');
//
//       //json.decode(response.body);
//       //print('Response body==>${response.body.toString()}');
//       await Stripe.instance
//           .initPaymentSheet(
//               paymentSheetParameters: SetupPaymentSheetParameters(
//                   paymentIntentClientSecret: paymentIntentData['client_secret'],
//                   // applePay: const PaymentSheetApplePay(
//                   //   merchantCountryCode: 'IN',
//                   // ),
//                   googlePay: const PaymentSheetGooglePay(
//                     merchantCountryCode: 'IN',
//                     testEnv: true,
//                   ),
//
//                   // applePay: true,
//                   // googlePay: true,
//                   // testEnv: true,
//                   // style: ThemeMode.dark,
//                   // merchantCountryCode: 'IND',
//                   merchantDisplayName: 'OpalMoney'))
//           .then((value) {});
//
//       ///now finally display payment sheeet
//       displayPaymentSheet();
//     } catch (e, s) {
//       print('exception:$e$s');
//     }
//   }
//
//   displayPaymentSheet() async {
//     try {
//       await Stripe.instance
//           .presentPaymentSheet(
//               parameters: PresentPaymentSheetParameters(
//
//         clientSecret: paymentIntentData['client_secret'],
//         confirmPayment: true,
//       ))
//           .then((newValue) {
//         print('payment intent${paymentIntentData['id']}');
//         print('payment intent${paymentIntentData['client_secret']}');
//         print('payment intent${paymentIntentData['amount']}');
//         print('payment intent$paymentIntentData');
//         //orderPlaceApi(paymentIntentData!['id'].toString());
//         ScaffoldMessenger.of(context)
//             .showSnackBar(const SnackBar(content: Text("paid successfully")));
//         paymentSuccess(paymentIntentData['id'].toString());
//         paymentIntentData = null;
//       }).onError((error, stackTrace) {
//         setState(() {
//           back = true;
//         });
//         print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
//         showToast('Cancelled', );
//       });
//     } on StripeException catch (e) {
//       print('Exception/DISPLAYPAYMENTSHEET==> $e');
//       setState(() {
//         back = true;
//       });
//       showToast('Cancelled',);
//     } catch (e) {
//       setState(() {
//         back = true;
//       });
//       print('$e');
//     }
//   }
//
//   //  Future<Map<String, dynamic>>
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//         'payment_method_types[]': 'card'
//       };
//       print(body);
//       var response = await http.post(
//           Uri.parse('https://api.stripe.com/v1/payment_intents'),
//           body: body,
//           headers: {
//             'Authorization':
//                 'Bearer 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',
//
//             ///'sk_test_51Lr5DwSFsBDs6QSDvQfuSHiKc3aGHuSPl5iEK2IYy3wFqulCJrodqHtr7OJOzebIy0ZM8AFZpdh5dFUrooL1TuGE00jCJtPeDh',
//             ///live
//             //'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',
//             ///
//             'Content-Type': 'application/x-www-form-urlencoded'
//           });
//       setState(() {
//         back = true;
//       });
//       print('Create Intent reponse ===> ${response.body.toString()}');
//       return jsonDecode(response.body);
//     } catch (err) {
//       setState(() {
//         back = true;
//       });
//       print('err charging user: ${err.toString()}');
//     }
//   }
//
//   calculateAmount(String amount) {
//     final a = (int.parse(amount)) * 100;
//     return a.toString();
//   }
//

// }
