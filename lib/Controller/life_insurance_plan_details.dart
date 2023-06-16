import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/ApiService/planDetailsApiService.dart';
import 'package:opal_money/Controller/enquiry_form.dart';
import 'package:opal_money/Controller/vehicleinsurance_applictn.dart';
import 'package:opal_money/Model/ModelPlanDetails.dart';
import 'package:toast/toast.dart';

import '../Common/constants.dart';
import '../Utils/Connectivity.dart';
import 'health_insurance_application_form.dart';
import 'life_insurance_application_form.dart';

class LifeInsurancePlanDetails extends StatefulWidget {
  final String subcatId;
  final String description;
  final String title;
  final String plan;
  final String image;
  int index;
 String catId;

 String planId;


   LifeInsurancePlanDetails({key, this.subcatId, this.description, this.title, this.plan,this.image,this.index,this.catId,this.planId}):super(key: key);

  @override
  State<LifeInsurancePlanDetails> createState() => _LifeInsurancePlanDetailsState();
}

class _LifeInsurancePlanDetailsState extends State<LifeInsurancePlanDetails> {
   ModelPlanDetails model;
  @override

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor:themeColor,
          appBar: AppBar(
              backgroundColor: themeColor,
              centerTitle: true,
              title:  Text(widget.title,
                    style: const TextStyle(
                    fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto"
                    ),
                  ),

              elevation: 0,
              leading: IconButton(
                onPressed: () {
                 Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white70,
                ),
              )),
          bottomSheet: Container(height: 80, color: themeColor, child: buttonBottom()),
          body: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:10.0,bottom: 20,),
                          child: SizedBox(
                            height: 200,
                            width: size.width,
                            child: Card(
                              color: const Color(0xFFEAE7FF),
                              elevation: 2.0,
                              shadowColor: const Color(0xFFEAE7FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CachedNetworkImage(

                                      fit: BoxFit.cover,
                                      imageUrl:  widget.image,
                                      placeholder: (context, url) =>
                                          Container(),
                                      errorWidget:
                                          (context, url, error) =>
                                          Image.asset(
                                            'assets/images/no_image.png',
                                            scale: 4.0,
                                          )),

                                ),
                              ),
                            ),

                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(widget.plan, style:
                          const TextStyle(color: Colors.white,
                              fontSize: 20),),
                        ),
                        const SizedBox(height: 20),
                         Text(widget.description,
                           style: const TextStyle(
                             color: Colors.white,
                             fontFamily: 'popins',
                             height:1.5,
                             fontSize: 13,

                           ),
                           softWrap: true,
                         ),
                      ],
                    ),
                  ),
                ),



    ));
  }

  buttonBottom() {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF3700B3),
              padding: const EdgeInsets.only(left: 50, right: 50),
              primary: Colors.white,
              textStyle: const TextStyle(fontSize: 15,
              ),
              // Set this
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) {
                        return EnquiryFormScreen(
                          catId: widget.catId,
                          subcatId: widget.subcatId,
                          planId:widget.planId,
                          title: widget.title
                        );
                      }));
            },
            child: const Text('Enquiry',style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.w400),),
          ),
        ),
        SizedBox(
          height: 40,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.only(left: 50, right: 50),
              primary: Colors.black,
              textStyle: const TextStyle(fontSize: 15),
            ),
            onPressed: () {
              print('fkfjjfjfj ' +widget.subcatId);
              widget.catId == "1"
                  ? Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) {
                        return LifeInsuranceApplicationForm(
                          catId: widget.catId,
                          subcatId: widget.subcatId
                              .toString(),
                          planId:  widget.subcatId
                              .toString(),
                        );
                      }))
                  : widget.catId == "2"
                  ? Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) {
                        return HealthInsuranceApplicationForm(
                          catId: widget.catId,
                          subcatId:  widget.subcatId
                              .toString(),
                          planId:  widget.subcatId
                              .toString(),
                        );
                      }))
                  : widget.catId == "3"
                  ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder:
                          (context) {
                        return const VehicleInsuranceApplication();
                      }))
                  : showDialog(
                context: context,
                builder:
                    (context) =>
                    AlertDialog(
                      content: Stack(
                        alignment:
                        Alignment
                            .center,
                        children: <
                            Widget>[
                          Image.asset(
                            "assets/images/recharge.png",
                            height: 170,
                            fit: BoxFit
                                .cover,
                          ),
                        ],
                      ),
                    ),
              );
            },
            child: const Text('Apply Now',style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.w400),),
          ),
        ),
      ],
    );
  }
}
