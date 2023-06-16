import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/Controller/updateprofile.dart';
import 'package:toast/toast.dart';

import '../ApiService/my_profile_api.dart';
import '../ApiService/occupationApiService.dart';
import '../Common/constants.dart';
import '../Model/ModelOccupation.dart';
import '../Model/profile_details_model.dart';
import '../Utils/toast.dart';
import 'home_page_screen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController mob = TextEditingController();
  final TextEditingController mail = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController addr = TextEditingController();
String deletePan;String deleteProof;String deletePhoto;
  String _selectedGender = 'Male',
      panCard,
      proof,
      photo,
      dob,
      profileImg = '',
      code = '',
      userType,
      joB = '';
  String dropdownValue = '';
  int usertypeId;
  String jobId;

  List<String> spinnerItems = ['Occupation', 'Two', 'Three', 'Four', 'Five'];
  List<Occupation> occupations = [];
  List<ProfileDetails> profileData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCall();
  }

  occupationList() {
    OccupationApiService.occupationApi(context).then((value) {
      if (value['success'] == true) {
        setState(() {
          occupations = ((value["data"] ?? []) as List)
              .map((li) => Occupation.fromJson(li))
              .toList();
          print(json.encode(occupations));
          print('job Id $jobId');
          if(jobId == 'null'){
            print('djdjdjdjdjdjdjdj');
            joB = 'Not Selected';
            jobId=occupations.first.id.toString();
          }else{
          for (var element in occupations) {
            if (element.id == int.parse(jobId)) {
              print('dddddddd');
              joB = element.occupation;
            } else {
              joB = 'Not Selected';
            }
          }}


          print('job data $joB');
        });
      } else {

      }
    });
  }

  apiCall() {
    MyProfileApiService.myProfileApiCall(context).then((value) {
      if (value['status'] == '1') {
        setState(() {
          profileData = ((value['data'] ?? []) as List)
              .map((li) => ProfileDetails.fromJson(li))
              .toList();

          if (value['profile_image'] == 'null') {

            profileImg = '';
          } else {
            profileImg = value['profile_image'].toString();
          }

          if (profileData.first.mycode == 'null') {
            code = '';
          } else {
            code = profileData.first.mycode;
          }

          if (profileData.first.name == 'null') {
            name.text = '';
          } else {
            name.text = profileData.first.name;
          }

          if (profileData.first.phno == 'null') {
            mob.text = '';
          } else {
            mob.text = profileData.first.phno;
          }

          if (profileData.first.email == 'null') {
            mail.text = '';
          } else {
            mail.text = profileData.first.email;
          }

          if (profileData.first.dob == 'null') {
            dob = '';
          } else {
            dob = profileData.first.dob;
          }
          if (profileData.first.age == 'null') {
            age.text = '';
          } else {
            age.text = profileData.first.age.toString();
          }

          if (profileData.first.occupation == 'null') {
            jobId = 'null';
          } else {
            jobId = profileData.first.occupation.toString();
          }

          if (profileData.first.gender == 0) {
            _selectedGender = 'Male';
          } else if (profileData.first.gender == 1) {
            _selectedGender = 'Female';
          } else {
            _selectedGender = 'Others';
          }
          usertypeId = int.parse(profileData.first.usertype);
          if (profileData.first.usertype == 0) {
            userType = 'part-time employee';
          } else if (profileData.first.usertype == 1) {
            userType = 'agent';
          } else {
            userType = 'user';
          }

          if (profileData.first.address == 'null') {
            addr.text = '';

          } else {
            addr.text = profileData.first.address;
          }
          if (profileData.first.pan == null) {
            panCard = 'null';
            deletePan='null';
          } else {
            deletePan = profileData.first.pan;
            panCard = profileData.first.pan;
          }
          if (profileData.first.aadhaar == null) {
            proof = 'null';
            deleteProof='null';
          } else {
            proof = profileData.first.aadhaar;
            deleteProof=profileData.first.aadhaar;
          }
          if (profileData.first.passportphoto == null) {
            photo = 'null';
            deletePhoto='null';
          } else {
            photo = profileData.first.passportphoto;
            deletePhoto= profileData.first.passportphoto;
          }
         print('pancard $panCard');
          print('proof $proof');
          print('photo $photo');
          occupationList();
        });
      } else {
        showToast(
          value['message'],
        );
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
              color: Colors.white,
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
          "My Profile",
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
      body: Container(
        height: size.height,
        width: size.width,
        color: themeColor,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 20, left: 2, right: 2),
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
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10, top: 20, bottom: 20),
                            child: Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 40.0,
                                          backgroundColor: themeColor,
                                          // backgroundImage: NetworkImage(
                                          //   imageUrl + profileImg,
                                          // ),
                                          child: CachedNetworkImage(
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.fill,
                                              imageUrl: baseURL + profileImg,
                                              placeholder: (context, url) =>
                                                  Container(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.person)),
                                        ),
                                        Positioned(
                                          top: 60,
                                          left: 50,
                                          child: Image.asset(
                                            "assets/images/plus_rounded.png",
                                            height: 20,
                                            width: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("rjrjrjrjrj ");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return UpdateProfileScreen(
                                            deletePan: deletePan,
                                            deletePhoto: deletePhoto,
                                            deleteProof: deleteProof,
                                            joB: joB,
                                            jobId: jobId,
                                            occupations: occupations,
                                            profileImg: profileImg,
                                            name: name.text,
                                            mob: mob.text,
                                            mail: mail.text,
                                            dob: dob,
                                            age: age.text,
                                            selectedGender: _selectedGender,
                                            addr: addr.text,
                                            gender: _selectedGender,
                                            userType: userType,
                                            panCard: panCard,
                                            userTypeId: usertypeId,
                                            proof: proof,
                                            photo: photo,
                                          );
                                        },
                                      ),
                                    ).then((value) => apiCall());
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: size.width * 0.84,
                                      ),
                                      Image.asset(
                                        "assets/images/edit_icon.png",
                                        height: 20,
                                        width: 25,
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: code == 'null' ? false : true,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Code : $code",
                                        style: const TextStyle(
                                            color: themeColor,
                                            fontSize: 16,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  height: 45,
                                  child: TextFormField(
                                      controller: name,
                                      enabled: false,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400),
                                      decoration: InputDecoration(
                                        hintText: "Name",
                                        hintStyle: const TextStyle(
                                            fontFamily: "Roboto",
                                            color: Colors.black54,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w300),
                                        fillColor: greyColor,
                                        filled: true,
                                        counterText: "",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                                      controller: mob,
                                      enabled: false,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400),
                                      decoration: InputDecoration(
                                        hintText: "Mobile No",
                                        hintStyle: const TextStyle(
                                            fontFamily: "Roboto",
                                            color: Colors.black54,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w300),
                                        fillColor: greyColor,
                                        filled: true,
                                        counterText: "",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                                      enabled: false,
                                      controller: mail,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400),
                                      decoration: InputDecoration(
                                        hintText: "Email ID",
                                        hintStyle: const TextStyle(
                                            fontFamily: "Roboto",
                                            color: Colors.black54,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400),
                                        fillColor: greyColor,
                                        filled: true,
                                        counterText: "",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.44,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 45,
                                            width: size.width,
                                            decoration: BoxDecoration(
                                              color: greyColor,
                                              border: Border.all(
                                                color: greyColor,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, right: 10.0),
                                              child: InkWell(
                                                onTap: () {},
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      dob ?? '',
                                                      style: const TextStyle(
                                                          fontFamily: "Roboto",
                                                          color: Colors.black54,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    const Icon(Icons
                                                        .calendar_today_outlined)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "DD/MM/YYYY",
                                            style: TextStyle(
                                                fontFamily: "Roboto",
                                                color: Colors.black54,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      height: 45,
                                      width: size.width * 0.44,
                                      child: TextFormField(
                                          enabled: false,
                                          controller: age,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400),
                                          decoration: InputDecoration(
                                            hintText: "Age",
                                            hintStyle: const TextStyle(
                                                fontFamily: "Roboto",
                                                color: Colors.black54,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400),
                                            fillColor: greyColor,
                                            filled: true,
                                            counterText: "",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          maxLength: 50),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.44,
                                      child: Container(
                                        height: 45,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          color: greyColor,
                                          border: Border.all(
                                            color: greyColor,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: InkWell(
                                            onTap: () {},
                                            child: Row(
                                              children: [
                                                Text(
                                                  _selectedGender,
                                                  style: const TextStyle(
                                                      fontFamily: "Roboto",
                                                      color: Colors.black54,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.44,
                                      child: Container(
                                        height: 45,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          color: greyColor,
                                          border: Border.all(
                                            color: greyColor,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: InkWell(
                                            onTap: () {},
                                            child: Row(
                                              children: [
                                                Text(
                                                  joB,
                                                  style: const TextStyle(
                                                      fontFamily: "Roboto",
                                                      color: Colors.black54,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  enabled: false,
                                  controller: addr,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                    hintText: "Address",
                                    hintStyle: const TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.black54,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400),
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
                                  maxLines: 3,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          // const Divider(
                          //   height: 1,
                          //   thickness: 1,
                          //   color: Colors.grey,
                          // ),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(left: 10.0, right: 10),
                          //   child: Column(
                          //     children: [
                          //       const SizedBox(
                          //         height: 10,
                          //       ),
                          //       Row(
                          //         children: const [
                          //           Text(
                          //             "Documents",
                          //             style: TextStyle(
                          //                 color: themeColor,
                          //                 fontSize: 16,
                          //                 fontFamily: "Roboto",
                          //                 fontWeight: FontWeight.w500),
                          //           ),
                          //           SizedBox(
                          //             width: 10,
                          //           ),
                          //           Text(
                          //             "( jpg or pdf format with size less than 50k )",
                          //             style: TextStyle(
                          //                 color: themeColor,
                          //                 fontSize: 12,
                          //                 fontFamily: "Roboto",
                          //                 fontWeight: FontWeight.w400),
                          //           ),
                          //         ],
                          //       ),
                          //       const SizedBox(
                          //         height: 22.0,
                          //       ),
                          //
                          //       Row(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           const SizedBox(
                          //             width: 130,
                          //             child: Text(
                          //               "Pancard",
                          //               style: TextStyle(
                          //                   color: themeColor,
                          //                   fontSize: 14,
                          //                   fontFamily: "Roboto",
                          //                   fontWeight: FontWeight.w400),
                          //             ),
                          //           ),
                          //           const SizedBox(
                          //             width: 10,
                          //           ),
                          //           CachedNetworkImage(
                          //             width: 50,
                          //             height: 50,
                          //             fit: BoxFit.fill,
                          //             imageUrl: imageUrl + panCard,
                          //             placeholder: (context, url) =>
                          //                 Container(),
                          //             errorWidget: (context, url, error) =>
                          //                 const Text(
                          //               'No Data',
                          //               style: TextStyle(
                          //                   color: themeColor,
                          //                   fontSize: 14,
                          //                   fontFamily: "Roboto",
                          //                   fontWeight: FontWeight.w400),
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //
                          //       const SizedBox(
                          //         height: 10,
                          //       ),
                          //
                          //       Row(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           const SizedBox(
                          //             width: 130,
                          //             child: Text(
                          //               "Aadhar/Passport/\nVoters ID",
                          //               style: TextStyle(
                          //                   color: themeColor,
                          //                   fontSize: 14,
                          //                   fontFamily: "Roboto",
                          //                   fontWeight: FontWeight.w400),
                          //             ),
                          //           ),
                          //           const SizedBox(
                          //             width: 10,
                          //           ),
                          //           CachedNetworkImage(
                          //             width: 50,
                          //             height: 50,
                          //             fit: BoxFit.fill,
                          //             imageUrl: imageUrl + proof,
                          //             placeholder: (context, url) =>
                          //                 Container(),
                          //             errorWidget: (context, url, error) =>
                          //                 const Text(
                          //               'No Data',
                          //               style: TextStyle(
                          //                   color: themeColor,
                          //                   fontSize: 14,
                          //                   fontFamily: "Roboto",
                          //                   fontWeight: FontWeight.w400),
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //
                          //       const SizedBox(
                          //         height: 10,
                          //       ),
                          //
                          //       Row(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           const SizedBox(
                          //             width: 130,
                          //             child: Text(
                          //               "Passport\nsize photo",
                          //               style: TextStyle(
                          //                   color: themeColor,
                          //                   fontSize: 14,
                          //                   fontFamily: "Roboto",
                          //                   fontWeight: FontWeight.w400),
                          //             ),
                          //           ),
                          //           const SizedBox(
                          //             width: 10,
                          //           ),
                          //           CachedNetworkImage(
                          //             width: 50,
                          //             height: 50,
                          //             fit: BoxFit.fill,
                          //             imageUrl: imageUrl + photo,
                          //             placeholder: (context, url) =>
                          //                 Container(),
                          //             errorWidget: (context, url, error) =>
                          //                 const Text(
                          //               'No Data',
                          //               style: TextStyle(
                          //                   color: themeColor,
                          //                   fontSize: 14,
                          //                   fontFamily: "Roboto",
                          //                   fontWeight: FontWeight.w400),
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //
                          //       const SizedBox(
                          //         height: 40,
                          //       ),
                          //       //
                          //       //
                          //       // TextButton(
                          //       //   onPressed: (){
                          //       //   },
                          //       //   child: Container(
                          //       //     height: 45,
                          //       //     width: size.width*0.7,
                          //       //     decoration: BoxDecoration(
                          //       //       color: themeColor,
                          //       //       borderRadius: BorderRadius.circular(45),
                          //       //     ),
                          //       //     child: const Center(
                          //       //       child: Text(
                          //       //         "Add",
                          //       //         style: TextStyle(
                          //       //           fontWeight: FontWeight.w400,
                          //       //           fontFamily: "Roboto",
                          //       //           color: Colors.white,
                          //       //           fontSize: 18,
                          //       //         ),
                          //       //
                          //       //       ),
                          //       //     ),
                          //       //   ),
                          //       // ),
                          //     ],
                          //   ),
                          // ),
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
    );
  }
}
