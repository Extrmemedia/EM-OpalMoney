import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/Common/constants.dart';
import 'package:opal_money/Utils/loader.dart';
import 'package:toast/toast.dart';

import '../ApiService/contactusApiService.dart';
import '../Model/ModelContactus.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import '../Utils/toast.dart';
import 'enquirysuccess_screen.dart';
import 'home_page_screen.dart';

class ContactusScreesn extends StatefulWidget {
  const ContactusScreesn({Key key}) : super(key: key);

  @override
  State<ContactusScreesn> createState() => _ContactusScreesnState();
}

class _ContactusScreesnState extends State<ContactusScreesn> {
  var nameTextController = TextEditingController();
  var mobileTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var messageTextController = TextEditingController();
  ModelContactus modelContactus;

  ContactusFormApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();

        contactusform();
      } else {
        showToast(
          "Please check your internet connection",
        );

        return;
      }
    });
  }

  void contactusform() {
    print("ID${Global.shared.id}");
    print("name${nameTextController.text}");
    print("mobile${mobileTextController.text}");
    print("email${emailTextController.text}");
    ContactusFormApiService.ContactusFormApiCall(
      context,
      Global.shared.id,
      nameTextController.text,
      mobileTextController.text,
      emailTextController.text,
      messageTextController.text,
    ).then((model) async {
      try{
      if (model.success=='true') {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return  EnquirySucessScreen(screenType: 'enquiry',);
            },
          ),
        );
      }else{
        Navigator.pop(context);
        showToast(
          model.message.toString(),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      showToast(
        model.message.toString(),
      );
      print(e);
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
                    return const HomePageScreen();
                  },
                ),
              );
            },
          ),
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
      body: Container(
        height: size.height,
        width: size.width,
        color: themeColor,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 20, left: 10, right: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  child: Container(
                    height: size.height * 0.8,
                    width: size.width,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 30.0, bottom: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Contact Us",
                              style: TextStyle(
                                  color: themeColor,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Roboto"),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                  controller: nameTextController,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                    hintText: "Name",
                                    hintStyle: const TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.black54,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w300),
                                    fillColor: greyColor,
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
                                  maxLength: 30),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                  controller: mobileTextController,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                    hintText: "Mobile No",
                                    hintStyle: const TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.black54,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w300),
                                    fillColor: greyColor,
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
                                  maxLength: 10),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                  controller: emailTextController,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: const TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.black54,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w300),
                                    fillColor: greyColor,
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
                                  maxLength: 50),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: messageTextController,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                hintText: "Message",
                                hintStyle: const TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.black54,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w300),
                                fillColor: greyColor,
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
                              maxLines: 4,
                            ),
                            const SizedBox(
                              height: 70,
                            ),
                            TextButton(
                              onPressed: () {
                                if (nameTextController.text.isEmpty) {
                                  showToast(
                                      'Add name');
                                } else if (mobileTextController.text.isEmpty||
                                    mobileTextController.text.length < 10) {
                                  showToast(
                                      'Add mobile number');
                                }  else if (emailTextController
                                    .text.isEmpty ||
                                    !emailTextController.text
                                        .contains('@') ||
                                    !emailTextController.text
                                        .contains('.')) {
                                  showToast(
                                      'Add valid email');
                                } else if (messageTextController.text.isEmpty) {
                                  showToast(
                                      'Add message');
                                } else {
                                  loader(context);
                                  ContactusFormApiCall();
                                }
                              },
                              child: Container(
                                height: 45,
                                width: size.width * 0.7,
                                decoration: BoxDecoration(
                                  color: themeColor,
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Submit",
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
}
