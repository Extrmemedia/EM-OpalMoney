import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/Controller/real_estate_screen.dart';
import 'package:toast/toast.dart';

import '../ApiService/buyEnquiryApiService.dart';
import '../ApiService/locationApiService.dart';
import '../ApiService/typeApiService.dart';
import '../Common/constants.dart';
import '../Model/ModelBuyingEnquiry.dart';
import '../Model/ModelLocation.dart';
import '../Model/ModelType.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import '../Utils/toast.dart';

class BuyingScreen extends StatefulWidget {
  const BuyingScreen({Key key}) : super(key: key);

  @override
  State<BuyingScreen> createState() => _BuyingScreenState();
}

class _BuyingScreenState extends State<BuyingScreen> {

  var locationTextController=TextEditingController();
  var descriptionTextController=TextEditingController();

  String dropdownValue = 'Type';
  String dropdownValueDist = 'Thiruvananthapuram';
  bool value = false;
  int index = -1;
  bool selectAll=false;
  List<Ranges> ranges=List.empty(growable: true);
  ModelLocation modelLocation;
  ModelBuyingEnquiry modelBuyingEnquiry;
  ModelType modelType;
  List<Type> typeList=[];
  List<LocationList> locationList=[];
  get selectedIndexes => [];
  String dropdownValueLoc = "Trivandrum";
  String dropdownValueType = "Land and Plots";
  String type_id = "1";
  String district_id = "1";
  String  selected;


  @override
  void initState() {
    super.initState();
    locationListApiCall();
    typeApiFunc();

    ranges.add(Ranges("0-20K",false));
    ranges.add(Ranges("20-40K",false));
    ranges.add(Ranges("40-60K",false));
    ranges.add(Ranges("60-80K",false));
    ranges.add(Ranges("80-99K",false));
    ranges.add(Ranges("10-20L",false));
    ranges.add(Ranges("20-40L",false));
    ranges.add(Ranges("40-60L",false));
    ranges.add(Ranges("60-80L",false));
    ranges.add(Ranges("80-99L",false));
    ranges.add(Ranges("1-5C",false));
  }



  locationListApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        locApiFunc();
      } else {
        showToast("Please check your internet connection",
           );

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
        showToast((result.message),
         );}
      } catch (e) {
        //await progressDialog.hide();
      }
    });
  }

  Future<ModelLocation> getLocationList() async {
    locationList = modelLocation.data;
    return modelLocation;
  }
  typeApiFunc() {
    TypeApiService.typeApiCall(context).then((result) async {
      try {
        // showToast(result.message.toString(),
        //     gravity: Toast.BOTTOM, duration: 2);

        // progressDialog.hide();
        if (result.success) {
          setState(() {
            modelType = result;
            typeList = modelType.data;
          });

          //showToast((result.message), gravity: Toast.BOTTOM, duration: 2);
        }else{
        // await progressDialog.hide();
          showToast((result.message));}
      } catch (e) {
        //await progressDialog.hide();
      }
    });
  }

  Future<ModelType> getTypeList() async {
    typeList = modelType.data;
    return modelType;
  }
  buyingApiFunc() {
    print("ID${Global.shared.userId}");
    print("typeID$type_id");
print("exptedrate$selected");
    print("DIsID$district_id");
    print("loc${locationTextController.text}");
    print("desc${descriptionTextController.text}");


    BuyingEnguiryApiService.buyingApiCall(
        context,Global.shared.userId,type_id,selected,
       district_id,
        locationTextController.text,descriptionTextController.text,)
        .then((model) async {
      try {
        // modelBuyingEnquiry = model;
        if (model['status']=='success') {
          showToast((model['message']));
       Navigator.pop(context);
         }else{

          showToast((model['message']));
        }
      } catch (e) {
        print(e);
        throw Exception('Failed');
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
            icon: const Icon(Icons.arrow_back,size: 26,color: Colors.white70,),
            onPressed: () {
              Navigator.pushReplacement(context,  MaterialPageRoute(
                builder: (context) {
                  return const RealEstateScreen();
                },
              ),
              );
            },
          ),
        ),
        title:const Text("Buying",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              fontFamily: "Poppins"

          ),
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
              padding: const EdgeInsets.only(top: 10.0,bottom:20,left: 2,right: 2 ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(bottomLeft:Radius.circular(20.0),bottomRight: Radius.circular(20.0)
                  ),
                  child: Container(
                    height: size.height*0.8,
                    width: size.width,
                    color: Colors.white,

                    child: SingleChildScrollView(
                      child: Column(

                        children: [
                          SizedBox(
                            height: 100,
                            width: size.width,
                            child:  Card(
                              elevation: 20,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    text:const TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent

                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(text: 'Note ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87,
                                          fontSize: 13,
                                          fontFamily: "Roboto",)),
                                        TextSpan(text: 'If you are looking for buying properties. Please fill the details.Registration fees applicable Rs 250/- and only 1% from the buyer side  must agree to pay the commission once sale is done.',
                                          style: TextStyle( color: Colors.black87,
                                            fontSize: 13,
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
                            padding: const EdgeInsets.only(left: 10.0,right: 10,top: 20,bottom: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:  [


                                const SizedBox(height: 20,),



                                Container(
                                  height: 45,
                                  width: size.width,

                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 1.0, color: themeColor),
                                    borderRadius: const BorderRadius.all(Radius.circular(10)
                                    ),
                                  ),

                                  child: DropdownButtonHideUnderline(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: DropdownButton(
                                        hint: const Text("Type"),
                                        isExpanded: true,
                                        value: dropdownValueType,
                                        items: typeList
                                            .map((typeAll) {
                                          return DropdownMenuItem(
                                            value: typeAll.type,
                                            onTap: (){
                                              type_id =typeAll.id.toString();
                                              print("typeID$type_id");
                                            },
                                            child: Text(
                                                typeAll.type),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          String type= value.toString();
                                          print("Selected type is $type");
                                          dropdownValueType = type;

                                          setState((){
                                            dropdownValueType = type;

                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0,bottom: 20.0),
                                      child: Text("Expected Rate",
                                        style: TextStyle(
                                          color: themeColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),


                              // GridView.count(
                              //   crossAxisCount: 3,
                              //   childAspectRatio: (itemWidth / 40.0),
                              //   crossAxisSpacing: 2.0,
                              //   mainAxisSpacing: 2.0,
                              //   shrinkWrap: true,
                              //   children: List.generate(10, (index) {
                              //     return CheckboxListTile(
                              //       title: const Text("0-20k",style: TextStyle(
                              //         fontSize: 12.0
                              //       ),),
                              //       value: selectedIndexes.contains(index),
                              //       onChanged: (_) {
                              //         if (selectedIndexes.contains(index)) {
                              //           selectedIndexes.remove(index);   // unselect
                              //         } else {
                              //           selectedIndexes.add(index);  // select
                              //         }
                              //       },
                              //       controlAffinity: ListTileControlAffinity.leading,
                              //     );
                              //   })
                              // ),



                                Container(
                                  height: 200,
                                  child: GridView.builder(
                                     shrinkWrap: true,
                                    itemBuilder: (ctx,index){
                                      return Container(
                                        height: 30,
                                        child: prepareList(index),
                                      );

                                    },
                                  //  print("Selected type is $index");
                                    gridDelegate:SliverGridDelegateWithFixedCrossAxisCount
                                      (
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: (itemWidth / 40.0),
                                    ),
                                    itemCount: ranges.length,
                                  ),
                                ),

                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: const [
                                //     Padding(
                                //       padding: EdgeInsets.only(left: 10.0,bottom: 20.0),
                                //       child: Text("Place",
                                //         style: TextStyle(
                                //         color: themeColor,
                                //           fontSize: 16,
                                //           fontWeight: FontWeight.w400,
                                //           fontFamily: "Roboto",
                                //       ),
                                //       ),
                                //     ),
                                //   ],
                                // ),

                                Container(
                                  height: 45,
                                  width: size.width,

                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 1.0, color: themeColor),
                                    borderRadius: const BorderRadius.all(Radius.circular(10)
                                    ),
                                  ),

                                  child: DropdownButtonHideUnderline(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: DropdownButton(
                                        hint: const Text("Location"),
                                        isExpanded: true,
                                        value: dropdownValueLoc,
                                        items: locationList
                                            .map((locationAll) {
                                          return DropdownMenuItem(
                                            value: locationAll.location,
                                            onTap: (){
                                              district_id = locationAll.id.toString();
                                              print("DistrictID$district_id");
                                            },
                                            child: Text(
                                                locationAll.location),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          String location= value.toString();
                                          print("Selected location is $location");
                                          dropdownValueLoc = location;
                                          setState((){
                                            dropdownValueLoc = location;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20,),

                                SizedBox(
                                  height: 45,
                                  child: TextFormField(
                                      controller:locationTextController,

                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                      ),
                                      decoration:  InputDecoration(
                                        hintText: "Location",
                                        hintStyle: const TextStyle(
                                            fontFamily: "Roboto",
                                            color: Colors.black54,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400),
                                        fillColor:Colors.white,
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
                                      maxLength: 30
                                  ),
                                ),

                                const SizedBox(height: 20,),

                                SizedBox(
                                  height: 100,
                                  child: TextFormField(
                                  controller: descriptionTextController,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      decoration:  InputDecoration(
                                        hintText: "Description",
                                        hintStyle: const TextStyle(
                                            fontFamily: "Roboto",
                                            color: Colors.black54,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400),
                                        fillColor:Colors.white,
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
                                ),


                                const SizedBox(height: 30,),

                                TextButton(
                                  onPressed: (){
                                    buyingApiFunc();
                                  },
                                  child: Container(
                                    height: 45,
                                    width: size.width*0.9,
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
                                const SizedBox(height: 30,),

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



  // getRow(int i) {
  //   List <int> indexes = [] ;
  //
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: <Widget>[
  //
  //
  //       // Checkbox(
  //       //   value: index==i? value = true:value =false,
  //       //   onChanged: (value) {
  //       //     setState(() {
  //       //       index = i;
  //       //       indexes.add(index);
  //       //     }
  //       //     );
  //       //   },
  //       // ),
  //       // const SizedBox(
  //       //   width: 5,
  //       // ), //SizedBox
  //       // const Text(
  //       //   '0-20k',
  //       //   style: TextStyle(fontSize: 14.0),
  //       // ), //Text
  //       // const SizedBox(width: 10), //SizedBox
  //       //
  //     ], //<Widget>[]
  //   );
  // }

   prepareList(int k) {
    return Row(
      children: [
        Checkbox(
          value: ranges[k].selected, onChanged: (bool value) {
          setState(() {
            if(!value) {
              selectAll=false;
            }
            ranges[k].selected=value;
            selected=ranges[k].range;
          });
        },),
        Text(ranges[k].range,
          style: const TextStyle(color: themeColor,fontSize: 12),),

      ],
    );
  }
}

class Ranges{
  String range;
  bool selected;
  Ranges(this.range,this.selected);
}

