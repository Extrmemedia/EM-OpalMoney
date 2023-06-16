import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:opal_money/Controller/incentivestructure.dart';
import 'package:opal_money/Utils/loader.dart';

import '../ApiService/RegistrationFormApiService.dart';
import '../ApiService/agentIncentiveStructureApi.dart';
import '../ApiService/agentRegistrationFormApiService.dart';
import '../ApiService/occupationApiService.dart';
import '../ApiService/partimeEmployIncentiveApi.dart';
import '../Common/constants.dart';
import '../Model/ModelAgentIncentiveStructure.dart';
import '../Model/ModelOccupation.dart';
import '../Model/ModelPartimeEmploySinctvStructure.dart';
import '../Model/ModelSaveRegistrationForm.dart';
import '../Utils/toast.dart';
import 'agentregistration_screen.dart';
import 'home_page_screen.dart';
import 'package:toast/toast.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import 'incentivestructure_agent.dart';
import 'payment_screen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var nameTextController = TextEditingController();
  var mobileTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var dobTextController = TextEditingController();
  var ageTextController = TextEditingController();
  var addressTextController = TextEditingController();
  var agentcodeTextController = TextEditingController();
   String dateOfbirth='';
  String _selectedGender = 'male';
  String _selectedusertype = 'parttimeemployee';
  String job_id = '0';
  String gender_id = '0';
  String usertype_id = '0';
  String dropdownValuejob = "Business";
  String image;
  String pan = '';
  String idproof = '';
  String photo = '';
  String resume = '';
   String formattedDate='';
  ModelOccupation modelOccupation;
  ModelSaveRegistrationForm modelSaveRegistrationForm;
  List<Occupation> jobList;
  String imageName;
  File _imageFile1;
  File _imageFile2;
  File _imageFile3;
  File _imageFile4;

  bool selectedOne = false;
  bool selectedTwo = false;
  bool selectedThree = false;
  bool selectedFour = false;



  void _pickImage1() async {
    try {
      FilePickerResult pickedFile1 =await FilePicker.platform.pickFiles(

          type: FileType.media,

      );
      // await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = pickedFile1.files.single.path;
        imageName = pickedFile1.files.single.path.split('/').last;
        print(image);

        pan = image;

        print("image1$pan");

        if (pickedFile1 != null) {
          _imageFile1 = File(pickedFile1.files.single.path);
          selectedOne = true;
        } else {
          print('No image selected');
        }
        // fileName = imageName;
      });
    } catch (e) {
      print("Image picker error ");
    }
  }

  void _pickImage2() async {
    try {
      FilePickerResult pickedFile2 =await FilePicker.platform.pickFiles(

          type: FileType.media,

      );
      //await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = pickedFile2.files.single.path.toString();
        imageName =pickedFile2.files.single.path.split('/').last;
        print(image);

        idproof = image;

        print("image2$idproof");

        if (pickedFile2 != null) {
          _imageFile2 = File(pickedFile2.files.single.path);
          selectedTwo = true;
        } else {
          print('No image selected');
        }
        // fileName = imageName;
      });
    } catch (e) {
      print("Image picker error ");
    }
  }

  void _pickImage3() async {
    try {
      FilePickerResult pickedFile3 =await FilePicker.platform.pickFiles(

          type: FileType.media,

      );
      // await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = pickedFile3.files.single.path.toString();
        imageName = pickedFile3.files.single.path.split('/').last;
        print(image);

        photo = image;

        print("image3$photo");

        if (pickedFile3 != null) {
          _imageFile3 = File(pickedFile3.files.single.path);
          selectedThree = true;
        } else {
          print('No image selected');
        }
        // fileName = imageName;
      });
    } catch (e) {
      print("Image picker error ");
    }
  }

  void _pickImage4() async {
    try {
      FilePickerResult pickedFile4 = await FilePicker.platform.pickFiles(

          type: FileType.media,

      );
      // await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        // image = pickedFile4.path.toString();
        resume = pickedFile4.files.single.path.split('/').last;
        print(image);
        // resume = image;

        print("image4$resume");

        if (pickedFile4 != null) {
          _imageFile4 = File(pickedFile4.files.single.path);
          selectedFour = true;
        } else {
          print('No image selected');
        }
        // fileName = imageName;
      });
    } catch (e) {
      print("Image picker error ");
    }
  }

  void initState() {
    super.initState();
    jobListApiCall();
  }




  jobListApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        jobApiFunc();
        ptEmploy();
        agent();
      } else {
        showToast("Please check your internet connection");

        return;
      }
    });
  }

  List<ModelAgententiveStructure> agnt = [];

  agent() {
    AgentIncentiveStructureApiService.agentIncentiveStructureApiCall(context)
        .then((value) {
      if (value['status'] == '1') {
        setState(() {
          agnt = ((value["data"] ?? []) as List)
              .map((li) => ModelAgententiveStructure.fromJson(li))
              .toList();
        });
      } else {
        showToast(value['message']);
      }
    });
  }

  List<ModelPartimeemployIncentiveStructure> details = [];

  ptEmploy() {
    PartimeEmployIncentiveStructureApiService
            .partimeEmployIncentiveStructureApiCall(context)
        .then((value) {
      if (value['status'] == '1') {
        setState(() {
          details = ((value["data"] ?? []) as List)
              .map((li) => ModelPartimeemployIncentiveStructure.fromJson(li))
              .toList();
        });
      } else {
        showToast(value['message']);
      }
    });
  }

  jobApiFunc() {
    OccupationApiService.occupationApiCall(context).then((result) async {
      try {
        // showToast(result.message.toString(),
        //     gravity: Toast.BOTTOM, duration: 2);

        // progressDialog.hide();
        if (result.success) {
          setState(() {
            modelOccupation = result;
            jobList = modelOccupation.data;
          });

          //showToast((result.message), gravity: Toast.BOTTOM, duration: 2);
        } else {
          // await progressDialog.hide();
          showToast((result.message));
        }
      } catch (e) {
        //await progressDialog.hide();
      }
    });
  }

  registrationFormApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        registrationform();
      } else {
        Navigator.pop(context);
        showToast("Please check your internet connection");

        return;
      }
    });
  }

  void registrationform() {
    print("ID${Global.shared.id}");
    print("name${nameTextController.text}");
    print("mobile${mobileTextController.text}");
    print("email${emailTextController.text}");
    print("dob${dobTextController.text}");
    print("age${ageTextController.text}");
    print("gender${gender_id}");
    print("occupId$job_id");
    print("address${addressTextController.text}");
    print("typeID${usertype_id}");
    print("agentcode${agentcodeTextController.text}");
    print("pan ${pan}");
    print("idproof ${idproof}");
    print("photo ${photo}");
    print("resume ${resume}");
    if (usertype_id == '0') {
      RegistrationFormApiService.registrationFormApiCall(
        context,
        Global.shared.id,
        nameTextController.text,
        mobileTextController.text,
        emailTextController.text,
        formattedDate,
        ageTextController.text,
        gender_id,
        job_id,
        addressTextController.text,
        usertype_id,
        agentcodeTextController.text,
        _imageFile1,
        _imageFile2,
        _imageFile3,
        _imageFile4,
      ).then((model) async {
        try {
          print("jkjjkjjkjkjk " + model.toString());
          if (model['success'] == true) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PaymentScreen(
                    screen: 'registration',
                    orderid: model['orderid'],
                    name: model['name'],
                    amt: model['amount'],
                  );
                },
              ),
            );
          } else {
            Navigator.pop(context);
            showToast(model['message'].toString());
          }
        } catch (e) {
          Navigator.pop(context);

          print(e);
          showToast(e.toString(),
             );
        }
      });
    } else {
      AgentRegistrationFormApiService.agentregistrationFormApiCall(
        context,
        Global.shared.id,
        nameTextController.text,
        mobileTextController.text,
        emailTextController.text,
        formattedDate,
        ageTextController.text,
        gender_id,
        job_id,
        addressTextController.text,
        usertype_id,
        agentcodeTextController.text,
        _imageFile1,
        _imageFile2,
        _imageFile3,
      ).then((model) async {
        try {
          if (model['success'] == true) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PaymentScreen(
                    orderid: model['orderid'],
                    name: model['name'],
                    amt: model['amount'],
                  );
                },
              ),
            );

          } else {
            Navigator.pop(context);
            showToast(model['message'].toString());
          }
        } catch (e) {
          Navigator.pop(context);
          print(e);
          showToast(e.toString());
        }
      });
    }
  }

  Future<ModelOccupation> getJobList() async {
    jobList = modelOccupation.data;
    return modelOccupation;
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);


    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 26,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text(
          "Registration",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              fontFamily: "Poppins"),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                usertype(),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return usertype_id == '0'
                                            ? IncentiveStructure(
                                                details: details,
                                              )
                                            : IncentiveStructureAgent(
                                                details: agnt,
                                              );
                                      }));
                                    },
                                    child: usertype_id == '0'
                                        ? Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: details.isEmpty
                                                    ? Container()
                                                    : Text(
                                                        Bidi.stripHtmlIfNeeded(
                                                                details.isEmpty
                                                                    ? ""
                                                                    : details[0]
                                                                        .details)
                                                            .trim()
                                                            .substring(38, 144),
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: "Roboto",
                                                        ),
                                                      ),
                                              ),
                                              const Text(
                                                'Read More',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xfffd5772b),
                                                  fontSize: 15,
                                                  fontFamily: "Roboto",
                                                ),
                                              )
                                              // RichText(
                                              //   textAlign: TextAlign.start,
                                              //   softWrap: true,
                                              //   text: TextSpan(
                                              //     // Note: Styles for TextSpans must be explicitly defined.
                                              //     // Child text spans will inherit styles from parent
                                              //
                                              //     style: const TextStyle(
                                              //       fontSize: 14.0,
                                              //       color: Colors.black54,
                                              //     ),
                                              //     children: <TextSpan>[
                                              //       TextSpan(
                                              //         text: usertype_id == '0'
                                              //             ? "Rs.295/- Registration fee applicable for part time employees,its not refundable "
                                              //             : "Rs.295/- Registration fee applicable for Agent,its not refundable ",
                                              //         style: const TextStyle(
                                              //           color: Colors.black,
                                              //           fontSize: 14,
                                              //           fontWeight: FontWeight.w400,
                                              //           fontFamily: "Roboto",
                                              //         ),
                                              //       ),
                                              //       const TextSpan(
                                              //           text: 'Read More',
                                              //           style: TextStyle(
                                              //             fontWeight: FontWeight.bold,
                                              //             color: Color(0xfffd5772b),
                                              //             fontSize: 15,
                                              //             fontFamily: "Roboto",
                                              //           )),
                                              //     ],
                                              //   ),
                                              // ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  Bidi.stripHtmlIfNeeded(
                                                          agnt.isEmpty
                                                              ? ""
                                                              : agnt[0].details)
                                                      .trim()
                                                      .substring(16, 119),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Roboto",
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                'Read More',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xfffd5772b),
                                                  fontSize: 15,
                                                  fontFamily: "Roboto",
                                                ),
                                              )
                                              // RichText(
                                              //   textAlign: TextAlign.start,
                                              //   softWrap: true,
                                              //   text: TextSpan(
                                              //     // Note: Styles for TextSpans must be explicitly defined.
                                              //     // Child text spans will inherit styles from parent
                                              //
                                              //     style: const TextStyle(
                                              //       fontSize: 14.0,
                                              //       color: Colors.black54,
                                              //     ),
                                              //     children: <TextSpan>[
                                              //       TextSpan(
                                              //         text: usertype_id == '0'
                                              //             ? "Rs.295/- Registration fee applicable for part time employees,its not refundable "
                                              //             : "Rs.295/- Registration fee applicable for Agent,its not refundable ",
                                              //         style: const TextStyle(
                                              //           color: Colors.black,
                                              //           fontSize: 14,
                                              //           fontWeight: FontWeight.w400,
                                              //           fontFamily: "Roboto",
                                              //         ),
                                              //       ),
                                              //       const TextSpan(
                                              //           text: 'Read More',
                                              //           style: TextStyle(
                                              //             fontWeight: FontWeight.bold,
                                              //             color: Color(0xfffd5772b),
                                              //             fontSize: 15,
                                              //             fontFamily: "Roboto",
                                              //           )),
                                              //     ],
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                // Text(_selectedusertype == 'agent' ? 'Hello agent!':''),
                                name(),
                                const SizedBox(
                                  height: 20,
                                ),
                                mobile(),
                                const SizedBox(
                                  height: 20,
                                ),
                                email(),
                                const SizedBox(
                                  height: 20,
                                ),
                                dobAge(),
                                const SizedBox(
                                  height: 20,
                                ),
                                gender(),

                                const SizedBox(
                                  height: 20,
                                ),
                                occupation(),
                                const SizedBox(
                                  height: 20,
                                ),
                                address(),
                                const SizedBox(
                                  height: 20,
                                ),
                                agentcode(),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      "Documents",
                                      style: TextStyle(
                                          color: themeColor,
                                          fontSize: 16,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "( jpg or pdf format with size less than 50k )",
                                      style: TextStyle(
                                          color: themeColor,
                                          fontSize: 12,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 56,
                                      child: Text(
                                        "Pancard",
                                        style: TextStyle(
                                            color: themeColor,
                                            fontSize: 12,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    selectedOne
                                        ? Row(
                                            children: [
                                              Container(
                                                  height: 100,
                                                  width: 150,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  child: Image.file(
                                                    _imageFile1,
                                                    fit: BoxFit.fill,
                                                  )),
                                              const SizedBox(width: 30.0,),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    // image = pickedFile1.path.toString();
                                                    pan = '';
                                                    print(image);

                                                    //pan = image;

                                                    print("image1 $pan");

                                                   // _imageFile1=null;
                                                    selectedOne = false;

                                                    // fileName = imageName;
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          )
                                        : TextButton(
                                            onPressed: () {
                                              _pickImage1();
                                              // getImageFromGallery(context);
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: greyColor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Upload",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Roboto",
                                                    color: themeColor,
                                                    fontSize: 14,
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
                                  children: [
                                    const SizedBox(
                                      width: 56,
                                      child: Text(
                                        "Aadhar/Passport/VoterId",
                                        style: TextStyle(
                                            color: themeColor,
                                            fontSize: 12,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    selectedTwo
                                        ? Row(
                                          children: [
                                            Container(
                                                height: 100,
                                                width: 150,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                ),
                                                child: Image.file(
                                                  _imageFile2,
                                                  fit: BoxFit.fill,
                                                )),
                                            const SizedBox(width: 30.0,),
                                            InkWell(
                                              onTap: () {
                                                setState(() {

                                                  idproof = '';



                                                  selectedTwo = false;

                                                });
                                              },
                                              child: const Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        )
                                        : TextButton(
                                            onPressed: () {
                                              _pickImage2();
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: greyColor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Upload",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Roboto",
                                                    color: themeColor,
                                                    fontSize: 14,
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
                                  children: [
                                    const SizedBox(
                                      width: 56,
                                      child: Text(
                                        "Passport\nsize photo",
                                        style: TextStyle(
                                            color: themeColor,
                                            fontSize: 12,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    selectedThree
                                        ? Row(
                                          children: [
                                            Container(
                                                height: 100,
                                                width: 150,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                ),
                                                child: Image.file(
                                                  _imageFile3,
                                                  fit: BoxFit.fill,
                                                )),
                                            const SizedBox(width: 30.0,),
                                            InkWell(
                                              onTap: () {
                                                setState(() {

                                                  photo = '';



                                                  selectedThree = false;

                                                });
                                              },
                                              child: const Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        )
                                        : TextButton(
                                            onPressed: () {
                                              _pickImage3();
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: greyColor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Upload",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Roboto",
                                                    color: themeColor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                Visibility(
                                  visible: usertype_id == "0" ? true : false,
                                  child: const SizedBox(
                                    height: 10,
                                  ),
                                ),
                                Visibility(
                                  visible: usertype_id == "0" ? true : false,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 56,
                                        child: Text(
                                          "Resume",
                                          style: TextStyle(
                                              color: themeColor,
                                              fontSize: 12,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      selectedFour
                                          ? Row(
                                            children: [
                                              Container(
                                                  height: 100,
                                                  width: 150,
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10)),
                                                  ),
                                                  child: Image.file(
                                                    _imageFile4,
                                                    fit: BoxFit.fill,
                                                  )),
                                              const SizedBox(width: 30.0,),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {

                                                    resume = '';



                                                    selectedFour = false;

                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          )
                                          : TextButton(
                                              onPressed: () {
                                                _pickImage4();
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  color: greyColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    "Upload",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: "Roboto",
                                                      color: themeColor,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (nameTextController.text.isEmpty) {
                                      showToast('provide name',
                                        );
                                    } else if (mobileTextController
                                            .text.isEmpty ||
                                        mobileTextController.text.length < 10) {
                                      showToast('provide a valid mobile number',
                                         );
                                    } else if (emailTextController
                                            .text.isEmpty ||
                                        !emailTextController.text
                                            .contains('@') ||
                                        !emailTextController.text
                                            .contains('.')) {
                                      showToast('provide a valid mail id',
                                         );
                                    } else if (dobTextController.text.isEmpty) {
                                      showToast('provide DOB',
                                         );
                                    } else if (ageTextController.text.isEmpty) {
                                      showToast('provide Age',
                                          );
                                    } else if (addressTextController
                                        .text.isEmpty) {
                                      showToast('provide Address',
                                         );
                                    } else if (pan == '') {
                                      showToast('Upload Pancard',
                                      );
                                    } else if (idproof == '') {
                                      showToast('Upload Proof',);
                                    } else if (photo == '') {
                                      showToast('Upload Photo',);
                                    } else if (usertype_id == '0' &&
                                        resume == '') {
                                      print('part time');
                                      showToast('Upload Resume',);
                                    } else {
                                      print('ok');
                                      loader(context);
                                      registrationFormApiCall();
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
                                        "Apply Now",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Roboto",
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
    );
  }

  Widget usertype() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
          ),
          child: Row(
            children: [
              Radio<String>(
                value: 'parttimeemployee',
                groupValue: _selectedusertype,
                onChanged: (value) {
                  setState(() {
                    _selectedusertype = value;
                    usertype_id = "0";
                  });
                },
              ),
              const Text(
                "Part-Time Employee",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Radio<String>(
              value: 'agent',
              groupValue: _selectedusertype,
              onChanged: (value) {
                setState(() {
                  _selectedusertype = value;
                  usertype_id = "1";
                });
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return AgentRegistrationScreen();
                //     },
                //   ),
                // );
              },
            ),
            const Text("Agent",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }

  Widget name() {
    return SizedBox(
      height: 45,
      child: TextFormField(
          controller: nameTextController,
          style: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w300),
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
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
          keyboardType: TextInputType.text,
          maxLength: 30),
    );
  }

  Widget mobile() {
    return SizedBox(
      height: 45,
      child: TextFormField(
          controller: mobileTextController,
          style: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w300),
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
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
          keyboardType: TextInputType.phone,
          maxLength: 10),
    );
  }

  Widget email() {
    return SizedBox(
      height: 45,
      child: TextFormField(
          controller: emailTextController,
          style: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w300),
          decoration: InputDecoration(
            hintText: "Email ID",
            hintStyle: const TextStyle(
                fontFamily: "Roboto",
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
    );
  }

  Widget dobAge() {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: size.width * 0.39,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
                child: TextFormField(
                  controller: dobTextController,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300),
                  decoration: InputDecoration(
                    hintText: "DOB",
                    hintStyle: const TextStyle(
                        fontFamily: "Roboto",
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
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(
                          1950), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formatDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      String showDate =   DateFormat('dd/MM/yyyy').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        formattedDate = formatDate;
                        dobTextController.text =
                            showDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
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
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        SizedBox(
          height: 45,
          width: size.width * 0.39,
          child: TextFormField(
              controller: ageTextController,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                hintText: "Age",
                hintStyle: const TextStyle(
                    fontFamily: "Roboto",
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
              keyboardType: TextInputType.number,
              maxLength: 50),
        ),
      ],
    );
  }

  Widget gender() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Radio<String>(
              value: 'male',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                  gender_id = "0";
                });
              },
            ),
            const Text("Male"),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              value: 'female',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                  gender_id = "1";
                });
              },
            ),
            const Text("Female"),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              value: 'others',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                  gender_id = "2";
                });
              },
            ),
            const Text("Others"),
          ],
        ),
      ],
    );
  }

  Widget occupation() {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: getJobList(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: 45,
            width: size.width,
            decoration: BoxDecoration(
              color: greyColor,
              border: Border.all(
                color: greyColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: DropdownButton(
                  hint: const Text("Occupation"),
                  isExpanded: true,
                  value: dropdownValuejob,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                  items: jobList.map((jobAll) {
                    return DropdownMenuItem(
                      value: jobAll.occupation,
                      onTap: () {
                        job_id = jobAll.id.toString();
                        print("JobID$job_id");
                      },
                      child: Text(jobAll.occupation),
                    );
                  }).toList(),
                  onChanged: (value) {
                    String occupation = value.toString();
                    print("Selected occupation is $occupation");
                    dropdownValuejob = occupation;
                    setState(() {
                      dropdownValuejob = occupation;
                    });
                  },
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget address() {
    return TextFormField(
      controller: addressTextController,
      style: const TextStyle(
          color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
        hintText: "Address",
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
      maxLines: 3,
    );
  }

  Widget agentcode() {
    return SizedBox(
      height: 45,
      child: TextFormField(
          controller: agentcodeTextController,
          style: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w300),
          decoration: InputDecoration(
            hintText: "Reference Code",
            hintStyle: const TextStyle(
                fontFamily: "Roboto",
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
    );
  }
}
