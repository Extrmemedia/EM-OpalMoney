import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opal_money/Utils/loader.dart';
import 'package:toast/toast.dart';
import '../ApiService/delete_api.dart';
import '../ApiService/profile_update_api.dart';
import '../Common/constants.dart';
import '../Model/ModelOccupation.dart';
import '../Utils/Global.dart';
import '../Utils/toast.dart';
import 'home_page_screen.dart';

class UpdateProfileScreen extends StatefulWidget {
  String selectedGender = '',
      gender = 'Male',
      name,
      mob,
      mail,
      age,
      addr,
      panCard,
      proof,
      photo,
      dob = '',
      profileImg,
      code = '',
      dropdownValue = '',
      userType = '',
      joB = '';
  String deletePan;String deleteProof;String deletePhoto;
  int  userTypeId;
String jobId;


  List<Occupation> occupations = [];

  UpdateProfileScreen(
      {Key key,
      this.selectedGender,
      this.name,
      this.mob,
      this.mail,
      this.age,
      this.addr,
      this.occupations,
      this.jobId,
      this.panCard,
      this.proof,
      this.photo,
      this.dob,
      this.profileImg,
      this.joB,
      this.code,
      this.dropdownValue,
      this.gender,this.deletePan,this.deletePhoto,this.deleteProof,
      this.userType,
      this.userTypeId})
      : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String _selectedGender = 'male';
  String dropdownValue = 'Occupation';
  String imgUrl = 'http://opalmoney.biz/app/images/registration/';
  TextEditingController name = TextEditingController();
  TextEditingController mob = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController addr = TextEditingController();

  var dobTextController = TextEditingController();

  String imageName;
  File _imageFile1;
  File _imageFile2;
  File _imageFile3;
  File _imageFile4;

  String image = '';
  // String pan;
  // String idproof;
  // String photo;
  String joB = '';
  String job_id = '0';
  String gender_id = '0';
  String usertype_id = '';
  String formattedDate = '';
  bool selectedOne = false;
  bool selectedTwo = false;
  bool selectedThree = false;
  bool selectedFour = false;

  void _pickImage1() async {
    try {
      FilePickerResult pickedFile1 = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.media,
          //allowedExtensions: ['jpg','png'],
          allowCompression: true,
          withData: true);
      // await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = pickedFile1.files.single.path;
        imageName = pickedFile1.files.single.path.split('/').last;
        print(image);

        widget.panCard = image;

        print("image1${ widget.panCard}");

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

        widget.proof = image;

        print("image2${widget.proof}");

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
          // allowedExtensions: ['jpg','png'],
          allowCompression: true,
          withData: true);
      // await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = pickedFile3.files.single.path.toString();
        imageName = pickedFile3.files.single.path.split('/').last;
        print(image);

        widget.photo = image;

        print("image3${widget.photo}");

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
          // allowedExtensions: ['jpg','png'],
          allowCompression: true,
          withData: true);
      // await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        // image = pickedFile4.path.toString();
        // resume = pickedFile4.files.single.path.split('/').last;
        print(image);
        // resume = image;

        // print("image4$resume");

        if (pickedFile4 != null) {
          _imageFile4 = File(pickedFile4.files.single.path);
          selectedFour = true;
          loader(context);
          imgform();
        } else {
          print('No image selected');
        }
        // fileName = imageName;
      });
    } catch (e) {
      print("Image picker error ");
    }
  }

  void profileform() {
    String genderID;
    String userType;
    setState(() {
      if (widget.gender == 'Male') {
        genderID = '0';
      } else if (widget.gender == 'Female') {
        genderID = '1';
      } else {
        genderID = '2';
      }
      if (widget.userType == 'part-time employee') {
        usertype_id = '0';
      } else if (widget.userType == 'agent') {
        usertype_id = '1';
      } else {
        usertype_id = '2';
      }
    });
    ProfileUpdateApiService.profileApiCall(
            context,
            usertype_id,
            Global.shared.id,
            name.text,
            mob.text,
            mail.text,
            formattedDate,
            age.text,
            genderID,
            addr.text,
            widget.jobId.toString(),
            _imageFile1,
            _imageFile2,
            _imageFile3)
        .then((model) async {
      try {
        print(model);
        if (model['status'] == '1') {
          showToast(
            model['message'],
          );
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          showToast(model['message']);
          Navigator.pop(context);
        }
      } catch (e) {
        print(e);
        showToast(
          e.toString(),
        );
        Navigator.pop(context);
        //throw Exception('Failed');
      }
    });
  }

  void imgform() {
    ProfileUpdateApiService.profileimgApiCall(_imageFile4).then((model) async {
      try {
        print(model);
        if (model['status'] == '1') {
          showToast(model['message']);
          Navigator.pop(context);
        } else {
          showToast(model['message']);
          Navigator.pop(context);
        }
      } catch (e) {
        print(e);
        showToast(e.toString());
        Navigator.pop(context);
        //throw Exception('Failed');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      name.text = widget.name;
      mob.text = widget.mob;
      mail.text = widget.mail;
      age.text = widget.age;
      addr.text = widget.addr;
      dobTextController.text = widget.dob;
      formattedDate = widget.dob;
      print("h ");
    });
  }

  List<String> spinnerItems = ['Occupation', 'Two', 'Three', 'Four', 'Five'];
  List<String> gender = ['Male', 'Female', 'Others'];

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
                                          // backgroundImage: AssetImage(
                                          //   "assets/images/profile_img.png",
                                          // ),
                                          child:  selectedFour
                                              ? Container(
                                                  width: 50,
                                                  height: 50,
                                                  child: Image.file(
                                                    _imageFile4,
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                              :  CachedNetworkImage(
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.fill,
                                                  imageUrl: baseURL +
                                                      widget.profileImg,
                                                  placeholder: (context, url) =>
                                                      Container(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.person)),
                                        ),
                                        Positioned(
                                          top: 60,
                                          left: 50,
                                          child: InkWell(
                                            onTap: () {
                                              print('aaaaa');
                                              _pickImage4();
                                            },
                                            child: Image.asset(
                                              "assets/images/plus_rounded.png",
                                              height: 20,
                                              width: 25,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Visibility(
                                  visible: false,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Radio<String>(
                                            value: 'user',
                                            groupValue: widget.userType,
                                            onChanged: (value) {
                                              setState(() {
                                                widget.userType = value;
                                              });
                                            },
                                          ),
                                          const Text("User"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio<String>(
                                            value: 'part-time employee',
                                            groupValue: widget.userType,
                                            onChanged: (value) {
                                              setState(() {
                                                widget.userType = value;
                                              });
                                            },
                                          ),
                                          const Text("Part-Time Employee"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio<String>(
                                            value: 'agent',
                                            groupValue: widget.userType,
                                            onChanged: (value) {
                                              setState(() {
                                                widget.userType = value;
                                              });
                                            },
                                          ),
                                          const Text("Agent"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: const Text(
                                    'Name',
                                    style: TextStyle(
                                        color: themeColor,
                                        fontSize: 16,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  child: TextFormField(
                                      controller: name,
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
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: const Text(
                                    'Mobile No',
                                    style: TextStyle(
                                        color: themeColor,
                                        fontSize: 16,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  child: TextFormField(
                                      controller: mob,
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
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: const Text(
                                    'Email ID',
                                    style: TextStyle(
                                        color: themeColor,
                                        fontSize: 16,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  child: TextFormField(
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
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: const Text(
                                              'Date of Birth',
                                              style: TextStyle(
                                                  color: themeColor,
                                                  fontSize: 16,
                                                  fontFamily: "Roboto",
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
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
                                                  String formatDate =
                                                      DateFormat('dd/MM/yyyy')
                                                          .format(pickedDate);
                                                  String f =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(pickedDate);
                                                  print(
                                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                                  //you can implement different kind of Date Format here according to your requirement

                                                  setState(() {
                                                    formattedDate = f;
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
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: const Text(
                                            'Age',
                                            style: TextStyle(
                                                color: themeColor,
                                                fontSize: 16,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 45,
                                          width: size.width * 0.44,
                                          child: TextFormField(
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
                                                    fontWeight:
                                                        FontWeight.w400),
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
                                              keyboardType:
                                                  TextInputType.number,
                                              maxLength: 50),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: const Text(
                                            'Gender',
                                            style: TextStyle(
                                                color: themeColor,
                                                fontSize: 16,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Container(
                                          height: 45,
                                          width: size.width * 0.44,
                                          decoration: BoxDecoration(
                                            color: greyColor,
                                            border: Border.all(
                                              color: greyColor,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: DropdownButton<String>(
                                                isExpanded: true,
                                                value: widget.gender,
                                                icon: const Icon(
                                                    Icons.arrow_drop_down),
                                                iconSize: 24,
                                                elevation: 16,
                                                // style: const TextStyle(
                                                //     //color: Colors.grey,
                                                //     fontSize: 12),
                                                onChanged: (data) {
                                                  setState(() {
                                                    widget.gender =
                                                        data.toString();
                                                  });
                                                },
                                                items: gender.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: const Text(
                                            'Occupation',
                                            style: TextStyle(
                                                color: themeColor,
                                                fontSize: 16,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Container(
                                          height: 45,
                                          width: size.width * 0.44,
                                          decoration: BoxDecoration(
                                            color: greyColor,
                                            border: Border.all(
                                              color: greyColor,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: DropdownButton(
                                                hint: const Text('Occupation'),
                                                items: widget.occupations
                                                    .map((item) {
                                                  return DropdownMenuItem(
                                                    value: item.occupation
                                                        .toString(),
                                                    child: Text(item.occupation
                                                        .toString()),
                                                    onTap: () {
                                                      setState(() {
                                                        widget.jobId = item.id.toString();
                                                      });                                                    },
                                                  );
                                                }).toList(),
                                                onChanged: (newValSubject) {
                                                  setState(() {
                                                    widget.joB = newValSubject;
                                                   // widget.jobId = newValSubject;
                                                  });
                                                  print(widget.jobId);
                                                },
                                                value: widget.joB=='Not Selected'?widget.occupations.first.occupation:widget.joB,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: const Text(
                                    'Address',
                                    style: TextStyle(
                                        color: themeColor,
                                        fontSize: 16,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                TextFormField(
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
                                      width: 130,
                                      child: Text(
                                        "Pancard",
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
                                                    widget.panCard = 'null';
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
                                        : widget.panCard == 'null'
                                        ? TextButton(
                                                onPressed: () {
                                                  _pickImage1();
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 90,
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
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  // _pickImage1();
                                                },
                                                child: CachedNetworkImage(
                                                    width: 100,
                                                    height: 150,
                                                    fit: BoxFit.fill,
                                                    imageUrl:
                                                        imgUrl + widget.panCard,
                                                    placeholder:
                                                        (context, url) =>
                                                            Container(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Text(
                                                          'No Image',
                                                          style: TextStyle(
                                                              color: themeColor,
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )),
                                              ),
                                    Visibility(
                                      visible:
                                          widget.deletePan == 'null' ? false : true,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: InkWell(
                                          onTap: () {
                                            DeleteApiService.deleteApiCall(
                                                    context,
                                                    'api/pancard-remove',
                                                    widget.userTypeId
                                                        .toString())
                                                .then((value) {
                                              if (value['status'] == "1") {
                                                setState(() {
                                                  selectedOne=false;
                                                  widget.panCard='null';
                                                  widget.deletePan='null';

                                                });
                                                showToast(value['message']);
                                              } else {
                                                showToast(value['message']);
                                              }
                                            });
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 130,
                                      child: Text(
                                        "Aadhar/Passport/\nVoters ID",
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
                                                    widget.proof = 'null';
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
                                        : widget.proof == 'null'
                                        ? TextButton(
                                                onPressed: () {
                                                  _pickImage2();
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 90,
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
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  // _pickImage2();
                                                },
                                                child: CachedNetworkImage(
                                                    width: 100,
                                                    height: 150,
                                                    fit: BoxFit.fill,
                                                    imageUrl:
                                                        imgUrl + widget.proof,
                                                    placeholder:
                                                        (context, url) =>
                                                            Container(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Text(
                                                          'No Image',
                                                          style: TextStyle(
                                                              color: themeColor,
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )),
                                              ),
                                    Visibility(
                                      visible:
                                          widget.deleteProof == 'null'  ? false : true,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: InkWell(
                                          onTap: () {
                                            DeleteApiService.deleteApiCall(
                                                    context,
                                                    'api/aadhaar-remove',
                                                    widget.userTypeId
                                                        .toString())
                                                .then((value) {
                                              if (value['status'] == "1") {
                                                setState(() {
                                                  selectedTwo=false;
                                                  widget.proof ='null';
                                                  widget.deleteProof='null';
                                                });
                                                showToast(
                                                  value['message'],
                                                );
                                              } else {
                                                showToast(value['message']);
                                              }
                                            });
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 130,
                                      child: Text(
                                        "Passport\nsize photo",
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
                                                width: 4.0,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    widget.photo ='null';
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
                                        : widget.photo =='null'
                                            ? TextButton(
                                                onPressed: () {
                                                  _pickImage3();
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 90,
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
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  // _pickImage3();
                                                },
                                                child: CachedNetworkImage(
                                                    width: 100,
                                                    height: 150,
                                                    fit: BoxFit.fill,
                                                    imageUrl:
                                                        imgUrl + widget.photo,
                                                    placeholder:
                                                        (context, url) =>
                                                            Container(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Text(
                                                          'No Image',
                                                          style: TextStyle(
                                                              color: themeColor,
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )),
                                              ),
                                    Visibility(
                                      visible:
                                          widget.deletePhoto =='null' ? false : true,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: InkWell(
                                          onTap: () {
                                            DeleteApiService.deleteApiCall(
                                                    context,
                                                    'api/passportphoto-remove',
                                                    widget.userTypeId
                                                        .toString())
                                                .then((value) {
                                              if (value['status'] == "1") {
                                                setState(() {
                                                  selectedThree=false;
                                                  widget.photo = 'null';
                                                  widget.deletePhoto='null';
                                                });
                                                Toast.show(value['message']);
                                              } else {
                                                showToast(value['message']);
                                              }
                                            });
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                TextButton(
                                  onPressed: () {
                                    // if (widget.panCard =='null') {
                                    //   showToast('Upload pancard');
                                    // } else if (widget.proof=='null') {
                                    //   showToast(
                                    //     'Upload proof',
                                    //   );
                                    // } else if (widget.photo =='null') {
                                    //   showToast('Upload photo');
                                    // } else {
                                      loader(context);
                                      profileform();
                                    //}
                                    //imgform();
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
                                        "Update",
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
