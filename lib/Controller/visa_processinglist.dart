import 'package:flutter/material.dart';
import 'package:opal_money/Controller/visaprocessinglistdetails.dart';
import 'package:toast/toast.dart';

import '../ApiService/commonListApiService.dart';
import '../Common/constants.dart';
import '../Model/ModelCommonList.dart';
import '../Utils/Connectivity.dart';
import '../Utils/toast.dart';
import 'home_page_screen.dart';
class VisaprocessingListScreen extends StatefulWidget {
  final String catId;
  final String title;

  const VisaprocessingListScreen({key,this.catId, this.title}) : super(key: key);

  @override
  State<VisaprocessingListScreen> createState() => _VisaprocessingListScreenState();
}

class _VisaprocessingListScreenState extends State<VisaprocessingListScreen> {

  ModelCommonList model;

  @override
  void initState() {
    super.initState();
    commonListApiCall();
  }



  commonListApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        apiFunc();
      } else {
        showToast("Please check your internet connection",);

        return;
      }
    });
  }

  apiFunc() {
    CommonListApiService.commonListApiCall(
        context,widget.catId)
        .then((result) async {
      try {

        showToast(result.message.toString(),);


        // progressDialog.hide();
        if (result.success) {

          setState((){
            model = result;
          });

          showToast((result.message));
        }
        // await progressDialog.hide();
        showToast((result.message),);
      } catch (e) {
        //await progressDialog.hide();
      }
    });
  }

  Future<ModelCommonList> getCommonList() async {
    return  model;
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
              Navigator.pushReplacement(context,  MaterialPageRoute(
                builder: (context) {
                  return const
                  HomePageScreen();
                },
              ),
              );
            },
          ),
        ),
        title: Text(widget.title,
          style: const TextStyle(
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

      body: Column(
        children: [
          const SizedBox(height: 10,),
          const Divider(height: 1,thickness: 0.5,color: Colors.white,),
          SizedBox(
            height: size.height*0.8,
            child: FutureBuilder(

              future: getCommonList(),
              builder: (BuildContext context, snapshot) {
                print("snapshot"+snapshot.data.toString());
                if (snapshot.hasData) {
                  return ListView.separated(
                    itemCount:model.data.length,
                    padding: const EdgeInsets.only(top: 20,bottom: 20,left: 10,right: 10),
                    itemBuilder: (ctx,index){
                      return  GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                            return VisaProcessingListingDetails(
                              catId:widget.catId,
                              title: model.data[index].subCat,
                              subcatId: model.data[index].id.toString(),
                            ) ;
                          }));
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 0,
                          child: Container(
                            height: 120,
                            width: size.width,
                            child: Center(
                              child: ListTile(
                                leading:Image.network(model.data[index].subcatImage,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.contain,),

                                title: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(model.data[index].subCat.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                    ),),
                                ),

                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx,index){
                      return const SizedBox(height: 10,);
                    },

                  );

                }
                else{
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

