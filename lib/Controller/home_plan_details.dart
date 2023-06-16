import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/Common/constants.dart';
import 'package:opal_money/Controller/home_page_screen.dart';

class HomePlanDetails extends StatefulWidget {
  const HomePlanDetails({Key key}) : super(key: key);

  @override
  State<HomePlanDetails> createState() => _HomePlanDetailsState();
}

class _HomePlanDetailsState extends State<HomePlanDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor:themeColor,
          appBar: AppBar(
              backgroundColor: themeColor,
              centerTitle: true,
              title: const Text(
                "Home Loan Plan Details",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
                    return const HomePageScreen();
                  }));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white70,
                ),
              )),
          bottomSheet: Container(height: 80, color: themeColor, child: buttonBottom()),
          body: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: SingleChildScrollView(

              child: SizedBox(
                height: size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:10.0,bottom: 50,),
                      child: SizedBox(
                        height: 250,
                        width: size.width,
                        child: Card(
                          color: const Color(0xFFEAE7FF),
                          elevation: 2.0,
                          shadowColor: const Color(0xFFEAE7FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset("assets/images/home_plan_details.png",
                                fit: BoxFit.fill,

                              ),
                            ),
                          ),
                        ),

                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Home Loan', style:
                      TextStyle(color: Colors.white,
                          fontSize: 21),),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Housing Loan is a stepping stone in realizing your dream home. '
                          'LIC HFL offers wide variety of home loans which will fulfill your'
                          ' needs at one of the lowest interest '
                          'rates available. Our home loans cater to all types of customer base viz., salaried, self-employed, '
                          'professional, NRIs, etc. '
                          'Our products are customizable according to your home loan eligibility.',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'popins',
                        height:1.5,
                        fontSize: 13,

                      ),
                    ),

                  ],
                ),
              ),
            ),
          )),
    );
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
            child: const Text('Enquiry',style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.w500),),
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
            child: const Text('Apply Now',style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.w500),),
          ),
        ),
      ],
    );
  }
}
