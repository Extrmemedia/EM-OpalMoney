import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opal_money/ApiService/matrimonyApiService.dart';
import 'package:opal_money/Common/constants.dart';
import 'package:opal_money/Model/ModelMatrimony.dart';
import 'package:opal_money/Utils/Global.dart';
import 'package:toast/toast.dart';

import '../Utils/Connectivity.dart';
import '../Utils/loader.dart';
import '../Utils/toast.dart';
import 'enquirysuccess_screen.dart';
import 'home_page_screen.dart';
import 'dart:io';

class MatrimonialRegistrationScreen extends StatefulWidget {
  const MatrimonialRegistrationScreen({Key key}) : super(key: key);

  @override
  State<MatrimonialRegistrationScreen> createState() =>
      _MatrimonialRegistrationScreenState();
}

class _MatrimonialRegistrationScreenState
    extends State<MatrimonialRegistrationScreen> {
  var nameTextController = TextEditingController();
  var mobileTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var dobTextController = TextEditingController();
  var tobTextController = TextEditingController();
  var heightTextController = TextEditingController();
  var educationalTextController = TextEditingController();
  var jobTextController = TextEditingController();
  var addressTextController = TextEditingController();
  var mothersNameTextController = TextEditingController();
  var fathersNameTextController = TextEditingController();
  var whatsappTextController = TextEditingController();
  var occupationTextController = TextEditingController();
  var workPlaceTextController = TextEditingController();
  String _selectedGender = 'male';
  String gender_id = '0';
  String imageName;
  File _imageFile1;
  File _imageFile2;
  String image;
  String photo;
  String grihanila;
  bool selectedOne = false;
  bool selectedTwo = false;
  ModelMatrimony modelMatrimony;
  String formattedDate='';

  List<String> spinnerItemsStar = [
    'Star',
    'Aswathy',
    'Bharani',
    'Karthika',
    'Rohini',
    'Makayiram',
    'Thiruvathira',
    'Punartham',
    'Pooyam',
    'Ayilyam',
    'Makam',
    'Pooram',
    'Uthram',
    'Atham',
    'Chithira',
    'Chothi',
    'Vishakam',
    'Anizham',
    'Triketta',
    'Moolam',
    'Pooradam',
    'Uthradam',
    'Thiruvonam',
    'Avittam',
    'Chathayam',
    'Pururuttathi',
    'Uthrittathi',
    'Revathi'
  ];
  List<String> spinnerItemsReligion = [
    'Religion',
    'Hindu',
    'Muslim',
    'Christian',
    'Others',
  ];
  String dropdownValueStar = 'Star';
  String dropdownValueReligion = 'Religion';

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

        //print("image1$pan");

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
          //allowedExtensions: ['jpg','png'],
          allowCompression: true,
          withData: true);
      //await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = pickedFile2.files.single.path.toString();
        imageName = pickedFile2.files.single.path.split('/').last;
        print(image);

        // idproof = image;

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

  matrimonyFormApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();

        matrimonyApiFunc();
      } else {
        showToast(
          "Please check your internet connection",
        );

        return;
      }
    });
  }

  void matrimonyApiFunc() {
    print("ID${Global.shared.id}");
    print("name${nameTextController.text}");
    print("mobile${mobileTextController.text}");
    print("email${emailTextController.text}");
    print("dob${dobTextController.text}");
    print("tob${tobTextController.text}");
    print("star${dropdownValueStar}");
    print("religion${dropdownValueReligion}");
    print("gender${gender_id}");
    print("height${heightTextController.text}");
    print("religion${dropdownValueReligion}");
    print("gender${gender_id}");
    print("height${heightTextController.text}");
    print("educa${educationalTextController.text}");
    print("job${jobTextController.text}");
    print("father${fathersNameTextController.text}");

    print("occup${occupationTextController.text}");
    print("address${addressTextController.text}");
    print("mother${mothersNameTextController.text}");
    print("whatsapp${whatsappTextController.text}");
    print("workplaceadd${workPlaceTextController.text}");
    print("photo${photo}");
    print("grehano${grihanila}");

    MatrimonyApiService.matrimonyFormApiCall(
            context,
            Global.shared.userId,
            nameTextController.text,
            mobileTextController.text,
            emailTextController.text,
           formattedDate,
            tobTextController.text,
            dropdownValueStar,
            dropdownValueReligion,
            gender_id,
            heightTextController.text,
            educationalTextController.text,
            jobTextController.text,
            fathersNameTextController.text,
            occupationTextController.text,
            mothersNameTextController.text,
            addressTextController.text,
            whatsappTextController.text,
            workPlaceTextController.text,
            _imageFile1,
            _imageFile2)
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

        } else {
          Navigator.pop(context);
          showToast(model['message']);
        }
      } catch (e) {
        Navigator.pop(context);
        showToast(model['message']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ToastContext().init(context);

    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: themeColor,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 26,
              color: Colors.white70,
            ),
            onPressed: () {
              Navigator.pop(context);
            },

        ),
        title: const Text(
          "Matrimonial Registration",
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
              padding:
                  const EdgeInsets.only(left: 2, right: 2, top: 10, bottom: 10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                  child: Container(
                    height: size.height * 0.8,
                    width: size.width,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            width: size.width,
                            child: Card(
                              elevation: 5,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: RichText(
                                    textAlign: TextAlign.justify,
                                    softWrap: true,
                                    text: const TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent

                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Note :- ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                              fontSize: 13,
                                              fontFamily: "Roboto",
                                            )),
                                        TextSpan(
                                          text:
                                              'Anybody interested for looking marriage can give the details of the person in detail.For getting the details of the proposals can register with us and once complete the details clearly will find the partner,its absolutely free for registered agent with us.',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Roboto",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10, top: 10, bottom: 20),
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
                                const SizedBox(height: 30),
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
                                dobTob(),
                                const SizedBox(
                                  height: 20,
                                ),
                                starReligion(),
                                const SizedBox(
                                  height: 20,
                                ),
                                gender(),
                                const SizedBox(
                                  height: 20,
                                ),
                                educational(),
                                const SizedBox(
                                  height: 20,
                                ),
                                jobBusiness(),
                                const SizedBox(
                                  height: 20,
                                ),
                                fatherName(),
                                const SizedBox(
                                  height: 20,
                                ),
                                occupation(),
                                const SizedBox(
                                  height: 20,
                                ),
                                motherName(),
                                const SizedBox(height: 20),
                                address(),
                                const SizedBox(
                                  height: 20,
                                ),
                                anydemand(),
                                const SizedBox(height: 20),
                                workPlaceAddress(),
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
                                        "Upload Grehanila",
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
                                      showToast('Provide name');
                                    } else if (mobileTextController
                                            .text.isEmpty ||
                                        mobileTextController.text.length < 10) {
                                      showToast(
                                          'Provide a valid mobile number');
                                    } else if (emailTextController
                                            .text.isEmpty ||
                                        !emailTextController.text
                                            .contains('@') ||
                                        !emailTextController.text
                                            .contains('.')) {
                                      showToast('provide a valid mail id');
                                    } else if (dobTextController.text.isEmpty) {
                                      showToast('Provide DOB');
                                    } else if (tobTextController.text.isEmpty) {
                                      showToast('Provide tob');
                                    } else if (heightTextController
                                        .text.isEmpty) {
                                      showToast('Provide height');
                                    } else if (educationalTextController
                                        .text.isEmpty) {
                                      showToast(
                                        'Provide educational qualification',
                                      );
                                    } else if (jobTextController.text.isEmpty) {
                                      showToast('Provide job/business');
                                    } else if (fathersNameTextController
                                        .text.isEmpty) {
                                      showToast('Provide fathers name');
                                    } else if (occupationTextController
                                        .text.isEmpty) {
                                      showToast('Provide occupation');
                                    } else if (mothersNameTextController
                                        .text.isEmpty) {
                                      showToast(
                                        'Provide mothers name',
                                      );
                                    } else if (addressTextController
                                        .text.isEmpty) {
                                      showToast('Provide address');
                                    } else if (whatsappTextController
                                        .text.isEmpty) {
                                      showToast('Provide demands');
                                    } else if (workPlaceTextController
                                        .text.isEmpty) {
                                      showToast(
                                        'Provide working place address',
                                      );
                                    } else if (selectedOne == false) {
                                      showToast(
                                        'Upload photo',
                                      );
                                    } else if (selectedTwo == false) {
                                      print('part time');
                                      showToast(
                                        'Upload grehanila',
                                      );
                                    } else {
                                      print('ok');
                                      loader(context);
                                      matrimonyFormApiCall();
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
      ),
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
            labelText: "Email ID",
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
          keyboardType: TextInputType.emailAddress,
          maxLength: 50),
    );
  }

  Widget dobTob() {
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
                      color: Colors.black54,
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
                      String formatDate =
                          DateFormat('dd/MM/yyyy').format(pickedDate);
                      String f =   DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        formattedDate=f;
                        dobTextController.text =
                            formatDate; //set output date to TextField value.
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
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          height: 40,
          width: size.width * 0.40,
          child: TextFormField(
              controller: tobTextController,
              style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                labelText: "TOB",
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
              keyboardType: TextInputType.datetime,
              maxLength: 50),
        ),
      ],
    );
  }

  Widget starReligion() {
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
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValueStar,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                        onChanged: (data) {
                          setState(() {
                            dropdownValueStar = data.toString();
                          });
                        },
                        items: spinnerItemsStar
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          child: Container(
            height: 40,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black54,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownValueReligion,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                  onChanged: (data) {
                    setState(() {
                      dropdownValueReligion = data.toString();
                    });
                  },
                  items: spinnerItemsReligion
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget gender() {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Radio<String>(
              activeColor: themeColor,
              value: 'male',
              groupValue: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
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
                });
              },
            ),
            const Text("Female"),
          ],
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

  Widget educational() {
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

  Widget jobBusiness() {
    return SizedBox(
      height: 40,
      child: TextFormField(
          controller: jobTextController,
          style: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            labelText: "Job/Business",
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

  Widget fatherName() {
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

  Widget motherName() {
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

  Widget address() {
    return SizedBox(
      //height: 60,
      child: TextFormField(
        controller: addressTextController,
        minLines:
            2, // any number you need (It works as the rows for the textarea)
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: const TextStyle(
            color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          hintText: "Address",
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
      ),
    );
  }

  Widget anydemand() {
    return SizedBox(
      height: 40,
      child: TextFormField(
          controller: whatsappTextController,
          style: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            labelText: "Any Demands",
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
          maxLength: 10),
    );
  }

  Widget workPlaceAddress() {
    return SizedBox(
      //height: 60,
      child: TextFormField(
        controller: workPlaceTextController,
        minLines:
            2, // any number you need (It works as the rows for the textarea)
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: const TextStyle(
            color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          labelText: "Address of working place",
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
      ),
    );
  }
}
