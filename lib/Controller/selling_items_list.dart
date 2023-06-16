import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/ApiService/deleteRealEstateApiService.dart';
import 'package:opal_money/Controller/real_estate_screen.dart';
import 'package:opal_money/Model/ModelDeleteRealEstate.dart';
import 'package:toast/toast.dart';

import '../ApiService/sellingItemListApiService.dart';
import '../Common/constants.dart';
import '../Model/ModelSellingItemList.dart';
import '../Utils/Connectivity.dart';
import '../Utils/Global.dart';
import '../Utils/toast.dart';
import 'houses_apartments_details_screen.dart';

class SellingItemsList extends StatefulWidget {
  const SellingItemsList({Key key}) : super(key: key);

  @override
  State<SellingItemsList> createState() => _SellingItemsListState();
}

class _SellingItemsListState extends State<SellingItemsList> {

  ModelSellingItemList modelSellingItemList;
  ModelDeleteRealEstate modelDeleteRealEstate;
  String id;


  @override
  void initState() {
    super.initState();
    sellingListApiCall();
  }



  sellingListApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        apiSellingFunc();
      } else {
        showToast("Please check your internet connection",);

        return;
      }
    });
  }

  apiSellingFunc() {

    String user_id = Global.shared.userId;
    print("user_id $user_id");

    SellingItemListApiService.sellingItemListApiCall(
        context,user_id)
        .then((result) async {
      try {

        showToast(result.message.toString(),);


        // progressDialog.hide();
        if (result.success) {

          setState((){
            modelSellingItemList = result;
          });

          showToast((result.message),);
        }
        // await progressDialog.hide();
        showToast((result.message),);
      } catch (e) {
        //await progressDialog.hide();
      }
    });
  }


  deleteApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        apiDeleteApiFunc();
      } else {
        showToast("Please check your internet connection",);

        return;
      }
    });
  }

  apiDeleteApiFunc() {


    print(id);

    DeleteRealEstateApiService.deleteRealEstateApiCall(
        context,id)
        .then((result) async {
      try {

        showToast(result.message.toString(),);


        // progressDialog.hide();
        if (result.status) {

          setState((){
            modelDeleteRealEstate = result;
          });

          showToast((result.message));
        }
        // await progressDialog.hide();
        showToast((result.message));
      } catch (e) {
        //await progressDialog.hide();
      }
    });
  }

  Future<ModelSellingItemList> getSellingItemList() async {
    return  modelSellingItemList;
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
            icon: const Icon(Icons.arrow_back,size: 26,color: Colors.white70
              ,),
            onPressed: () {
              Navigator.push(context,  MaterialPageRoute(
                builder: (context) {
                  return const RealEstateScreen();
                },
              ),
              );
            },
          ),
        ),
        title:const Text("Selling item List",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
              fontFamily: "Poppins"

          ),
        ),

        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(left: 10,right: 10),
        //     child: CircleAvatar(
        //       radius:13.0,
        //       backgroundColor: themeColor,
        //       backgroundImage: AssetImage(
        //         "assets/images/profile_img.png",
        //       ),
        //     ),
        //   ),
        //
        // ],
      ),

      body: Container(
        color: Colors.white,
        width: size.width,
        child: Column(
          children: [


            Expanded(

              child: SizedBox(
                height: size.height,
                child: FutureBuilder(
                  future: getSellingItemList(),
                  builder: (BuildContext context,  snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(

                          itemCount: modelSellingItemList.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 10.0,right: 10,top: 10,bottom: 10),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                    return HousesApartmentsDetailsScreen();
                                  }));
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
                                                  child:Image.network(modelSellingItemList.data[index].image1)
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
                                              "\u{20AC}${modelSellingItemList.data[index].expectedRate}" ,
                                              style: const TextStyle(
                                                  color: Colors.indigoAccent,
                                                  fontFamily: "Roboto",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500

                                              ),
                                            ),

                                            const SizedBox(height: 5,),
                                             Text(modelSellingItemList.data[index].areaMessure.toString(),
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
                                                 Text(modelSellingItemList.data[index].location,
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
                                          width: 61,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset("assets/images/edit_icon.png",height: 15,width: 15,fit: BoxFit.fill,),
                                                  const SizedBox(width: 20,),
                                                  GestureDetector(
                                                    onTap: (){
                                                      setState((){
                                                        id = modelSellingItemList.data[index].id.toString();
                                                      });

                                                      deleteApiCall();
                                                    },
                                                      child: Image.asset("assets/images/delete_icon.png",height: 22,width: 22,fit: BoxFit.fill,)),
                                                ],
                                              ),
                                              const Spacer(),
                                              const Text("5 Days Ago",
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
                          });
                    }
                    else {
                      return(const Center(child: CircularProgressIndicator(),));
                    }
                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
