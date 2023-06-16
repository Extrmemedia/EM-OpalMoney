import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/ApiService/locationApiService.dart';
import 'package:opal_money/ApiService/occupationApiService.dart';
import 'package:opal_money/ApiService/sellingApiService.dart';
import 'package:opal_money/ApiService/typeApiService.dart';
import 'package:opal_money/Controller/real_estate_screen.dart';
import 'package:opal_money/Model/ModelLocation.dart';
import 'package:opal_money/Model/ModelOccupation.dart';
import 'package:opal_money/Model/ModelSelling.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Model/ModelType.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import '../Utils/loader.dart';
import '../Utils/toast.dart';

class SellingScreen extends StatefulWidget {
  const SellingScreen({Key key}) : super(key: key);

  @override
  State<SellingScreen> createState() => _SellingScreenState();
}

class _SellingScreenState extends State<SellingScreen> {
  var expectedRateTextController = TextEditingController();
  var locationTextController = TextEditingController();
  var areaMeasureTextController = TextEditingController();
  var descriptionTextController = TextEditingController();
  ModelSelling modelSelling;
  ModelLocation modelLocation;
  ModelOccupation modelOccupation;
  ModelType modelType;
  List<Occupation> jobList;
  List<Type> typeList;
  List<LocationList> locationList;
  String dropdownValueLoc = "Trivandrum";
  String dropdownValueType = "Land and Plots";
  String dropdownValueJob = "Business";
  String dropdownArea;
  String _fixedorneg = "fixed";
  List<String> spinnerItems = ['Cent', 'Sqft'];
  String uploadurl = "https://digitalextreme.in/opalmoneyindia/api/save-real-estate";

  String image;
  String image1;
  String image2;
  String image3;
  String image4;
  String imageName;
  File _imageFile1;
  File _imageFile2;
  File _imageFile3;
  File _imageFile4;
  String type_id = "1";
  String rate_id = "1";
  String area_type_id = "1";
  String district_id = "1";
  bool selectedOne = false;
  bool selectedTwo = false;
  bool selectedThree = false;
  bool selectedFour = false;

  void _pickImage1() async {
    try {
      FilePickerResult pickedFile1 =await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.media,
        //  allowedExtensions: ['jpg','png'],
          allowCompression: true,
          withData: true
      );
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
      FilePickerResult pickedFile2 =await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.media,
          //allowedExtensions: ['jpg','png'],
          allowCompression: true,
          withData: true
      );
      //await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = pickedFile2.files.single.path.toString();
        imageName =pickedFile2.files.single.path.split('/').last;
        print(image);

        //idproof = image;

      //  print("image2$idproof");

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
          allowMultiple: false,
          type: FileType.media,
        //  allowedExtensions: ['jpg','png'],
          allowCompression: true,
          withData: true
      );
      // await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = pickedFile3.files.single.path.toString();
        imageName = pickedFile3.files.single.path.split('/').last;
        print(image);

       // photo = image;

       // print("image3$photo");

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
          withData: true
      );
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

  @override
  void initState() {
    super.initState();
    locationListApiCall();
    typeListApiCall();
  }



  locationListApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        locApiFunc();
      } else {
        showToast("Please check your internet connection",);

        return;
      }
    });
  }

  locApiFunc() {
    LocationApiService.locationApiCall(context).then((result) async {
      try {
        // showToast(result.message.toString(),
        //     gravity: Toast.BOTTOM, duration: 2);

        // progressDialog.hide();
        if (result.success) {
          setState(() {
            modelLocation = result;
            locationList = modelLocation.data;
          });

         // showToast((result.message), gravity: Toast.BOTTOM, duration: 2);
        }else{
        // await progressDialog.hide();
          //showToast((result.message));
        }
      } catch (e) {
        //await progressDialog.hide();
      }
    });
  }

  Future<ModelLocation> getLocationList() async {
    locationList = modelLocation.data;
    return modelLocation;
  }

  jobListApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        jobApiFunc();
      } else {
        showToast("Please check your internet connection");

        return;
      }
    });
  }

  jobApiFunc() {
    OccupationApiService.occupationApiCall(context).then((result) async {
      try {
        //showToast(result.message.toString());

        // progressDialog.hide();
        if (result.success) {
          setState(() {
            modelOccupation = result;
            jobList = modelOccupation.data;
          });

         // showToast((result.message));
        }
        // await progressDialog.hide();
        showToast((result.message));
      } catch (e) {
        //await progressDialog.hide();
      }
    });
  }

  Future<ModelOccupation> getJobList() async {
    jobList = modelOccupation.data;
    return modelOccupation;
  }

  typeListApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        typeApiFunc();
      } else {
        showToast("Please check your internet connection",);

        return;
      }
    });
  }

  typeApiFunc() {
    TypeApiService.typeApiCall(context).then((result) async {
      try {
      //  showToast(result.message.toString());

        // progressDialog.hide();
        if (result.success) {
          setState(() {
            modelType = result;
            typeList = modelType.data;
          });

        //  showToast((result.message),);
        }
        // await progressDialog.hide();
       // showToast((result.message));
      } catch (e) {
        //await progressDialog.hide();
      }
    });
  }

  Future<ModelType> getTypeList() async {
    typeList = modelType.data;
    return modelType;
  }

  sellingApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();

        sellingApiFunc();
      } else {
        showToast("Please check your internet connection",);

        return;
      }
    });
  }

  sellingApiFunc() {
    print("ID${Global.shared.userId}");
    print("typeID$type_id");
    print("Rate${expectedRateTextController.text}");
    print("RateId$rate_id");
    print("AreaTYPe$area_type_id");
    print("measure${areaMeasureTextController.text}");
    print("DIsID$district_id");
    print("loc${locationTextController.text}");
    print("desc${descriptionTextController.text}");
    print(image1);
    print(image2);
    print(image3);
    print(image4);

    SellingApiService.sellingApiCall(
            context,
            Global.shared.userId,
            type_id,
            expectedRateTextController.text,
            rate_id,
            area_type_id,
            areaMeasureTextController.text,
            district_id,
            locationTextController.text,
            descriptionTextController.text,
            _imageFile1,
        _imageFile2,
        _imageFile3,
        _imageFile4)
        .then((model) async {
      try {
        if (model['success']==true) {
        Navigator.pop(context);
        Navigator.pop(context);
        showToast(model.message);
        }else{
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
    final double itemWidth = size.width / 3;
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
                    return const RealEstateScreen();
                  },
                ),
              );
            },
          ),
        ),
        title: const Text(
          "Selling",
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
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                  child: Container(
                    height: size.height * 0.8,
                    width: size.width,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                            width: size.width,
                            child: Card(
                              elevation: 10,
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
                                            text: 'Note ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                              fontSize: 13,
                                              fontFamily: "Roboto",
                                            )),
                                        TextSpan(
                                          text:
                                              'If you are looking for selling properties. Please fill the details.Registration fees applicable Rs 250/- and only 2% from the seller side  must agree to pay the commission once sale is done.',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
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
                                const SizedBox(
                                  height: 20,
                                ),
                                type(),
                                const SizedBox(
                                  height: 20,
                                ),
                                expectedRate(),
                                const SizedBox(
                                  height: 20,
                                ),
                                radioFixed(),
                                const SizedBox(
                                  height: 20,
                                ),
                                area(),
                                const SizedBox(
                                  height: 20,
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: const [
                                //     Padding(
                                //       padding: EdgeInsets.only(
                                //           left: 10.0, bottom: 20.0),
                                //       child: Text(
                                //         "Place",
                                //         style: TextStyle(
                                //           color: themeColor,
                                //           fontSize: 16,
                                //           fontWeight: FontWeight.w400,
                                //           fontFamily: "Roboto",
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                district(),
                                const SizedBox(
                                  height: 20,
                                ),
                                location(),
                                const SizedBox(
                                  height: 20,
                                ),
                                description(),
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    children: const [
                                      SizedBox(
                                        width: 120,
                                        child: Text(
                                          "Upload Images",
                                          style: TextStyle(
                                              color: themeColor,
                                              fontSize: 16,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Upload upto 4 images",
                                        style: TextStyle(
                                            color: themeColor,
                                            fontSize: 12,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w300),
                                      ),


                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: image_row(),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (expectedRateTextController.text.isEmpty) {
                                      showToast(
                                        'Provide expected rate',
                                      );
                                    } else if (areaMeasureTextController.text.isEmpty) {
                                      showToast(
                                        'Provide area',
                                      );
                                    } else if (locationTextController.text.isEmpty) {
                                      showToast(
                                        'provide location',
                                      );
                                    } else if (descriptionTextController.text.isEmpty) {
                                      showToast(
                                        'Provide description',
                                      );
                                    }   else {
                                      print('ok');
                                      loader(context);
                                    sellingApiCall();}
                                  },
                                  child: Container(
                                    height: 45,
                                    width: size.width * 0.9,
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
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
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

  Widget image_row() {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _pickImage1();
              },
              child: Container(
                height: 100,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.0, color: themeColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: selectedOne
                    ? Stack(
                  alignment: Alignment.topRight,
                      children: [
                        Container(
                            height: 100,
                            width: size.width * 0.4,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Image.file(
                              _imageFile1,
                              fit: BoxFit.fill,
                            )),
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
                    : Image.asset("assets/images/cam.png"),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                _pickImage2();
              },
              child: Container(
                height: 100,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.0, color: themeColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: selectedTwo
                    ? Stack(
                  alignment: Alignment.topRight,
                      children: [
                        Container(
                            height: 100,
                            width: size.width * 0.4,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Image.file(
                              _imageFile2,
                              fit: BoxFit.fill,
                            )),
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
                    : Image.asset("assets/images/cam.png"),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _pickImage3();
              },
              child: Container(
                height: 100,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.0, color: themeColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: selectedThree
                    ? Stack(
                  alignment: Alignment.topRight,
                      children: [
                        Container(
                            height: 100,
                            width: size.width * 0.4,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Image.file(
                              _imageFile3,
                              fit: BoxFit.fill,
                            )),
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
                    : Image.asset("assets/images/cam.png"),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                _pickImage4();
              },
              child: Container(
                height: 100,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.0, color: themeColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: selectedFour
                    ? Stack(
                  alignment: Alignment.topRight,
                      children: [

                        Container(
                            height: 100,
                            width: size.width * 0.4,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Image.file(
                              _imageFile4,
                              fit: BoxFit.fill,
                            )),
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
                    : Image.asset("assets/images/cam.png"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget type() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 45,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1.0, color: themeColor),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: FutureBuilder(
        future: getTypeList(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: DropdownButton(
                  hint: const Text("Type"),
                  isExpanded: true,
                  value: dropdownValueType,
                  items: typeList.map((typeAll) {
                    return DropdownMenuItem(
                      value: typeAll.type,
                      onTap: () {
                        type_id = typeAll.id.toString();
                        print("typeID$type_id");
                      },
                      child: Text(typeAll.type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    String type = value.toString();
                    print("Selected type is $type");
                    dropdownValueType = type;

                    setState(() {
                      dropdownValueType = type;
                    });
                  },
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
    );
  }

  Widget radioFixed() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Radio<String>(
              value: 'fixed',
              groupValue: _fixedorneg,
              onChanged: (value) {
                setState(() {
                  _fixedorneg = value;
                  rate_id = "1";
                });
              },
            ),
            const Text("Fixed"),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              value: 'negotiable',
              groupValue: _fixedorneg,
              onChanged: (value) {
                setState(() {
                  _fixedorneg = value;
                  rate_id = "2";
                });
              },
            ),
            const Text("Negotiable"),
          ],
        ),
      ],
    );
  }

  Widget area() {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          height: 45,
          width: size.width * 0.44,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1.0, color: themeColor),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: DropdownButton<String>(
            value: dropdownArea,
            onChanged: (value) {
              setState(() {
                dropdownArea = value;
              });
            },
            hint: Container(
              height: 40,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Area',
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
            items: spinnerItems
                .map((e) => DropdownMenuItem(
                      value: e,
                      onTap: () {
                        if (e == spinnerItems[0]) {
                          area_type_id = "1";
                          print(area_type_id);
                        } else {
                          area_type_id = "2";
                          print(area_type_id);
                        }
                      },
                      child: Text(
                        e,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ))
                .toList(),

            // Customize the selected item
            selectedItemBuilder: (BuildContext context) => spinnerItems
                .map((e) => Container(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          e,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          height: 45,
          width: size.width * 0.44,
          child: TextFormField(
              controller: areaMeasureTextController,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: "Area",
                hintStyle: const TextStyle(
                    fontFamily: "Roboto",
                    color: Colors.black54,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
                fillColor: Colors.white,
                filled: true,
                counterText: "",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: themeColor,
                    style: BorderStyle.solid,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: themeColor,
                    style: BorderStyle.solid,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: themeColor,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
              maxLength: 30),
        ),
      ],
    );
  }

  Widget district() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 45,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1.0, color: themeColor),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: FutureBuilder(
        future: getLocationList(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: DropdownButton(
                  hint: const Text("Location"),
                  isExpanded: true,
                  value: dropdownValueLoc,
                  items: locationList.map((locationAll) {
                    return DropdownMenuItem(
                      value: locationAll.location,
                      onTap: () {
                        district_id = locationAll.id.toString();
                        print("DistrictID$district_id");
                      },
                      child: Text(locationAll.location),
                    );
                  }).toList(),
                  onChanged: (value) {
                    String location = value.toString();
                    print("Selected location is $location");
                    dropdownValueLoc = location;
                    setState(() {
                      dropdownValueLoc = location;
                    });
                  },
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
    );
  }

  Widget location() {
    return SizedBox(
      height: 45,
      child: TextFormField(
          controller: locationTextController,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: "Location",
            hintStyle: const TextStyle(
                fontFamily: "Roboto",
                color: Colors.black54,
                fontSize: 14.0,
                fontWeight: FontWeight.w400),
            fillColor: Colors.white,
            filled: true,
            counterText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                width: 1.0,
                color: themeColor,
                style: BorderStyle.solid,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                width: 1.0,
                color: themeColor,
                style: BorderStyle.solid,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                width: 1.0,
                color: themeColor,
                style: BorderStyle.solid,
              ),
            ),
          ),
          keyboardType: TextInputType.text,
          maxLength: 30),
    );
  }

  Widget description() {
    return SizedBox(
      height: 100,
      child: TextFormField(
        controller: descriptionTextController,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: "Description",
          hintStyle: const TextStyle(
              fontFamily: "Roboto",
              color: Colors.black54,
              fontSize: 14.0,
              fontWeight: FontWeight.w400),
          fillColor: Colors.white,
          filled: true,
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 1.0,
              color: themeColor,
              style: BorderStyle.solid,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 1.0,
              color: themeColor,
              style: BorderStyle.solid,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 1.0,
              color: themeColor,
              style: BorderStyle.solid,
            ),
          ),
        ),
        keyboardType: TextInputType.text,
        maxLength: 200,
        maxLines: 5,
      ),
    );
  }

  Widget expectedRate() {
    return SizedBox(
      height: 45,
      child: TextFormField(
          controller: expectedRateTextController,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: "Expected rate",
            hintStyle: const TextStyle(
                fontFamily: "Roboto",
                color: Colors.black54,
                fontSize: 14.0,
                fontWeight: FontWeight.w400),
            fillColor: Colors.white,
            filled: true,
            counterText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                width: 1.0,
                color: themeColor,
                style: BorderStyle.solid,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                width: 1.0,
                color: themeColor,
                style: BorderStyle.solid,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                width: 1.0,
                color: themeColor,
                style: BorderStyle.solid,
              ),
            ),
          ),
          keyboardType: TextInputType.number,
          maxLength: 30),
    );
  }
}
