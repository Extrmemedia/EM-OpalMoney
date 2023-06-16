import 'package:flutter/material.dart';
import 'package:opal_money/Controller/visaprocessingdetails.dart';
import 'package:toast/toast.dart';

import '../ApiService/planListApiService.dart';
import '../Common/constants.dart';
import '../Model/ModelPlanList.dart';
import '../Utils/Connectivity.dart';
import '../Utils/toast.dart';
import 'enquiry_form.dart';
class VisaProcessingListingDetails extends StatefulWidget {
  final String catId;
  final String subcatId;
  final String title;

  const VisaProcessingListingDetails({key,this.catId,this.subcatId,this.title}) : super(key: key);

  @override
  State<VisaProcessingListingDetails> createState() => _VisaProcessingListingDetailsState();
}

class _VisaProcessingListingDetailsState extends State<VisaProcessingListingDetails> {
  ModelPlanList model;

  @override
  void initState() {
    super.initState();
    planListApiCall();
  }


  planListApiCall() {
    ConnectivityCheck.checkConnection().then((connectionResult) async {
      if (connectionResult) {
        //await progressDialog.show();
        apiFunc();
      } else {
        showToast("Please check your internet connection");

        return;
      }
    });
  }

  apiFunc() {
    PlanListApiService.planListApiCall(
        context,widget.subcatId)
        .then((result) async {
      try {

        showToast(result.message.toString());




        // progressDialog.hide();
        if (result.success) {
          setState((){
            model = result;
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

  Future<ModelPlanList> getPlanList() async {
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
              Navigator.pop(context);
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
              future: getPlanList(),
              builder: (BuildContext context,snapshot) {
                if(snapshot.hasData){
                  return ListView.separated(
                      padding: const EdgeInsets.only(top: 20,bottom: 20,left: 10,right: 10),
                      itemBuilder: (ctx,index){
                        return  Card(
                          color: Colors.white,
                          elevation: 0,
                          child: SizedBox(
                            height: 170,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 20,
                                  left: 10,
                                  child: Image.network(model.data[index].planImage,
                                    height: 80,width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                Positioned(
                                    top: 20,
                                    left: 120,
                                    child: Row(
                                      children:  [
                                        Text(model.data[index].plan, style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Roboto",
                                        ),
                                        ),

                                      ],
                                    )
                                ),
                                Positioned(
                                  top: 50,
                                  left: 110,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                        return VisaProcessingDetailsScreen(
                                          subcatId: model.data[index].id.toString(),
                                          title: model.data[index].subCat,
                                          plan: model.data[index].plan,
                                          description: model.data[index].description,
                                          image: model.data[index].planImage,
                                        );
                                      }));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0,right: 5),
                                      child: RichText(
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        text: TextSpan(
                                          // Note: Styles for TextSpans must be explicitly defined.
                                          // Child text spans will inherit styles from parent

                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:"${model.data[index].description.substring(0,80)}...",
                                              style: const TextStyle( color: Colors.grey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                fontFamily: "Roboto",
                                              ),

                                            ),
                                            const TextSpan(text: 'Know More', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87,
                                              fontSize: 12,
                                              fontFamily: "Roboto",)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // child: Row(
                                  //   children: const [
                                  //     Expanded(
                                  //       child: Text("Term insurance is the simplest and purest form of life insurance, offering financial coverage...", style: TextStyle(
                                  //           color: Colors.black87,
                                  //           fontSize: 13,
                                  //           fontWeight: FontWeight.w300,
                                  //           fontFamily: "Roboto",
                                  //       ),
                                  //         softWrap: true,
                                  //       ),
                                  //     ),
                                  //
                                  //   ],
                                  // )
                                ),
                                // const Positioned(
                                //     top: 80,
                                //     right: 35,
                                //     child:  Text("Know More",
                                //       style: TextStyle(
                                //           color: Colors.black,
                                //           fontSize: 13,
                                //           fontWeight: FontWeight.w500,
                                //           fontFamily: "Roboto"
                                //       ),)),

                                Positioned(
                                    top: 120,
                                    right:20,
                                    child:  Row(
                                      children: [
                                        GestureDetector(
                                          child: Center(
                                            child: Row(
                                              children: const [
                                                Text("Enquiry ",
                                                  style: TextStyle(
                                                      color: themeColor,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Roboto"
                                                  ),),
                                                SizedBox(width: 5,),
                                                Icon(Icons.arrow_forward_ios,size: 12,color: Colors.grey,),
                                              ],
                                            ),
                                          ),
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context){
                                              return  EnquiryFormScreen(
                                                catId: widget.subcatId,
                                                subcatId: model.data[index].id.toString(),
                                                planId:model.data[index].id.toString(),
                                                title: model.data[index].subCat,

                                              );
                                            }));
                                          },
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 10.0,right: 10),
                                          child: Text("|",style: TextStyle(fontSize: 18,color: Colors.grey),),
                                        ),

                                        GestureDetector(
                                          // onTap: (){
                                          //   widget.subcatId =="1"?Navigator.push(context, MaterialPageRoute(builder: (context){
                                          //     // return  LifeInsuranceApplicationForm(
                                          //     //   catId: widget.catId,
                                          //     //   subcatId: model.data[index].id.toString(),
                                          //     //   planId:model.data[index].id.toString(),
                                          //     // );
                                          //   })): widget.subcatId =="2"?Navigator.push(context, MaterialPageRoute(builder: (context){
                                          //     return const HealthInsuranceApplicationForm();
                                          //   })): widget.subcatId =="3"?Navigator.push(context, MaterialPageRoute(builder: (context){
                                          //     return const VehicleInsuranceApplication();
                                          //   })):
                                          //
                                          //   showDialog(
                                          //     context: context,
                                          //     builder: (context) => AlertDialog(
                                          //       content: Stack(
                                          //         alignment: Alignment.center,
                                          //         children: <Widget>[
                                          //           Image.asset("assets/images/recharge.png",
                                          //             height: 170,
                                          //             fit: BoxFit.cover,
                                          //           ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //   );
                                          // },
                                          child: Row(
                                            children: const [
                                              Text("Apply Now",
                                                style: TextStyle(
                                                    color: themeColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Roboto"
                                                ),),
                                              SizedBox(width: 5,),
                                              Icon(Icons.arrow_forward_ios,size: 12,color: Colors.grey,),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (ctx,index){
                        return const SizedBox(height: 10,);
                      },
                      itemCount: model.data.length);
                }
                else{
                  return  const Center(
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

