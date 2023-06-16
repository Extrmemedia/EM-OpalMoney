import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opal_money/ApiService/jobRegistrationApiService.dart';
import 'package:opal_money/Controller/payment_screen.dart';
import 'package:opal_money/Model/ModelJobRegistration.dart';
import '../ApiService/jobCategoryApiService.dart';
import '../ApiService/jobseeker_api.dart';
import '../Common/constants.dart';
import '../Model/ModelJobCategory.dart';
import '../Model/job_reg_model.dart';
import '../Model/job_seeker_model.dart';
import '../Utils/Connectivity.dart';
import '../Utils/loader.dart';
import '../Utils/toast.dart';
import 'dart:io';

class JobRegistrationScreen extends StatefulWidget {
  const JobRegistrationScreen({Key key}) : super(key: key);

  @override
  State<JobRegistrationScreen> createState() => _JobRegistrationScreenState();
}

class _JobRegistrationScreenState extends State<JobRegistrationScreen> {
  var nameTextController = TextEditingController();
  var mobileTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var dobTextController = TextEditingController();
  var expectedSalaryTextController = TextEditingController();
  var heightTextController = TextEditingController();
  var educationalTextController = TextEditingController();
  var jobTextController = TextEditingController();
  var addressTextController = TextEditingController();
  var mothersNameTextController = TextEditingController();
  var fathersNameTextController = TextEditingController();
  var experienceTextController = TextEditingController();
  var occupationTextController = TextEditingController();
  var workPlaceTextController = TextEditingController();
  var jobCategoryTextController = TextEditingController();
  String dateofBirth = '';
  String _selectedGender = 'male';
  String _selectedusertype = 'Overseas';
  String freshExpId;
  ModelJobRegistration modelJobRegistration;
  String experience = 'Fresher';
  String jobCategory = 'FullTime';
  String jobtype = "";
  ModelJobCategory modelJobCategory;

  List<JobCategory> jobtypeList = [];

  List<Exp> expList = <Exp>[
    Exp(id: 1, range: 'Fresher'),
    Exp(id: 2, range: '0-1'),
    Exp(id: 3, range: '1-2'),
    Exp(id: 4, range: '2-3'),
  ];
  List<JobCat> jobcatList = <JobCat>[
    JobCat(id: 1, cat: 'FullTime'),
    JobCat(id: 2, cat: 'PartTime'),
  ];

  String imageName;
  File _imageFile1;
  File _imageFile2;
  String image;
  String photo;
  String resume;
  String reg_type = "1";
  String gender_id = '0';
  String job_type_id = '3';
  String experience_id = '1';
  String job_cat_id = '1';
  String usertype_id = '0';

  bool selectedOne = false;
  bool selectedTwo = false;

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

        photo = image;
        //
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
      print("Image picker error $e");
    }
  }

  void _pickImage2() async {
    try {
      FilePickerResult pickedFile2 = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['pdf'],
          allowCompression: true,
          withData: true);
      //await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (!pickedFile2.files.single.path.split('/').last.contains('.pdf')) {
          showToast('Upload pdf');
        } else {
          image = pickedFile2.files.single.path.toString();
          imageName = pickedFile2.files.single.path.split('/').last;
          print(image);

          resume = image;
          //
          // print("image2$idproof");

          if (pickedFile2 != null) {
            _imageFile2 = File(pickedFile2.files.single.path);
            selectedTwo = true;
          } else {
            print('No image selected');
          }
        }
        // fileName = imageName;
      });
    } catch (e) {
      print("Image picker error ");
    }
  }

  List<JobSeeker> jbseeker = [];

  jobseeker() {
    JobSeekerApiService.jobseekerApiCall(context).then((value) {
      if (value['status'] == '1') {
        setState(() {
          jbseeker = ((value["data"] ?? []) as List)
              .map((li) => JobSeeker.fromJson(li))
              .toList();
        });
      } else {
        showToast(value['message']);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //JobCatApiCall();
    jobseeker();
  }

  JobCatApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        JobCategoryApiFunc();
      } else {
        showToast(
          "Please check your internet connection",
        );

        return;
      }
    });
  }

  JobCategoryApiFunc() {
    JobCategoryApiService.JobCategoryApiCall(context).then((result) async {
      try {
        // progressDialog.hide();

        // if (result.success==true) {
        setState(() {
          modelJobCategory = result;
          jobtypeList = modelJobCategory.data;
          jobtype = jobtypeList[0].jobtypes;
        });

        //showToast((result.message), gravity: Toast.BOTTOM, duration: 2);
        //}
      } catch (e) {}
    });
  }

  void jobApiFunc() {
    JobRegistrationApiService.jobFormApiCall(
            context: context,
            reg_type: reg_type,
            name: nameTextController.text,
            mobile: mobileTextController.text,
            emailid: emailTextController.text,
            dob: dateofBirth,
            gender: gender_id,
            height: heightTextController.text,
            qualifiaction: educationalTextController.text,
            experience: experienceTextController.text,
            name_father: fathersNameTextController.text,
            occupation: occupationTextController.text,
            name_mother: mothersNameTextController.text,
            job_type: job_type_id,
            job_cat: jobCategoryTextController.text,
            job_location: workPlaceTextController.text,
            exp_salary: expectedSalaryTextController.text,
            photo: _imageFile1,
            resume: _imageFile2)
        .then((model) async {
      try {
        print(model);
        if (model['success'] == true) {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return PaymentScreen(
                screen: 'jobconsultancy',
                //orderid: model['orderid'],
                //name: model['name'],
                amt: model['amount'],
                consultancyId: model['consultancyid'].toString(),
              );
            },
          ));
          //Navigator.pop(context);
        } else {
          showToast(model['message']);
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
              color: Colors.white70,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: const Text(
          "Job Registration",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              fontFamily: "Poppins"),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(left: 10, right: 10), child: Container()

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
              padding:
                  const EdgeInsets.only(left: 2, right: 2, top: 10, bottom: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: size.height * 0.8,
                    width: size.width,
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 30, bottom: 30),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Registration form",
                            style: TextStyle(
                              color: themeColor,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            Bidi.stripHtmlIfNeeded(
                                    jbseeker.isEmpty ? "" : jbseeker[0].details)
                                .trim(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                            ),
                          ),
                          const SizedBox(height: 20),
                          usertype(),
                          const SizedBox(
                            height: 20,
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
                          dobHeight(),
                          const SizedBox(
                            height: 10,
                          ),
                          gender(),
                          const SizedBox(
                            height: 20,
                          ),
                          educationalQualification(),
                          const SizedBox(
                            height: 20,
                          ),
                          fresherExperienced(),
                          const SizedBox(
                            height: 20,
                          ),
                          fathersName(),
                          const SizedBox(
                            height: 20,
                          ),
                          occupation(),
                          const SizedBox(
                            height: 20,
                          ),
                          mothersName(),
                          const SizedBox(
                            height: 20,
                          ),
                          jobType(),
                          const SizedBox(
                            height: 20,
                          ),
                          jobCat(),
                          const SizedBox(
                            height: 20,
                          ),
                          jobLocation(),
                          const SizedBox(height: 20),
                          expectedSalary(),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 120,
                                child: Text(
                                  "Upload Photo",
                                  style: TextStyle(
                                      color: themeColor,
                                      fontSize: 14,
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
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
                                        width: 90,
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
                                width: 120,
                                child: Text(
                                  "Upload Resume\n in pdf format",
                                  style: TextStyle(
                                      color: themeColor,
                                      fontSize: 14,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              selectedTwo
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          _imageFile2.path
                                                      .split('/')
                                                      .last
                                                      .length >
                                                  15
                                              ? '${_imageFile2.path.split('/').last.substring(0, 15)}...'
                                              : _imageFile2.path
                                                  .split('/')
                                                  .last,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: themeColor,
                                              fontSize: 14,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
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
                                        width: 90,
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
                              } else if (mobileTextController.text.isEmpty ||
                                  mobileTextController.text.length < 10) {
                                showToast(
                                  'Provide a valid mobile number',
                                );
                              } else if (emailTextController.text.isEmpty ||
                                  !emailTextController.text.contains('@') ||
                                  !emailTextController.text.contains('.')) {
                                showToast(
                                  'provide a valid mail id',
                                );
                              } else if (dobTextController.text.isEmpty) {
                                showToast(
                                  'Provide DOB',
                                );
                              } else if (heightTextController.text.isEmpty) {
                                showToast(
                                  'Provide height',
                                );
                              } else if (educationalTextController
                                  .text.isEmpty) {
                                showToast(
                                  'Provide educational qualification',
                                );
                              } else if (experienceTextController
                                  .text.isEmpty) {
                                showToast(
                                  'Provide experience',
                                );
                              } else if (fathersNameTextController
                                  .text.isEmpty) {
                                showToast(
                                  'Provide fathers name',
                                );
                              } else if (occupationTextController
                                  .text.isEmpty) {
                                showToast(
                                  'Provide occupation',
                                );
                              } else if (mothersNameTextController
                                  .text.isEmpty) {
                                showToast(
                                  'Provide mothers name',
                                );
                              } else if (jobCategoryTextController
                                  .text.isEmpty) {
                                showToast(
                                  'Provide job category',
                                );
                              } else if (workPlaceTextController.text.isEmpty) {
                                showToast(
                                  'Provide job location',
                                );
                              } else if (expectedSalaryTextController
                                  .text.isEmpty) {
                                showToast(
                                  'Provide expected salary',
                                );
                              } else if (selectedOne == false) {
                                showToast(
                                  'Upload Photo',
                                );
                              } else if (selectedTwo == false) {
                                print('part time');
                                showToast(
                                  'Upload Resume',
                                );
                              } else {
                                print('ok');
                                loader(context);
                                jobApiFunc();
                              }
                            },
                            child: Container(
                              height: 40,
                              width: size.width * 0.9,
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Radio<String>(
              value: 'Overseas',
              groupValue: _selectedusertype,
              onChanged: (value) {
                setState(() {
                  _selectedusertype = value;
                  usertype_id = "0";
                });
              },
            ),
            const Text(
              "Overseas",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              value: 'Within India',
              groupValue: _selectedusertype,
              onChanged: (value) {
                setState(() {
                  _selectedusertype = value;
                  usertype_id = "1";
                });
              },
            ),
            const Text("Within India",
                style: const TextStyle(
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
      height: 40,
      child: TextFormField(
          controller: nameTextController,
          style: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            labelText: "Name",
            labelStyle: const TextStyle(
                fontFamily: "Roboto",
                color: Colors.black54,
                fontSize: 14.0,
                fontWeight: FontWeight.w300),
            fillColor: Colors.white,
            filled: true,
            counterText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                style: BorderStyle.solid,
              ),
            ),
          ),
          keyboardType: TextInputType.text,
          maxLength: 30),
    );
  }

  Widget mobile() {
    return SizedBox(
      height: 40,
      child: TextFormField(
          controller: mobileTextController,
          style: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            labelText: "Mobile No",
            labelStyle: const TextStyle(
                fontFamily: "Roboto",
                color: Colors.black54,
                fontSize: 14.0,
                fontWeight: FontWeight.w300),
            fillColor: Colors.white,
            filled: true,
            counterText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                style: BorderStyle.solid,
              ),
            ),
          ),
          keyboardType: TextInputType.phone,
          maxLength: 10),
    );
  }

  Widget email() {
    return SizedBox(
      height: 40,
      child: TextFormField(
          controller: emailTextController,
          style: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            hintText: "Email ID",
            hintStyle: const TextStyle(
                fontFamily: "Roboto",
                color: Colors.black54,
                fontSize: 14.0,
                fontWeight: FontWeight.w300),
            fillColor: Colors.white,
            filled: true,
            counterText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                style: BorderStyle.solid,
              ),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          maxLength: 50),
    );
  }

  Widget dobHeight() {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: size.width * 0.40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                child: TextFormField(
                  controller: dobTextController,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    labelText: "DOB",
                    labelStyle: const TextStyle(
                        fontFamily: "Roboto",
                        color: Colors.black54,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300),
                    fillColor: Colors.white,
                    filled: true,
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        style: BorderStyle.solid,
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
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      String showDate =
                          DateFormat('dd/MM/yyyy').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        dateofBirth = formattedDate;
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
        const SizedBox(width: 10),
        SizedBox(
          height: 40,
          width: size.width * 0.39,
          child: TextFormField(
              controller: heightTextController,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                labelText: "height in ft",
                labelStyle: const TextStyle(
                    fontFamily: "Roboto",
                    color: Colors.black54,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300),
                fillColor: Colors.white,
                filled: true,
                counterText: "",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    style: BorderStyle.solid,
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Radio<String>(
              activeColor: themeColor,
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
              activeColor: themeColor,
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
      ],
    );
  }

  Widget educationalQualification() {
    return SizedBox(
      height: 40,
      child: TextFormField(
          controller: educationalTextController,
          style: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            labelText: "Educational Qualification",
            labelStyle: const TextStyle(
                fontFamily: "Roboto",
                color: Colors.black54,
                fontSize: 14.0,
                fontWeight: FontWeight.w300),
            fillColor: Colors.white,
            filled: true,
            counterText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                style: BorderStyle.solid,
              ),
            ),
          ),
          keyboardType: TextInputType.text,
          maxLength: 50),
    );
  }

  Widget fresherExperienced() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 40,
      child: TextFormField(
          controller: experienceTextController,
          style: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            labelText: "Experience",
            labelStyle: const TextStyle(
                fontFamily: "Roboto",
                color: Colors.black54,
                fontSize: 14.0,
                fontWeight: FontWeight.w300),
            fillColor: Colors.white,
            filled: true,
            counterText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                style: BorderStyle.solid,
              ),
            ),
          ),
          keyboardType: TextInputType.text,
          maxLength: 50),
    );
  }

  Widget fathersName() {
    return SizedBox(
      height: 40,
      child: TextFormField(
          controller: fathersNameTextController,
          style: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            labelText: "Father's name",
            labelStyle: const TextStyle(
                fontFamily: "Roboto",
                color: Colors.black54,
                fontSize: 14.0,
                fontWeight: FontWeight.w300),
            fillColor: Colors.white,
            filled: true,
            counterText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                style: BorderStyle.solid,
              ),
            ),
          ),
          keyboardType: TextInputType.text,
          maxLength: 50),
    );
  }

  Widget occupation() {
    return SizedBox(
      height: 40,
      child: TextFormField(
          controller: occupationTextController,
          style: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            labelText: "Occupation",
            labelStyle: const TextStyle(
                fontFamily: "Roboto",
                color: Colors.black54,
                fontSize: 14.0,
                fontWeight: FontWeight.w300),
            fillColor: Colors.white,
            filled: true,
            counterText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                style: BorderStyle.solid,
              ),
            ),
          ),
          keyboardType: TextInputType.text,
          maxLength: 50),
    );
  }

  Widget mothersName() {
    return SizedBox(
      height: 40,
      child: TextFormField(
          controller: mothersNameTextController,
          style: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            labelText: "Mother's Name",
            labelStyle: const TextStyle(
                fontFamily: "Roboto",
                color: Colors.black54,
                fontSize: 14.0,
                fontWeight: FontWeight.w300),
            fillColor: Colors.white,
            filled: true,
            counterText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                style: BorderStyle.solid,
              ),
            ),
          ),
          keyboardType: TextInputType.text,
          maxLength: 50),
    );
  }

  Widget jobType() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: Container(
        height: 40,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black54,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: DropdownButtonHideUnderline(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: DropdownButton(
              isExpanded: true,
              value: jobCategory,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              onChanged: (data) {},
              items: jobcatList.map((JobCat) {
                return DropdownMenuItem(
                  onTap: () {
                    setState(() {
                      jobCategory = JobCat.cat;
                      job_cat_id = JobCat.id.toString();
                    });
                  },
                  value: JobCat.cat,
                  child: Text(JobCat.cat),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget jobCat() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: jobCategoryTextController,
        style: const TextStyle(
            color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          labelText: "Preferred Job",
          labelStyle: const TextStyle(
              fontFamily: "Roboto",
              color: Colors.black54,
              fontSize: 14.0,
              fontWeight: FontWeight.w300),
          fillColor: Colors.white,
          filled: true,
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              style: BorderStyle.solid,
            ),
          ),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget jobLocation() {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: workPlaceTextController,
        style: const TextStyle(
            color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          labelText: "Preferred Job Location",
          labelStyle: const TextStyle(
              fontFamily: "Roboto",
              color: Colors.black54,
              fontSize: 14.0,
              fontWeight: FontWeight.w300),
          fillColor: Colors.white,
          filled: true,
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              style: BorderStyle.solid,
            ),
          ),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget expectedSalary() {
    return SizedBox(
      height: 40,
      child: TextFormField(
          controller: expectedSalaryTextController,
          style: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            hintText: "Expected Salary",
            hintStyle: const TextStyle(
                fontFamily: "Roboto",
                color: Colors.black54,
                fontSize: 14.0,
                fontWeight: FontWeight.w300),
            fillColor: Colors.white,
            filled: true,
            counterText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                style: BorderStyle.solid,
              ),
            ),
          ),
          keyboardType: TextInputType.phone,
          maxLength: 10),
    );
  }
}
