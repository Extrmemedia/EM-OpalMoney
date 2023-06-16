import 'package:flutter/material.dart';

import '../Common/constants.dart';
import '../Model/ModelPlanDetails.dart';
class VisaProcessingDetailsScreen extends StatefulWidget {
  final String subcatId;
  final String description;
  final String title;
  final String plan;
  final String image;
  const VisaProcessingDetailsScreen({key, this.subcatId, this.description, this.title, this.plan,this.image}) : super(key: key);

  @override
  State<VisaProcessingDetailsScreen> createState() => _VisaProcessingDetailsScreenState();
}

class _VisaProcessingDetailsScreenState extends State<VisaProcessingDetailsScreen> {
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

              child: SizedBox(
                height: size.height,
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
                              child: Image.network(widget.image,
                                fit: BoxFit.cover,

                              ),
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
                    Expanded(
                      child: Text(widget.description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'popins',
                          height:1.5,
                          fontSize: 13,

                        ),
                        softWrap: true,
                      ),
                    ),

                  ],
                ),
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
            onPressed: () {},
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
            onPressed: () {},
            child: const Text('Apply Now',style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.w400),),
          ),
        ),
      ],
    );
  }
}
