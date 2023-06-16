import 'package:flutter/material.dart';
import 'package:opal_money/ApiService/landAndPlotApiService.dart';
import 'package:opal_money/ApiService/sellingItemListApiService.dart';
import 'package:opal_money/Controller/houses_apartments_details_screen.dart';
import 'package:opal_money/Model/ModelLandAndPlots.dart';
import 'package:opal_money/Model/ModelSellingItemList.dart';
import 'package:opal_money/Utils/AppConstants.dart';
import 'package:opal_money/Utils/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import '../Utils/toast.dart';
import 'home_page_screen.dart';

class HousesApartmentsTabListScreen extends StatefulWidget {
  final String property_id;


  const HousesApartmentsTabListScreen({key,this.property_id}) : super(key: key);

  @override
  State<HousesApartmentsTabListScreen> createState() => _HousesApartmentsTabListScreenState();
}

class _HousesApartmentsTabListScreenState extends State<HousesApartmentsTabListScreen> {
String propertyType;
ModelLandAndPlots modelLandAndPlots;
bool load=false;
  @override
  void initState() {
    super.initState();
    setState((){

      load=true;        });
    propertyType = widget.property_id;
    print(propertyType);
    landAndPlotListApiCall(propertyType);
  }




  landAndPlotListApiCall(String type) {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {

        //await progressDialog.show();
        apiLandAndPlotFunc(type);
      } else {
        setState((){

          load=false;        });
        showToast("Please check your internet connection",
            );

        return;
      }
    });
  }

  apiLandAndPlotFunc(String type) {
    print(propertyType);
    LandAndPlotApiService.landAndPlotListApiCall(
        context,type)
        .then((result) async {
      try {

        // showToast(result.message.toString(),
        //     gravity: Toast.BOTTOM, duration: 2);


        // progressDialog.hide();
        if (result.success) {

          setState((){
            modelLandAndPlots = result;
            load=false;
          });

         // showToast((result.message), gravity: Toast.BOTTOM, duration: 2);
        }else{
          setState((){
            load=false;
          });
        // await progressDialog.hide();
        showToast((result.message),
        );}
      } catch (e) {
        setState((){
          load=false;
        });
        //await progressDialog.hide();
      }
    });
  }

  Future<ModelLandAndPlots> getLandAndPlotList() async {
    return  modelLandAndPlots;
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
            icon: const Icon(Icons.arrow_back,size: 26,color: Colors.white70,),
            onPressed: () {
            Navigator.pop(context);
            },
          ),
        ),
        title:const Text("Houses and Apartments",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
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
        color: Colors.white,
        width: size.width,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              height: 100,
              width: size.width,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      propertyType ="2";
                      landAndPlotListApiCall(propertyType);
                    },
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        Image.asset("assets/images/house_apartments.png",fit:BoxFit.fill,height: 50,width: 50,),
                        const SizedBox(height: 10,),
                        const Text("Houses & Apartments",style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            fontSize: 14.0
                        ),)
                      ],
                    ),
                  ),


                  const SizedBox(width: 50,),


                  GestureDetector(
                    onTap: (){
                      propertyType ="1";
                      landAndPlotListApiCall(propertyType);
                    },
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        Image.asset("assets/images/lands_plots.png",fit:BoxFit.fill,height: 50,width: 50,),
                        const SizedBox(height: 10,),
                        const Text("Lands & Plots",style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            fontSize: 14.0
                        ),)
                      ],
                    ),
                  ),
                ],
              ),
            ),

            load==true?Container(
              alignment: Alignment.center,
              height: 25.0,width: 25.0,
              child: const CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor : AlwaysStoppedAnimation(themeColor),
              ),
            ) :   Expanded(

              child: SizedBox(
                height: size.height,
                child:  ListView.builder(

                          itemCount: modelLandAndPlots.data.isEmpty? 0:modelLandAndPlots.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 10.0,right: 10,top: 10,bottom: 10),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return HousesApartmentsDetailsScreen(id: modelLandAndPlots.data[index].id.toString(),listData: modelLandAndPlots.data,);
                                  })).then((value) {
                                    setState((){

                                      load=true;        });

                                    landAndPlotListApiCall(propertyType);});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black26,width: 1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0,right: 8.0,),
                                            child: Container(
                                              height: 100,
                                              width: 140,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFF8F8F8),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),topRight: Radius.circular(0),bottomRight: Radius.circular(0)),
                                              ),

                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  child:Image.network(modelLandAndPlots.data[index].image1)
                                              ),
                                            ),
                                          ),
                                          Container(height: 120,width: 1,color: Colors.black26,)
                                        ],
                                      ),


                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0,top: 10,bottom: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                             Text(
                                              "\u{20AC}"+modelLandAndPlots.data[index].expectedRate.toString() ,
                                              style: const TextStyle(
                                                  color: Colors.indigoAccent,
                                                  fontFamily: "Roboto",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500

                                              ),
                                            ),

                                            const SizedBox(height: 5,),
                                            Text(
                                              propertyType =="1"?"${modelLandAndPlots.data[index].areaMessure} cent":
                                              "${modelLandAndPlots.data[index].areaMessure} sqft",
                                              style: const TextStyle(
                                                  fontFamily: "Roboto",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600

                                              ),
                                            ),

                                            const SizedBox(height: 50,),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Image.asset("assets/images/location.png",height: 10,width: 10,fit: BoxFit.fill,),
                                                Text(modelLandAndPlots.data[index].location,
                                                  style: const TextStyle(
                                                      fontFamily: "Roboto",
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w300

                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      const Spacer(),

                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                                        child: SizedBox(
                                          height: 100,
                                          width: 50,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: const [
                                             // Image.asset("assets/images/heart.png",height: 15,width: 15,fit: BoxFit.fill,),
                                              Spacer(),
                                               Text('',
                                              // Days Ago",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(color:Colors.black,
                                                    fontSize: 10,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.w300),),
                                            ],
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 15,),

                                    ],
                                  ),

                                ),
                              ),
                            );
                          }),



              ),
            ),

          ],
        ),
      ),
    );
  }
}
