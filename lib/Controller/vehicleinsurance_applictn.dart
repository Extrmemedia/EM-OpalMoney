import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:opal_money/Controller/enquirysuccess_screen.dart';
import 'package:toast/toast.dart';
import 'package:file_picker/file_picker.dart';
import '../ApiService/vehicleInsuranceApiService.dart';
import '../Common/constants.dart';
import '../Common/dates.dart';
import '../Model/ModelVehicleInsurance.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import '../Utils/loader.dart';
import '../Utils/toast.dart';
import 'home_page_screen.dart';

class VehicleInsuranceApplication extends StatefulWidget {
  const VehicleInsuranceApplication({Key key}) : super(key: key);

  @override
  State<VehicleInsuranceApplication> createState() =>
      _VehicleInsuranceApplicationState();
}

class _VehicleInsuranceApplicationState
    extends State<VehicleInsuranceApplication> {
  var nameTextController = TextEditingController();
  var mobileTextController = TextEditingController();
  var firstregTextController = TextEditingController();
  var vehiclepurchasedateTextController = TextEditingController();

  var rtozoneTextController = TextEditingController();
  var cityofpurchaseTextController = TextEditingController();
  var chasisnoTextController = TextEditingController();
  var enginnoTextController = TextEditingController();
  var cityTextController = TextEditingController();
  var branchTextController = TextEditingController();

  ModelVehicleInsurance modelVehicleinsurance;
  String _selectedposedspecalcondition = 'Yes';
  String _additionalcoverdetls = 'Yes';
  String _selectednonconensionalfuel = 'Yes';
  String _selectedgeographicalarea = 'Yes';
  String _selectedhigherdeductable = 'Yes';
  String _selectedassocmember = 'Yes';
  String _selectedantitheft = 'Yes';
  String _selectedcoverleagaliabl = 'Yes';
  String selectedcoverleagaliablother = 'Yes';
  String _selectedpacover = 'Yes';
  String _selectedcnglpgkit = 'Yes';

  String posedspecalcondition = '0';
  String additionalcoverdetls = '0';
  String nonconensionalfuel = '0';
  String geographicalarea = '0';
  String higherdeductable = '0';
  String assocmembe = '0';
  String antitheft = '0';
  String coverleagaliabl = '0';
  String coverleagaliablother = '0';
  String pacover = '0';
  String cnglpgkit = '0';
  String fromDate = '';
  String toDate = '';
  String image;
  bool selectedOne = false;
  bool selectedTwo = false;
  bool selectedThree = false;
  bool selectedFour = false;
  bool selectedFive = false;
  File _imageFile1;
  File _imageFile2;
  File _imageFile3;
  File _imageFile4;
  File _imageFile5;
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
        print(image);
        if (pickedFile4 != null) {
          _imageFile5 = File(pickedFile4.files.single.path);
          selectedFive = true;
        } else {
          print('No image selected');
        }
      });

    } catch (e) {
      print("Image picker error ");
    }
  }
  vehicleInsuranceApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();

        applicationform();
      } else {
        showToast(
          "Please check your internet connection",
        );

        return;
      }
    });
  }

  void applicationform() {
    print("ID${Global.shared.id}");
    print("name${nameTextController.text}");
    print("mobile${mobileTextController.text}");
    print("firstregdate${firstregTextController.text}");
    print("vehiclepurchasedt${vehiclepurchasedateTextController.text}");
    print("rtozone${rtozoneTextController.text}");
    print("citypofprchase${cityofpurchaseTextController.text}");
    print("city${cityTextController.text}");
    print("branch${branchTextController.text}");

    VehicleInsuranceApiService.vehicleInsuranceApiCall(
      context: context,
      uid: Global.shared.id,
      name: nameTextController.text,
      mobile: mobileTextController.text,
      dopurchase: fromDate,
      doreg: toDate,
      rtoozone: rtozoneTextController.text,
      purchase_city: cityofpurchaseTextController.text,
      chasisno: chasisnoTextController.text,
      engno: enginnoTextController.text.toString(),
      city: cityTextController.text.toString(),
      branch: branchTextController.text,
      pa_cover: pacover,
      additionalcover: additionalcoverdetls,
      nonconention_fuel: nonconensionalfuel,
      higher_deductable: higherdeductable,
      assoc_member: assocmembe,
      anti_theft: antitheft,
      cover_legal_liab: coverleagaliabl,
      cng_lpg: cnglpgkit,
      imposed_specialcond: posedspecalcondition,
      legal_liab_other: coverleagaliablother,
      extension_required: geographicalarea,
      pan:_imageFile1,
      adhar:_imageFile2,
      photo:_imageFile3,
      rcbook: _imageFile4,
      insurance:_imageFile5).then((modelVehicleinsurance) async {
      try {
        if (modelVehicleinsurance['success'] == true) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return EnquirySucessScreen(
                  screenType: 'r',
                );
              },
            ),
          );
          //EnquirySucessScreen
        } else {
          Navigator.pop(context);
          showToast(modelVehicleinsurance['message']);
        }
      } catch (e) {
        print(e);
        Navigator.pop(context);

        showToast(e.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var dropdownItems;

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
          "Vehicle Insurance",
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
              padding: const EdgeInsets.only(top: 10.0, left: 5, right: 5),
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
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 20.0, bottom: 20.0),
                      child: SingleChildScrollView(
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
                                fontSize: 18.0,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                  controller: nameTextController,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300),
                                  decoration: InputDecoration(
                                    hintText: "Name",
                                    hintStyle: const TextStyle(
                                        fontFamily: "Roboto",
                                        color: Colors.black54,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w300),
                                    fillColor: Colors.white70,
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
                                      fontWeight: FontWeight.w300),
                                  decoration: InputDecoration(
                                    hintText: "Mobile No",
                                    hintStyle: const TextStyle(
                                        fontFamily: "Roboto",
                                        color: Colors.black54,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w300),
                                    fillColor: Colors.white70,
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
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                controller: firstregTextController,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  hintText:
                                      "Date of first registration of vehicle",
                                  hintStyle: const TextStyle(
                                      fontFamily: "Roboto",
                                      color: Colors.black54,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w300),
                                  fillColor: Colors.white70,
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
                                    String a = DateFormat('yyyy-MM-dd')
                                        .format(pickedDate);
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      fromDate = a;
                                      firstregTextController.text =
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
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "DD/MM/YYYY",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.black54,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                controller: vehiclepurchasedateTextController,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  hintText: "Date of purchase of vehicle",
                                  hintStyle: const TextStyle(
                                      fontFamily: "Roboto",
                                      color: Colors.black54,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w300),
                                  fillColor: Colors.white70,
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
                                    String t = DateFormat('yyyy-MM-dd')
                                        .format(pickedDate);
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      toDate = t;
                                      vehiclepurchasedateTextController.text =
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
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "DD/MM/YYYY",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.black54,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              child: Text(
                                'Tips:You must purchase your insurance policy the'
                                ' same day you buy your brand new vehicle',
                                style: TextStyle(
                                    color: themeColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                controller: rtozoneTextController,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  hintText: "RTO Zone",
                                  hintStyle: const TextStyle(
                                      fontFamily: "Roboto",
                                      color: Colors.black54,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w300),
                                  fillColor: Colors.white70,
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
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                controller: cityofpurchaseTextController,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  hintText: "City of purchase",
                                  hintStyle: const TextStyle(
                                      fontFamily: "Roboto",
                                      color: Colors.black54,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w300),
                                  fillColor: Colors.white70,
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
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              child: Text(
                                'Has any Insurance company ever declined/cancelled'
                                'the proposal and refused two renew the policy or'
                                ' imposed special conditions?',
                                style: TextStyle(
                                    color: themeColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Yes',
                                      groupValue: _selectedposedspecalcondition,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedposedspecalcondition = value;
                                        });
                                      },
                                    ),
                                    const Text("Yes"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'No',
                                      groupValue: _selectedposedspecalcondition,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedposedspecalcondition = value;
                                        });
                                      },
                                    ),
                                    const Text("No"),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                controller: chasisnoTextController,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  hintText: "Chassis Number",
                                  hintStyle: const TextStyle(
                                      fontFamily: "Roboto",
                                      color: Colors.black54,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w300),
                                  fillColor: Colors.white70,
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
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                controller: enginnoTextController,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  hintText: "Engine Number",
                                  hintStyle: const TextStyle(
                                      fontFamily: "Roboto",
                                      color: Colors.black54,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w300),
                                  fillColor: Colors.white70,
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
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                controller: cityTextController,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300),
                                decoration: InputDecoration(
                                  hintText: "City/Town",
                                  hintStyle: const TextStyle(
                                      fontFamily: "Roboto",
                                      color: Colors.black54,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w300),
                                  fillColor: Colors.white70,
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
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                controller: branchTextController,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300),
                                decoration: InputDecoration(
                                  hintText: "Branch/Office",
                                  hintStyle: const TextStyle(
                                      fontFamily: "Roboto",
                                      color: Colors.black54,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w300),
                                  fillColor: Colors.white70,
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
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                child: Text(
                                  'Additional cover details ',
                                  style: TextStyle(
                                    color: themeColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Yes',
                                      groupValue: _additionalcoverdetls,
                                      onChanged: (value) {
                                        setState(() {
                                          _additionalcoverdetls = value;
                                        });
                                      },
                                    ),
                                    const Text("Yes"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'No',
                                      groupValue: _additionalcoverdetls,
                                      onChanged: (value) {
                                        setState(() {
                                          _additionalcoverdetls = value;
                                        });
                                      },
                                    ),
                                    const Text("No"),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                child: Text(
                                  'Is vehicle using non-convensional sourse of fuel?',
                                  style: TextStyle(
                                    color: themeColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Yes',
                                      groupValue: _selectednonconensionalfuel,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectednonconensionalfuel = value;
                                        });
                                      },
                                    ),
                                    const Text("Yes"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'No',
                                      groupValue: _selectednonconensionalfuel,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectednonconensionalfuel = value;
                                        });
                                      },
                                    ),
                                    const Text("No"),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const SizedBox(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Extension of geographical area required?',
                                  style: TextStyle(
                                    color: themeColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Yes',
                                      groupValue: _selectedgeographicalarea,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedgeographicalarea = value;
                                        });
                                      },
                                    ),
                                    const Text("Yes"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'No',
                                      groupValue: _selectedgeographicalarea,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedgeographicalarea = value;
                                        });
                                      },
                                    ),
                                    const Text("No"),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              child: Text(
                                'Do you wish to OPT for higher deductible over and above the compulsory?',
                                style: TextStyle(
                                  color: themeColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Yes',
                                      groupValue: _selectedhigherdeductable,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedhigherdeductable = value;
                                        });
                                      },
                                    ),
                                    const Text("Yes"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'No',
                                      groupValue: _selectedhigherdeductable,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedhigherdeductable = value;
                                        });
                                      },
                                    ),
                                    const Text("No"),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const SizedBox(
                              child: Text(
                                'Are you a member of automobile association of India?',
                                style: TextStyle(
                                  color: themeColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Yes',
                                      groupValue: _selectedassocmember,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedassocmember = value;
                                        });
                                      },
                                    ),
                                    const Text("Yes"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'No',
                                      groupValue: _selectedassocmember,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedassocmember = value;
                                        });
                                      },
                                    ),
                                    const Text("No"),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Is the vehicle fitted with anti theft device?',
                                  style: TextStyle(
                                    color: themeColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Yes',
                                      groupValue: _selectedantitheft,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedantitheft = value;
                                        });
                                      },
                                    ),
                                    const Text("Yes"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'No',
                                      groupValue: _selectedantitheft,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedantitheft = value;
                                        });
                                      },
                                    ),
                                    const Text("No"),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Do you wish to cover legal liability to drive?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Yes',
                                      groupValue: _selectedcoverleagaliabl,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedcoverleagaliabl = value;
                                        });
                                      },
                                    ),
                                    const Text("Yes"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'No',
                                      groupValue: _selectedcoverleagaliabl,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedcoverleagaliabl = value;
                                        });
                                      },
                                    ),
                                    const Text("No"),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              child: Text(
                                'Do you wish to cover legal liability to other employee?',
                                style: TextStyle(
                                  color: themeColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Yes',
                                      groupValue: selectedcoverleagaliablother,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedcoverleagaliablother = value;
                                        });
                                      },
                                    ),
                                    const Text("Yes"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'No',
                                      groupValue: selectedcoverleagaliablother,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedcoverleagaliablother = value;
                                        });
                                      },
                                    ),
                                    const Text("No"),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              child: Text(
                                'Do you wish to have PA cover for unnamed persons?',
                                style: TextStyle(
                                  color: themeColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Yes',
                                      groupValue: _selectedpacover,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedpacover = value;
                                        });
                                      },
                                    ),
                                    const Text("Yes"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'No',
                                      groupValue: _selectedpacover,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedpacover = value;
                                        });
                                      },
                                    ),
                                    const Text("No"),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Do you have a CNG/LPG kit?',
                                  style: TextStyle(
                                    color: themeColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Yes',
                                      groupValue: _selectedcnglpgkit,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedcnglpgkit = value;
                                        });
                                      },
                                    ),
                                    const Text("Yes"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'No',
                                      groupValue: _selectedcnglpgkit,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedcnglpgkit = value;
                                        });
                                      },
                                    ),
                                    const Text("No"),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: Column(children: [
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
                                        "RC Book",
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
                                ),  const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 56,
                                      child: Text(
                                        "Insurance",
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
                                        SizedBox(
                                          width: 4.0,
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
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ]),
                            ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              height: 0,
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
                                } else if (firstregTextController
                                    .text.isEmpty) {
                                  showToast(
                                    'Provide date of first registration',
                                  );
                                } else if (vehiclepurchasedateTextController
                                    .text.isEmpty) {
                                  showToast(
                                    'Provide date purchase',
                                  );
                                } else if (rtozoneTextController.text.isEmpty) {
                                  showToast(
                                    'Provide rto zone',
                                  );
                                } else if (cityofpurchaseTextController
                                    .text.isEmpty) {
                                  showToast(
                                    'Provide city of purchase',
                                  );
                                } else if (chasisnoTextController
                                    .text.isEmpty) {
                                  showToast(
                                    'Provide chassis number',
                                  );
                                } else if (enginnoTextController.text.isEmpty) {
                                  showToast(
                                    'Provide engine number',
                                  );
                                } else if (cityTextController.text.isEmpty) {
                                  showToast(
                                    'Provide city/town',
                                  );
                                } else if (branchTextController.text.isEmpty) {
                                  showToast(
                                    'Provide branch/office',
                                  );
                                } else {
                                  print('ok');
                                  loader(context);
                                  vehicleInsuranceApiCall();
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
