import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/ApiService/saveTradingAccountApiService.dart';
import 'package:opal_money/Controller/home_page_screen.dart';
import 'package:opal_money/Model/ModelSaveApplication.dart';
import 'package:opal_money/Model/ModelSaveTradingAccount.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import 'package:intl/intl.dart';

import '../Utils/loader.dart';
import '../Utils/toast.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  var nameTextController = TextEditingController();
  var mobileTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var dobTextController = TextEditingController();
  var ageTextController = TextEditingController();
  var addressTextController = TextEditingController();
  var mothersNameTextController = TextEditingController();
  String _selectedGender = 'male';
  String gender_id = '0';
  String formatDate='';
  ModelSaveTradingAccount modelSaveTradingAccount;

  String image;
  String pan;
  String adhaar;
  String photo;
  String checque;
  String sign;
  String bank_stmt;
  String imageName;
  File _imageFile1;
  File _imageFile2;
  File _imageFile3;
  File _imageFile4;
  File _imageFile5;
  File _imageFile6;
  bool selectedOne = false;
  bool selectedTwo = false;
  bool selectedThree = false;
  bool selectedFour = false;
  bool selectedFive = false;
  bool selectedSix = false;

  void _pickImage1() async {
    try {
      FilePickerResult pickedFile1 = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.media,
          //  allowedExtensions: ['jpg', 'png'],
          allowCompression: true,
          withData: true);
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
      FilePickerResult pickedFile2 = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.media,
          //  allowedExtensions: ['jpg', 'png'],
          allowCompression: true,
          withData: true);
      //await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = pickedFile2.files.single.path.toString();
        imageName = pickedFile2.files.single.path.split('/').last;
        print(image);

        //idproof = image;

        // print("image2$idproof");

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
      FilePickerResult pickedFile3 = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.media,
          //  allowedExtensions: ['jpg', 'png'],
          allowCompression: true,
          withData: true);
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
          allowMultiple: false,
          type: FileType.media,
          //  allowedExtensions: ['jpg', 'png'],
          allowCompression: true,
          withData: true);
      // await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        // image = pickedFile4.path.toString();
        //resume = pickedFile4.files.single.path.split('/').last;
        print(image);
        // resume = image;

        //print("image4$resume");

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

  void _pickImage5() async {
    try {
      FilePickerResult pickedFile4 = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.media,
          //  allowedExtensions: ['jpg', 'png'],
          allowCompression: true,
          withData: true);
      // await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        // image = pickedFile4.path.toString();
        //resume = pickedFile4.files.single.path.split('/').last;
        print(image);
        // resume = image;

        //print("image4$resume");

        if (pickedFile4 != null) {
          _imageFile5 = File(pickedFile4.files.single.path);
          selectedFive = true;
        } else {
          print('No image selected');
        }
        // fileName = imageName;
      });
      // final pickedFile5 = await FilePicker.getFile(
      //   type: FileType.image,
      //   //allowedExtensions: ['jpg', 'png'],
      // );
      // //await ImagePicker.pickImage(source: ImageSource.gallery);
      // setState(() {
      //
      //   image = pickedFile5.path.toString();
      //   imageName = pickedFile5.path.split('/').last;
      //   print(image);
      //   sign= image;
      //
      //   print("image4$sign");
      //
      //   if (pickedFile5 != null) {
      //     _imageFile5 = pickedFile5;
      //     selectedFive = true;
      //   } else {
      //     print('No image selected');
      //   }
      //   // fileName = imageName;
      // });
    } catch (e) {
      print("Image picker error ");
    }
  }

  void _pickImage6() async {
    try {
      FilePickerResult pickedFile4 = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.media,
          //  allowedExtensions: ['jpg', 'png'],
          allowCompression: true,
          withData: true);
      // await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        // image = pickedFile4.path.toString();
        //resume = pickedFile4.files.single.path.split('/').last;
        print(image);
        // resume = image;

        //print("image4$resume");

        if (pickedFile4 != null) {
          _imageFile6 = File(pickedFile4.files.single.path);
          selectedSix = true;
        } else {
          print('No image selected');
        }
        // fileName = imageName;
      });
      // final pickedFile6 = await FilePicker.getFile(
      //   type: FileType.image,
      //   //allowedExtensions: ['jpg', 'png'],
      // );
      // //await ImagePicker.pickImage(source: ImageSource.gallery);
      // setState(() {
      //
      //   image = pickedFile6.path.toString();
      //   imageName = pickedFile6.path.split('/').last;
      //   print(image);
      //   bank_stmt= image;
      //
      //   print("image4$bank_stmt");
      //
      //   if (pickedFile6 != null) {
      //     _imageFile6 = pickedFile6;
      //     selectedSix = true;
      //   } else {
      //     print('No image selected');
      //   }
      //   // fileName = imageName;
      // });
    } catch (e) {
      print("Image picker error ");
    }
  }

  tradingFormApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();

        tradingApiFunc();
      } else {
        showToast("Please check your internet connection");

        return;
      }
    });
  }

  void tradingApiFunc() {
    print("ID${Global.shared.id}");
    print("name${nameTextController.text}");
    print("mobile${mobileTextController.text}");
    print("email${emailTextController.text}");
    print("dob${dobTextController.text}");
    print("age${ageTextController.text}");
    print("gender${gender_id}");

    print("address${addressTextController.text}");

    // @override
    // void initState() {
    //   dobTextController.text = ""; //set the initial value of text field
    //   super.initState();
    // }
    SaveTradingAccountApiService.tradingFormApiCall(
            context,
            Global.shared.id,
            nameTextController.text,
            mobileTextController.text,
            emailTextController.text,
            formatDate,
            ageTextController.text,
            gender_id,
            addressTextController.text,
            mothersNameTextController.text,
            _imageFile1,
            _imageFile2,
            _imageFile3,
            _imageFile4,
            _imageFile5,
            _imageFile6)
        .then((model) async {
      try {
        print(model);
        if (model['success'] == true) {
          showToast('successfully uploaded');

          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          showToast(model['message']);
          Navigator.pop(context);
        }
      } catch (e) {
        print(e);
        Navigator.pop(context);
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
             Navigator.pop(context);
            },
          ),
        ),
        title: const Text(
          "Trading Account",
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Application form",
                                  style: TextStyle(
                                    color: themeColor,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
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
                                address(),
                                const SizedBox(
                                  height: 20,
                                ),
                                mothersName(),
                                const SizedBox(
                                  height: 10,
                                ),
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
                                              const SizedBox(
                                                width: 30.0,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectedOne = false;
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
                                        "Aadhar",
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  child: Image.file(
                                                    _imageFile2,
                                                    fit: BoxFit.fill,
                                                  )),
                                              const SizedBox(
                                                width: 30.0,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  child: Image.file(
                                                    _imageFile3,
                                                    fit: BoxFit.fill,
                                                  )),
                                              const SizedBox(
                                                width: 30.0,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
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
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 56,
                                      child: Text(
                                        "Checkleaf",
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  child: Image.file(
                                                    _imageFile4,
                                                    fit: BoxFit.fill,
                                                  )),
                                              const SizedBox(
                                                width: 30.0,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
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
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Roboto",
                                                    color: themeColor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                    SizedBox(
                                      width: selectedFour ? 0 : 8,
                                    ),
                                    selectedFour
                                        ? Container()
                                        : const Text(
                                            "Cancelled check leaf with\nsigned image",
                                            style: TextStyle(
                                                color: themeColor,
                                                fontSize: 10,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w300),
                                          )
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
                                        "Signature",
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
                                    selectedFive
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
                                                    _imageFile5,
                                                    fit: BoxFit.fill,
                                                  )),
                                              const SizedBox(
                                                width: 30.0,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectedFive = false;
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
                                              _pickImage5();
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
                                    SizedBox(
                                      width: selectedFive ? 0 : 8,
                                    ),
                                    selectedFive
                                        ? Container()
                                        : const Text(
                                            "Signature On White Background paper\n AsPer The Pancard",
                                            style: TextStyle(
                                                color: themeColor,
                                                fontSize: 10,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w300),
                                          ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 56,
                                      child: Text(
                                        "Bank\nStatement",
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
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        selectedSix
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
                                                        _imageFile6,
                                                        fit: BoxFit.fill,
                                                      )),
                                                  const SizedBox(
                                                    width: 30.0,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedSix = false;
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
                                                  _pickImage6();
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    color: greyColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
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
                                        Image.asset(
                                          "assets/images/text.png",
                                          width: 200,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (nameTextController.text.isEmpty) {
                                      showToast(
                                        'Provide name',
                                      );
                                    } else if (mobileTextController
                                            .text.isEmpty ||
                                        mobileTextController.text.length < 10) {
                                      showToast(
                                        'Provide a valid mobile number',
                                      );
                                    } else if (emailTextController
                                            .text.isEmpty ||
                                        !emailTextController.text
                                            .contains('@') ||
                                        !emailTextController.text
                                            .contains('.')) {
                                      showToast(
                                        'provide a valid mail id',
                                      );
                                    } else if (dobTextController.text.isEmpty) {
                                      showToast(
                                        'Provide DOB',
                                      );
                                    } else if (ageTextController.text.isEmpty) {
                                      showToast(
                                        'Provide age',
                                      );
                                    } else if (addressTextController
                                        .text.isEmpty) {
                                      showToast(
                                        'Provide address',
                                      );
                                    } else if (mothersNameTextController
                                        .text.isEmpty) {
                                      showToast(
                                        "Provide mother's name",
                                      );
                                    }  else if (selectedOne == false) {
                                      showToast(
                                        'Upload pancard',
                                      );
                                    } else if (selectedTwo == false) {
                                      print('part time');
                                      showToast(
                                        'Upload aadhar',
                                      );
                                    } else if (selectedThree == false) {
                                      print('part time');
                                      showToast(
                                        'Upload photo',
                                      );
                                    } else if (selectedFour == false) {
                                      print('part time');
                                      showToast(
                                        'Upload checkleaf',
                                      );
                                    } else if (selectedFive == false) {
                                      print('part time');
                                      showToast(
                                        'Upload signature',
                                      );
                                    } else if (selectedSix == false) {
                                      print('part time');
                                      showToast(
                                        'Upload bank statement',
                                      );
                                    } else {
                                      print('ok');
                                      loader(context);
                                      tradingFormApiCall();
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
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(pickedDate);
                      String f = DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        formatDate=f;
                        dobTextController.text =
                            formattedDate; //set output date to TextField value.
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
              keyboardType: TextInputType.emailAddress,
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

  Widget mothersName() {
    return SizedBox(
      height: 45,
      child: TextFormField(
          controller: mothersNameTextController,
          style: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w300),
          decoration: InputDecoration(
            hintText: "Mother's Name",
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
}
