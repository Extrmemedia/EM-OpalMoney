import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../ApiService/referal_income_api.dart';
import '../Common/constants.dart';
import '../Model/myreferral_income_model.dart';
import '../Utils/toast.dart';
import 'home_page_screen.dart';

class MyReferralIncomeScreen extends StatefulWidget {
  const MyReferralIncomeScreen({Key key}) : super(key: key);

  @override
  State<MyReferralIncomeScreen> createState() => _MyReferralIncomeScreenState();
}

class _MyReferralIncomeScreenState extends State<MyReferralIncomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCall();
  }

  List<Data> income = [];

  apiCall() {
    ReferalIncomeApiService.referalincomeApiCall(context).then((value) {
      if (value['status'] == '1') {
        setState(() {
          income = ((value["data"] ?? []) as List)
              .map((li) => Data.fromJson(li))
              .toList();
        });
      } else {
        showToast(value['message'],  );
      }
    });
  }







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
            icon: const Icon(Icons.arrow_back,size: 26,color: Colors.white70,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title:const Text("My Referral Income",
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
        color: themeColor,
        height: size.height,
        width: double.infinity,

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10,top: 15,bottom: 30),
            child: Column(

              mainAxisAlignment:MainAxisAlignment.start ,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      child: Image.asset("assets/images/my_referal.png",fit: BoxFit.cover,),
                    ),
                  ),
                ),

                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("My Referral Income",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          fontFamily: "Poppins"

                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),

                Scrollbar(

                  thumbVisibility: false,
                  trackVisibility: false,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        color: Colors.grey[100],
                        width: size.width*2,
                        child: Column(
                          children: [
                            Table(
                              border: TableBorder.symmetric(
                                outside: BorderSide.none,
                                inside: BorderSide.none,
                                //const BorderSide(width: 1, color: Colors.grey, style: BorderStyle.solid),
                              ),
                              columnWidths: const {
                                0: FlexColumnWidth(140),
                                //1: FlexColumnWidth(300),
                                2: FlexColumnWidth(400),
                                3: FlexColumnWidth(340),
                                4: FlexColumnWidth(230),
                                5: FlexColumnWidth(220),
                                6: FlexColumnWidth(330),
                              },
                              children: [
                                TableRow(

                                    children: [
                                      Container(
                                          height: 50,
                                          color: const Color(0xFF174F78),
                                          padding: const EdgeInsets.only(left: 5,right: 5),
                                          child: const Center(child: Text("Sl.No",
                                            style: TextStyle(color: Colors.white,
                                              fontSize: 10.0,
                                            ),
                                          )
                                          )
                                      ),

                                      // Container(
                                      //     height: 50,
                                      //     color: const Color(0xFF174F78),
                                      //     padding: const EdgeInsets.only(left: 5,right: 5),
                                      //     child: const Center(child: Text("Customer Code",
                                      //       style: TextStyle(color: Colors.white,
                                      //           fontSize: 10.0
                                      //       ),
                                      //     )
                                      //     )
                                      // ),

                                      Container(
                                          height: 50,
                                          color: const Color(0xFF174F78),
                                          padding: const EdgeInsets.only(left: 5,right: 5),
                                          child: const Center(child: Text("Name",
                                            style: TextStyle(color: Colors.white,
                                                fontSize: 10.0
                                            ),
                                          )
                                          )
                                      ),

                                      Container(
                                          height: 50,
                                          color: const Color(0xFF174F78),
                                          padding: const EdgeInsets.only(left: 5,right: 5),
                                          child: const Center(child: Text("Mobile.no",
                                            style: TextStyle(color: Colors.white,
                                                fontSize: 10.0
                                            ),
                                          )
                                          )
                                      ),

                                      Container(
                                          height: 50,
                                          color: const Color(0xFF174F78),
                                          padding: const EdgeInsets.only(left: 5,right: 5),
                                          child: const Center(child: Text("Active\n/Inactive",
                                            style: TextStyle(color: Colors.white,
                                                fontSize: 10.0
                                            ),
                                          )
                                          )
                                      ),
                                      Container(
                                          height: 50,
                                          color: const Color(0xFF174F78),
                                          padding: const EdgeInsets.only(left: 5,right: 5),
                                          child: const Center(child: Text("Referral\nIncome",
                                            style: TextStyle(color: Colors.white,
                                                fontSize: 10.0
                                            ),
                                          )
                                          )
                                      ),

                                      Container(
                                          height: 50,
                                          color: const Color(0xFF174F78),
                                          padding: const EdgeInsets.only(left: 5,right: 5),
                                          child: const Center(child: Text("Joining\nDate",
                                            style: TextStyle(color: Colors.white,
                                                fontSize: 10.0
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
                                0: FlexColumnWidth(140),
                               // 1: FlexColumnWidth(300),
                                2: FlexColumnWidth(400),
                                3: FlexColumnWidth(340),
                                4: FlexColumnWidth(230),
                                5: FlexColumnWidth(220),
                                6: FlexColumnWidth(330),
                              },
                              children: List.generate(income.length, (index){
                                int count = index+1;
                                return TableRow(children: [
                                  Container(
                                    height: 50,
                                      color:Colors.grey[100],
                                      padding: const EdgeInsets.only(left: 5,right: 5),
                                      child: Center(child: Text(count.toString(),
                                        style: const TextStyle(color: themeColor,
                                            fontSize: 10),
                                      ))),
                                  // Container(
                                  //     height: 50,
                                  //     color:Colors.grey[100],
                                  //     padding: const EdgeInsets.only(left: 5,right: 5),
                                  //     child: Center(child: Text(income[index].userid.toString(),
                                  //       style: const TextStyle(color: themeColor,
                                  //           fontSize: 10),
                                  //     ))),
                                  Container(
                                      height: 50,
                                      color:Colors.grey[100],
                                      padding: const EdgeInsets.only(left: 5,right: 5),
                                      child: Center(child: Text(income[index].customer,
                                        style: const TextStyle(color: themeColor,fontSize: 10),
                                      ))),

                                  Container(
                                      height: 50,
                                      color:Colors.grey[100],
                                      padding: const EdgeInsets.only(left: 5,right: 5),
                                      child: Center(child: Text(income[index].mobile.toString(),
                                        style: const TextStyle(color: themeColor,fontSize: 10),
                                      ))),

                                  Container(
                                      height: 50,
                                      color:Colors.grey[100],
                                      padding: const EdgeInsets.only(left: 15,right: 15,top: 12,bottom: 12),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color:income[index].status==1?Colors.green[800]:Colors.grey[400],
                                            borderRadius: const BorderRadius.all(Radius.circular(5))
                                        ),
                                        child: Center(child: Text(income[index].status==1?'Active':'Inactive',
                                          style: const TextStyle(color: Colors.white,fontSize: 10),
                                        )),
                                      )),

                                  Container(
                                      height: 50,
                                      color:Colors.grey[100],
                                      padding: const EdgeInsets.only(left: 5,right: 5),
                                      child: Center(child: Text(income[index].amount.toString(),
                                        style: const TextStyle(color: themeColor,fontSize: 10),
                                      ))),
                                  Container(
                                      height: 50,
                                      color:Colors.grey[100],
                                      padding: const EdgeInsets.only(left: 5,right: 5),
                                      child: Center(child: Text(income[index].date,
                                        style: const TextStyle(color: themeColor,fontSize: 10),
                                      ))),
                                ]);
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20,),


              ],
            ),
          ),
        ),
      ),
    );
  }

}
