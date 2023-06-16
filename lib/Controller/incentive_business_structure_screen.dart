import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/Controller/home_page_screen.dart';
import 'package:opal_money/Controller/registrationscreen.dart';

import '../Common/constants.dart';

class IncentiveBusinessStructureScreen extends StatefulWidget {
  const IncentiveBusinessStructureScreen({Key key}) : super(key: key);

  @override
  State<IncentiveBusinessStructureScreen> createState() => _IncentiveBusinessStructureScreenState();
}

class _IncentiveBusinessStructureScreenState extends State<IncentiveBusinessStructureScreen> {
  final List<Map> _users = [

    {'sl':1,'name':'Trading Account','employees':'12a/c','referrer':'1a/c=25+75'},
    {'sl':2,'name':'Life Insurance' ,'employees':'2 Nos' ,'referrer' :'1Nos=25+225'},
    {'sl':3,'name':'Health Insurance','employees':'2 Nos','referrer' :'1Nos=25+225'},
    {'sl':4,'name':'Vehicle Insurance','employees':'4Nos','referrer':'4Nos=25+225'},
    {'sl':5,'name':'Home Loan','employees':'1 No','referrer':'1Nos=25+225'},
    {'sl':6,'name':'Personal Loan','employees':'25+225','referrer':'1Nos=25+225'},
    {'sl':7,'name':'Educational Loan','employees':'25+225','referrer':'1Nos=25+225'},
    {'sl':8,'name':'MBBS Study Abroad','employees':'25+225','referrer':'1Nos=25+225'},
    {'sl':9,'name':'Overseas Job Consultancy','employees':'25+225','referrer':'1Nos=25+225'},
    {'sl':10,'name':'Real Estate','employees':'25+225','referrer':'1Nos=25+225'}





  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: themeColor,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back,size: 26,color: Colors.white,),
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
        title:const Text("Incentive and Business Structure",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 15.0,
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
        color: themeColor,
        height: size.height,
        width: size.width,

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10,top: 15,bottom: 30),
            child: Column(

              children: [

                Card(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child:  ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  child: Center(
                    child: Image.asset("assets/images/incentive_business.png",fit: BoxFit.cover,height: 200,),
                  ),
                ),
                ),

                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Incentive Structure",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          fontFamily: "Poppins"

                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Container(
                  color: Colors.grey[100],
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Table(
                          border: const TableBorder(verticalInside: BorderSide(width: 0.3, color: Colors.grey, style: BorderStyle.solid)),
                          columnWidths: const {
                            0: FlexColumnWidth(25),
                            1: FlexColumnWidth(76),
                            2: FlexColumnWidth(45),
                            3: FlexColumnWidth(60),

                          },
                          children: [
                            TableRow(

                                children: [
                                  Container(
                                    height: 50,
                                      color: const Color(0xFF174F78),
                                      padding: const EdgeInsets.only(left: 5,right: 5),
                                      child: const Center(child: Text("Sl\nNo",
                                        style: TextStyle(color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      )
                                      )
                                  ),

                                  Container(
                                      height: 50,
                                      color: const Color(0xFF174F78),
                                      padding: const EdgeInsets.only(left: 5,right: 5),
                                      child: const Center(child: Text("Categories",
                                        style: TextStyle(color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      )
                                      )
                                  ),

                                  Container(
                                      height: 50,
                                      color: const Color(0xFF174F78),
                                      padding: const EdgeInsets.only(left: 5,right: 5),
                                      child: const Center(child: Text("Employees\n(Parttime)",
                                        style: TextStyle(color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      )
                                      )
                                  ),

                                  Container(
                                      height: 50,
                                      color: const Color(0xFF174F78),
                                      padding: const EdgeInsets.only(left: 5,right: 5),
                                      child: const Center(child: Text("Agent",
                                        style: TextStyle(color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      )
                                      )
                                  ),

                                ]
                            ),
                          ],
                        ),
                        Table(
                          border: const TableBorder(verticalInside: BorderSide(width: 0.5, color: themeColor, style: BorderStyle.solid)),
                          columnWidths: const {
                            0: FlexColumnWidth(25),
                            1: FlexColumnWidth(76),
                            2: FlexColumnWidth(45),
                            3: FlexColumnWidth(60),

                          },
                          children: _users.map((user) {
                            return TableRow(children: [
                              Container(
                                  color: _users.indexOf(user) % 2 == 0
                                      ? Colors.grey[100]
                                      : const Color(0xFFE0E0E0),
                                  padding: const EdgeInsets.only(top: 20,bottom: 20,left: 2,right: 2),
                                  child: Center(child: Text(user['sl'].toString(),
                                    style: const TextStyle(color: themeColor,
                                    fontSize: 10),
                                  ))),
                              Container(
                                  color: _users.indexOf(user) % 2 == 0
                                      ? Colors.grey[100]
                                      :const Color(0xFFE0E0E0),
                                  padding: const EdgeInsets.only(top: 20,bottom: 20,left: 5,right: 2),
                                  child: Text(user['name'],
                                    style: const TextStyle(color: themeColor,
                                    fontSize: 10),
                                  )),
                              Container(
                                  color: _users.indexOf(user) % 2 == 0
                                      ? Colors.grey[100]
                                      :const Color(0xFFE0E0E0),
                                  padding: const EdgeInsets.only(top: 20,bottom: 20,left: 10,right: 2),
                                  child: Text(user['employees'],
                                    style: const TextStyle(color: themeColor,fontSize: 10),
                                  )),
                              Container(
                                  color: _users.indexOf(user) % 2 == 0
                                      ? Colors.grey[100]
                                      : const Color(0xFFE0E0E0),
                                  padding: const EdgeInsets.only(top: 20,bottom: 20,left: 5,right: 5),
                                  child: Text(user['referrer'],
                                    style: const TextStyle(color: themeColor,fontSize: 10),
                                  )),

                            ]);
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Business Structure",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          fontFamily: "Poppins"

                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),


                ListTile(
                  minLeadingWidth: 5,
                  leading: bullet(),
                  title:const Text(''
                      'Rs. 295/- Registration fee will be applicable for both part time employees and referrer, its not refundable',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily:"Poppins",
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0,
                    ),),
                ),

                ListTile(
                  minLeadingWidth: 5,
                  leading: bullet(),
                  title:const Text('Please mention the job category you are interested and date of submission and forward your resume to :',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily:"Poppins",
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0,
                    ),),
                  subtitle: Text(
                  'opalmoneyindia@gmail.com',
                  style: TextStyle(
                    color: Color(0xfffFFc107),
                    fontFamily:"Poppins",
                    fontWeight: FontWeight.w500,
                    fontSize: 13.0,
                  ),
                ),
                ),

                ListTile(
                  minLeadingWidth: 5,
                  leading: bullet(),
                  title:const Text("The one who register in our application and refers P.T. Employee/ Referred agent can get Rs. 25/-individual,If they registered as P.T.Employee/ Referred agent and if you refer customer directly you can get as per the incentive structure and customer incentive page.",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily:"Poppins",
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0,
                    ),),
                ),

                ListTile(
                  minLeadingWidth: 5,
                  leading: bullet(),
                  title:const Text('For part time Employees as per Business structure 1 to 5 must be completed, the salary will be 7k.If not completing the above criteria can do any of 6th to 10th Business.If not done 5 business 1k will be deducted. Minimum 3 business should be completed from above and the salary will be 5k.',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily:"Poppins",
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0,
                    ),),
                ),
SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.only(left: 50, right: 50 ),
                          primary: Colors.black,
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RegistrationScreen();
                              },
                            ),
                          );
                        },
                        child: const Text('Register Now',style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.w400),),
                      ),
                    ),
                  ],
                ),

              ],
            ),

          ),
        ),
      ),
    );
  }

  Widget bullet(){
    return  Container(
      height: 5.0,
      width: 5.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
