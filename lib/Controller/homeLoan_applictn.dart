import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opal_money/Controller/insurance_plan_listing_screen.dart';
import 'package:opal_money/Controller/real_estate_screen.dart';
import 'package:opal_money/Model/ModelEnquiry.dart';
import 'package:toast/toast.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../ApiService/homeLoanApplicationApiServices.dart';
import '../ApiService/occupationApiService.dart';
import '../Common/constants.dart';
import '../Model/ModelOccupation.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import '../Utils/loader.dart';
import '../Utils/toast.dart';
import 'enquirysuccess_screen.dart';

class HomeLoanApplicationForm extends StatefulWidget {
  final String catId;
  final String subcatId;
  final String planId;
  const HomeLoanApplicationForm({Key key,this.catId,this.planId,this.subcatId}) : super(key: key);

  @override
  State<HomeLoanApplicationForm> createState() => _HomeLoanApplicationFormState();
}

class _HomeLoanApplicationFormState extends State<HomeLoanApplicationForm> {
  var nameTextController = TextEditingController();
  var mobileTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var dobTextController = TextEditingController();
  var ageTextController = TextEditingController();
  var addressTextController = TextEditingController();
  var descriptionTextController = TextEditingController();
  ModelOccupation modelOccupation;
  List<Occupation> jobList;
  String dropdownValuejob = "Business";
  String job_id;
  String group;
  String catId;
  String subcatId;
  String planId;
  ModelEnquiry modelEnquiry;
  bool selectedOne = false;
  bool selectedTwo = false;
   String image;
  File _imageFile1;
  File _imageFile2;
  String dateFormat='';
  String imageName = "Upload";
  void _pickImage1() async {
    try {
      FilePickerResult pickedFile1 = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.media,
          // allowedExtensions: ['jpg','png'],
          allowCompression: true,
          withData: true);
      // await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = pickedFile1.files.single.path;
        imageName = pickedFile1.files.single.path.split('/').last;
        print(image);

        //pan = image;

        // print("image1$pan");

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
          // allowedExtensions: ['jpg','png'],
          allowCompression: true,
          withData: true);
      //await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = pickedFile2.files.single.path.toString();
        imageName = pickedFile2.files.single.path.split('/').last;
        print(image);

        //idproof = image;

        //print("image2$idproof");

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
  @override
  void initState() {
    super.initState();
    jobListApiCall();
    print("catId ${widget.catId}");
    print("subcatId ${widget.subcatId}");
    print("planId ${widget.planId}");
    catId = widget.catId;
    subcatId = widget.subcatId;
    planId = widget.planId;
  }
  jobListApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        jobApiFunc();
      } else {
        showToast(
          "Please check your internet connection",
        );

        return;
      }
    });
  }

  jobApiFunc() {
    OccupationApiService.occupationApiCall(context).then((result) async {
      try {
         if (result.success) {
          setState(() {
            modelOccupation = result;
            jobList = modelOccupation.data;
            job_id=jobList.first.id.toString();
          });
        }
        } catch (e) {
        }
    });
  }
  Future<ModelOccupation> getJobList() async {
    jobList = modelOccupation.data;
    return modelOccupation;
  }
  applicationApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        applicationApiFunc();
      } else {
        showToast(
          "Please check your internet connection",
        );

        return;
      }
    });
  }
    void applicationApiFunc() {
      print("ID${Global.shared.id}");
         HomeLoanApplicationFormApiService.applicationFormApiCall(
          context,
             Global.shared.id,
             widget.catId,
             widget.subcatId,
             widget.planId,
             nameTextController.text,
             mobileTextController.text,
             emailTextController.text,
             dateFormat,
             ageTextController.text,
             addressTextController.text,
             job_id,
             descriptionTextController.text,
          _imageFile1,
          _imageFile2,
         )
          .then((result) async {
        try {
          print(result);
          if (result['status'] == 'success') {
            print('check');
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return  EnquirySucessScreen(screenType: 'r',);
                },
              ),
            );

          } else {
            Navigator.pop(context);
            showToast(result['message']);
          }
        } catch (e) {
          Navigator.pop(context);
          showToast(result['message']);
        }
      });
    }
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
        title: Text(
         'Home Loan Application',
          style: const TextStyle(
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
                                SizedBox(
                                  height: 45,
                                  child: TextFormField(
                                      controller: nameTextController,
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
                                      controller: mobileTextController,
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
                                      controller: emailTextController,
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
                                      width: size.width * 0.39,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 45,
                                            child: TextFormField(
                                              controller: dobTextController,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w400),
                                              decoration: InputDecoration(
                                                hintText: "DOB",
                                                hintStyle: const TextStyle(
                                                    fontFamily: "Roboto",
                                                    color: Colors.black54,
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                    FontWeight.w300),
                                                fillColor: greyColor,
                                                filled: true,
                                                counterText: "",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10.0),
                                                  borderSide: const BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none,
                                                  ),
                                                ),
                                              ),
                                              readOnly:
                                              true, //set it true, so that user will not able to edit text
                                              onTap: () async {
                                                DateTime pickedDate =
                                                await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(
                                                      1950), //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime.now(),
                                                );

                                                if (pickedDate != null) {
                                                  print(
                                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                  String formattedDate =
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(pickedDate);
                                                  String  dateFormated = DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                                  print(
                                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                                  //you can implement different kind of Date Format here according to your requirement

                                                  setState(() {
                                                    dateFormat=dateFormated;
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
                                              fontWeight: FontWeight.w400),
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
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                          ),
                                          keyboardType:
                                          TextInputType.number,
                                          maxLength: 3),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: addressTextController,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400),
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
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                FutureBuilder(
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
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: DropdownButton(
                                              hint: const Text("Occupation"),
                                              isExpanded: true,
                                              value: dropdownValuejob,
                                              icon: const Icon(
                                                  Icons.arrow_drop_down),
                                              iconSize: 24,
                                              elevation: 16,
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                              items: jobList.map((jobAll) {
                                                return DropdownMenuItem(
                                                  value: jobAll.occupation,
                                                  onTap: () {
                                                    job_id =
                                                        jobAll.id.toString();
                                                    print("JobID$job_id");
                                                  },
                                                  child:
                                                  Text(jobAll.occupation),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                String occupation =
                                                value.toString();
                                                print(
                                                    "Selected occupation is $occupation");
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
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  child: TextFormField(
                                    controller: descriptionTextController,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400),
                                    decoration: InputDecoration(
                                      hintText: "Description",
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
                                    keyboardType: TextInputType.emailAddress,
                                    maxLength: 200,
                                    maxLines: 5,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 5.0, right: 2),
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
                                            width:5,
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
                                                width: 4.0,
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
                                                  "upload",
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
                                              SizedBox(
                                                width: 4.0,
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
                                          } else if (descriptionTextController
                                              .text.isEmpty) {
                                            showToast(
                                              "Provide description",
                                            );
                                          }
                                          else if (selectedOne == false) {
                                            showToast(
                                              'Upload pancard',
                                            );
                                          } else if (selectedTwo == false) {
                                            print('part time');
                                            showToast(
                                              'Upload aadhar',
                                            );
                                          }  else {
                                            print('ok');
                                            loader(context);
                                            applicationApiCall();

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


