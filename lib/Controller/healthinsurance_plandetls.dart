import 'package:flutter/material.dart';
import 'package:opal_money/Controller/vehicleinsurance_applictn.dart';

import 'home_page_screen.dart';


class HealthInsurancePlanDetails extends StatelessWidget {
  const HealthInsurancePlanDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xfff09003F),
          appBar: AppBar(
            backgroundColor: const Color(0xfff09003F),
            centerTitle: true,
            title: const Text(
              "Health Insurance Plan Details",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,  MaterialPageRoute(
                  builder: (context) {
                    return const HomePageScreen();
                  },
                ),
                );
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white70,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(children: [
                  Container(
                    height: 200,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    //padding: EdgeInsets.only(left: 50,right: 50),
                    child: Image.asset(
                      'assets/bag1.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 50,
                    child: Container(
                      height: 150,
                      width: 200,
                      // color: Colors.blue,
                      child: Image.asset(
                        'assets/healthpic.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 15,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Complete Health Insurance',
                    style: TextStyle(color: Color(0xffD1D1D1), fontSize: 21),
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Zero hassle health plans starting at ₹15/day',
                      style: TextStyle(color: Color(0xffD1D1D1)),
                    )),
                const SizedBox(height: 20),
                const Text(
                  'ICICI Lombard Complete Health Insurance policy secures your finances'
                      ' against sudden medical expenses. It is a comprehen sive policy '
                      'for you and your family, designed to cater to most of your common'
                      ' healthcare needs. It comes with an option to include your family under '
                      'one policy called the family floater option. You can choose coverage for '
                      'your family health insurance as per your medical needs such as maternity cover,'
                      ' OPD cover, critical illness cover, donor expenses cover, etc. Some of its note '
                      'worthy features include no limit on hospital room rent, no co-pay, no pre-medical'
                      ' check-up up to 45 years of age and 2 complimentary health check -up coupons every '
                      'year for a family floater health insurance policy. As a result, it is one of the '
                      'preferred health insurance policies in India.',
                  style: TextStyle(
                    color: Color(0xffD1D1D1),
                    fontFamily: 'popins',
                    height: 1.3,
                    fontSize: 12,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        margin: const EdgeInsets.only(top: 80),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF3700B3),
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            primary: Colors.white,
                            textStyle: const TextStyle(fontSize: 15),
                            // Set this
                          ),
                          onPressed: () {},
                          child: const Text('Enquiry'),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        margin: const EdgeInsets.only(top: 80),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            primary: Colors.black,
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return const VehicleInsuranceApplication();
                          }
                            ));
                          },
                          child: const Text('Apply Now'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
