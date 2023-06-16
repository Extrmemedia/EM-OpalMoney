import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opal_money/ApiService/LifeInsuranceApplicationFormApiService.dart';
import 'package:opal_money/Model/ModelSaveApplication.dart';
import 'package:toast/toast.dart';

import '../ApiService/occupationApiService.dart';
import '../Common/constants.dart';
import '../Model/ModelOccupation.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import '../Utils/loader.dart';
import '../Utils/toast.dart';
import 'enquirysuccess_screen.dart';

class LifeInsuranceApplicationForm extends StatefulWidget {
  final String catId;
  final String subcatId;
  final String planId;
  const LifeInsuranceApplicationForm(
      {key, this.catId, this.subcatId, this.planId})
      : super(key: key);

  @override
  State<LifeInsuranceApplicationForm> createState() =>
      _LifeInsuranceApplicationFormState();
}

class _LifeInsuranceApplicationFormState
    extends State<LifeInsuranceApplicationForm> {
  var nameTextController = TextEditingController();
  var mobileTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var ageTextController = TextEditingController();
  var addressTextController = TextEditingController();
  var descriptionTextController = TextEditingController();
  var nomineeNameTextController = TextEditingController();
  var nomineeAgeTextController = TextEditingController();
  var dobTextController = TextEditingController();
  var nomineeDobTextController = TextEditingController();
  String _selectedGender = 'male';

  String dropDownRelation;
  String panImage = "";
  String aadharImg = "";
  String passportSizeImage = "";
  String signImage = "";
  String imageName = "Upload";
  String job_id;
  String relationship_id="";

  ModelOccupation modelOccupation;
  ModelSaveApplication modelSaveApplication;
  List<Occupation> jobList;
  String gender_id="0";
String dateFormat='';
String nomineeDob ='';

  String dropdownValuejob = "Business";

  bool selectedOne = false;
  bool selectedTwo = false;
  bool selectedThree = false;
  bool selectedFour = false;
  String image;
  File _imageFile1;
  File _imageFile2;
  File _imageFile3;
  File _imageFile4;

  List<String> spinnerRelation = ['Spouse', 'Father', 'Mother'];
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

  void _pickImage3() async {
    try {
      FilePickerResult pickedFile3 = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.media,
          //  allowedExtensions: ['jpg','png'],
          allowCompression: true,
          withData: true);
      // await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = pickedFile3.files.single.path.toString();
        imageName = pickedFile3.files.single.path.split('/').last;
        print(image);

        //  photo = image;

        //print("image3$photo");

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
         // allowedExtensions: ['jpg', 'png'],
          allowCompression: true,
          withData: true);
      // await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        // image = pickedFile4.path.toString();
        //resume = pickedFile4.files.single.path.split('/').last;
        print(image);
        // resume = image;

        //  print("image4$resume");

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

  @override
  void initState() {
    super.initState();
    jobListApiCall();
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
        // showToast(
        //   result.message.toString(),
        // );

        // progressDialog.hide();
        if (result.success) {
          setState(() {
            modelOccupation = result;
            jobList = modelOccupation.data;
            job_id=jobList.first.id.toString();
            print(json.encode(jobList));
          });

          // showToast(
          //   (result.message),
          // );
        }
        // await progressDialog.hide();
        // showToast(
        //   (result.message),
        // );
      } catch (e) {
        //await progressDialog.hide();
      }
    });
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
    print("genderID${addressTextController.text}");

    LifeInsuranceApplicationFormApiService.applicationFormApiCall(
            context,
            Global.shared.userId,
            widget.catId,
            widget.subcatId,
            widget.planId,
            nameTextController.text,
            mobileTextController.text,
            emailTextController.text,
            dateFormat,
            ageTextController.text,
            gender_id,
            addressTextController.text,
            job_id,
            descriptionTextController.text,
            nomineeNameTextController.text,
           nomineeDob,
            nomineeAgeTextController.text,
            relationship_id,
            _imageFile1,
            _imageFile2,
            _imageFile3,
            _imageFile4)
        .then((model) async {
      try {
        print(model);
        if (model['success'] == true) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return  EnquirySucessScreen(screenType: 'r',);
              },
            ),
          );
          //EnquirySucessScreen
        } else {
          Navigator.pop(context);
          showToast(model['message']);
        }
      } catch (e) {
        print(e);
        Navigator.pop(context);

        showToast(model['message']);      }
    });
  }

  Future<ModelOccupation> getJobList() async {
    jobList = modelOccupation.data;
    return modelOccupation;
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
          "Life Insurance Application",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              fontFamily: "Poppins"),
        ),
        actions:  [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
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
                                dob_Age(),
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
                                occupation(),
                                const SizedBox(
                                  height: 20,
                                ),
                                description(),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Nominee",
                                      style: TextStyle(
                                          color: themeColor,
                                          fontSize: 16,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                nomineeName(),
                                const SizedBox(
                                  height: 20,
                                ),
                                nominee_dob_age(),
                                const SizedBox(
                                  height: 20,
                                ),
                                nomineeRelation(),
                                const SizedBox(
                                  height: 20,
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
                                panCard(),
                                const SizedBox(
                                  height: 10,
                                ),
                                aadhar(),
                                const SizedBox(
                                  height: 10,
                                ),
                                passportSizePhoto(),
                                const SizedBox(
                                  height: 10,
                                ),
                                signature(),
                                const SizedBox(
                                  height: 40,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (nameTextController.text.isEmpty) {
                                      showToast(
                                        'Please enter your name',
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
                                    } else if (nomineeNameTextController
                                        .text.isEmpty) {
                                      showToast(
                                        'Provide nominee name',
                                      );
                                    } else if (nomineeDobTextController
                                        .text.isEmpty) {
                                      showToast(
                                        'Provide nominee dob',
                                      );
                                    } else if (nomineeAgeTextController
                                        .text.isEmpty) {
                                      showToast(
                                        'Provide nominee age',
                                      );
                                    } else if (relationship_id=="") {
                                      showToast(
                                        'Provide nominee relation',
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
                                    } else if (selectedThree == false) {
                                      print('part time');
                                      showToast(
                                        'Upload photo',
                                      );
                                    } else if (selectedFour == false) {
                                      print('part time');
                                      showToast(
                                        'Upload signature',
                                      );
                                    } else {
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

  Widget dob_Age() {
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
                      String dateFormated =  DateFormat('yyyy-MM-dd').format(pickedDate);
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
                  fontWeight: FontWeight.w300),
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
              maxLength: 3),
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

  Widget description() {
    return TextFormField(
      controller: descriptionTextController,
      style: const TextStyle(
          color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
        hintText: "Description",
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
      maxLength: 300,
      maxLines: 4,
    );
  }

  Widget nomineeName() {
    return SizedBox(
      height: 45,
      child: TextFormField(
          controller: nomineeNameTextController,
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

  Widget nominee_dob_age() {
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
                  controller: nomineeDobTextController,
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
                          DateFormat('dd/MM/yyy').format(pickedDate);
                      String datedFormat =   DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        nomineeDob=datedFormat;
                        nomineeDobTextController.text =
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
              controller: nomineeAgeTextController,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300),
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
              maxLength: 3),
        ),
      ],
    );
  }

  Widget nomineeRelation() {
    Size size = MediaQuery.of(context).size;
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

      child: DropdownButton<String>(
        value: dropDownRelation,
        onChanged: (value) {
          setState(() {
            dropDownRelation = value;
          });
        },
        hint: Container(
          height: 45,
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Relationship',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        // Hide the default underline
        underline: Container(),
        // set the color of the dropdown menu
        dropdownColor: Colors.white,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        isExpanded: true,

        // The list of options
        items: spinnerRelation
            .map((e) => DropdownMenuItem(
                  value: e,
                  onTap: () {
                    if (e == spinnerRelation[0]) {
                      relationship_id = "1";
                      print(relationship_id);
                    } else if (e == spinnerRelation[1]) {
                      relationship_id = "2";
                      print(relationship_id);
                    } else {
                      relationship_id = "3";
                      print(relationship_id);
                    }
                  },
                  child: Text(
                    e,
                    style: const TextStyle(fontSize: 12),
                  ),
                ))
            .toList(),

        // Customize the selected item
        selectedItemBuilder: (BuildContext context) => spinnerRelation
            .map((e) => Container(
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      e,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ))
            .toList(),
      ),
      // child: DropdownButtonHideUnderline(
      //   child: Padding(
      //     padding:
      //     const EdgeInsets.only(left: 10.0),
      //     child: DropdownButton(
      //       hint: const Text("Occupation"),
      //       isExpanded: true,
      //       value: dropdownValuejob,
      //       icon: const Icon(Icons.arrow_drop_down),
      //       iconSize: 24,
      //       elevation: 16,
      //       style: const TextStyle(
      //           color: Colors.grey, fontSize: 12),
      //
      //       items: jobList.map((jobAll) {
      //         return DropdownMenuItem(
      //           value: jobAll.occupation,
      //           onTap: (){
      //             job_id = jobAll.id.toString();
      //             print("JobID$job_id");
      //           },
      //           child: Text(jobAll.occupation),
      //         );
      //       }).toList(),
      //       onChanged: (value) {
      //         String occupation= value.toString();
      //         print("Selected occupation is $occupation");
      //         dropdownValuejob = occupation;
      //         setState((){
      //           dropdownValuejob = occupation;
      //         });
      //       },
      //     ),
      //   ),
      // ),
    );
  }

  Widget panCard() {
    return Row(
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
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                    borderRadius: BorderRadius.circular(5),
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
    );
  }

  Widget aadhar() {
    return Row(
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
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                    borderRadius: BorderRadius.circular(5),
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
    );
  }

  Widget passportSizePhoto() {
    return Row(
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Image.file(
                        _imageFile3,
                        fit: BoxFit.fill,
                      )),
                  SizedBox(
                    width: 4.0,
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
                    borderRadius: BorderRadius.circular(5),
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
    );
  }

  Widget signature() {
    return Row(
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
        selectedFour
            ? Row(
                children: [
                  Container(
                      height: 100,
                      width: 150,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Image.file(
                        _imageFile4,
                        fit: BoxFit.fill,
                      )),
                  SizedBox(
                    width: 4.0,
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
                    borderRadius: BorderRadius.circular(5),
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
                "Signature On White Background paper\n AsPer The Pancard",
                style: TextStyle(
                    color: themeColor,
                    fontSize: 10,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w300),
              ),
      ],
    );
  }
}
