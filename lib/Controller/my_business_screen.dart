import 'package:flutter/material.dart';
import '../ApiService/my_business_api.dart';
import '../Common/constants.dart';
import '../Model/mybusiness_model.dart';
import '../Utils/toast.dart';

class MyBusinessScreen extends StatefulWidget {
  const MyBusinessScreen({Key key}) : super(key: key);

  @override
  State<MyBusinessScreen> createState() => _MyBusinessScreenState();
}

class _MyBusinessScreenState extends State<MyBusinessScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCall();
  }

  List<MyBusiness> business = [];

  apiCall() {
    MyBusinessApiService.mybusinessApiCall(context).then((value) {
      if (value['status'] == '1') {
        setState(() {
          business = ((value["data"] ?? []) as List)
              .map((li) => MyBusiness.fromJson(li))
              .toList();
        });
      } else {
        showToast(value['message'],  );
      }
    });
  }


  final List<Map> _users = [
    {'sl': 1,'cat':'Trading Account','completed':'C','date':'05.05.2022','incentive':'50','reason':''},
    {'sl': 2,'cat':'Life Insurance','completed':'P','date':'05.05.2022','incentive':'X','reason':''},
    {'sl': 3,'cat':'Health Insurance','completed':'P','date':'05.05.2022','incentive':'','reason':''},
    {'sl': 4,'cat':'Vehicle Insurance','completed':'C','date':'05.05.2022','incentive':'50','reason':''},
    {'sl': 5,'cat':'Home Loan','completed':'C','date':'05.05.2022','incentive':'50','reason':''},
    {'sl': 6,'cat':'Personal Loan','completed':'C','date':'05.05.2022','incentive':'50','reason':''},
    {'sl': 7,'cat':'Educational Loan','completed':'P','date':'05.05.2022','incentive':'','reason':''},
    {'sl': 8,'cat':'MBBS Study Abroad','completed':'P','date':'05.05.2022','incentive':'X','reason':''},
    {'sl': 9,'cat':'Overseas Job\nConsultancy','completed':'C','date':'05.05.2022','incentive':'50','reason':''},



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
            icon: const Icon(Icons.arrow_back,size: 26,color: Colors.white70,),
            onPressed: () {
            Navigator.pop(context);
            },
          ),
        ),
        title:const Text("My Business",
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
                      child: Image.asset("assets/images/my_business.png",height: 200,width: 200,fit: BoxFit.contain,),
                    ),
                  ),
                ),
                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("My Business",
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
                Scrollbar(
                  thumbVisibility: false,
                  trackVisibility: false,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        color: Colors.grey[100],
                        width: size.width,
                        child: Column(
                          children: [
                            Table(
                              border: TableBorder.symmetric(
                                outside: BorderSide.none,
                                inside: BorderSide.none,
                                //const BorderSide(width: 1, color: Colors.grey, style: BorderStyle.solid),
                              ),
                              columnWidths: const {
                                0: FlexColumnWidth(35),
                                1: FlexColumnWidth(100),
                                2: FlexColumnWidth(80),
                                3: FlexColumnWidth(80),
                                4: FlexColumnWidth(70),
                                5: FlexColumnWidth(70),
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
                                                fontSize: 10.0
                                            ),
                                          )
                                          )
                                      ),

                                      Container(
                                          height: 50,
                                          color: const Color(0xFF174F78),
                                          padding: const EdgeInsets.only(left: 5,right: 5),
                                          child: const Center(child: Text("Completed\n/Pending",
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
                                          child: const Center(child: Text("Reg.date",
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
                                          child: const Center(child: Text("Incentive\nGiven",
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
                                          child: const Center(child: Text("Rejection\nReason",
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
                                0: FlexColumnWidth(35),
                                1: FlexColumnWidth(100),
                                2: FlexColumnWidth(80),
                                3: FlexColumnWidth(80),
                                4: FlexColumnWidth(70),
                                5: FlexColumnWidth(70),
                              },
                              children: List.generate(business.length, (index){
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
                                      child: Center(child: Text(business[index].category,
                                        style: const TextStyle(color: themeColor,fontSize: 10),
                                      ))),

                                  Container(
                                      height: 50,
                                      color:Colors.grey[100],
                                      padding: const EdgeInsets.only(left: 5,right: 5),
                                      child: Center(child: Text(business[index].businessStatus,
                                        style: const TextStyle(color: themeColor,fontSize: 10),
                                      ))),

                                  Container(
                                      height: 50,
                                      color:Colors.grey[100],
                                      padding: const EdgeInsets.only(left: 15,right: 15,top: 12,bottom: 12),
                                      child: Center(child: Text(business[index].regDate,
                                        style: const TextStyle(color: Colors.white,fontSize: 10),
                                      ))),

                                  Container(
                                      height: 50,
                                      color:Colors.grey[100],
                                      padding: const EdgeInsets.only(left: 5,right: 5),
                                      child: Center(child: Text(business[index].amount,
                                        style: const TextStyle(color: themeColor,fontSize: 10),
                                      ))),
                                  Container(
                                      height: 50,
                                      color:Colors.grey[100],
                                      padding: const EdgeInsets.only(left: 5,right: 5),
                                      child: Center(child: Text(business[index].rejectionreasonhere??'',
                                        style: const TextStyle(color: themeColor,fontSize: 10),
                                      ))),
                                ]);
                              }).toList(),
                            ),
                            // Table(
                            //   border: const TableBorder(verticalInside: BorderSide(width: 0.5, color: themeColor, style: BorderStyle.solid)),
                            //   columnWidths: const {
                            //     0: FlexColumnWidth(35),
                            //     1: FlexColumnWidth(100),
                            //     2: FlexColumnWidth(80),
                            //     3: FlexColumnWidth(80),
                            //     4: FlexColumnWidth(70),
                            //     5: FlexColumnWidth(70),
                            //   },
                            //   children: _users.map((user) {
                            //     return TableRow(children: [
                            //       Container(
                            //         height:50,
                            //           color: _users.indexOf(user) % 2 == 0
                            //               ? Colors.grey[100]
                            //               : const Color(0xFFE0E0E0),
                            //           padding: const EdgeInsets.only(top: 10,bottom: 10,left: 2,right: 2),
                            //           child: Center(child: Text(user['sl'].toString(),
                            //             style: const TextStyle(color: themeColor,
                            //                 fontSize: 10),
                            //           ))),
                            //       Container(
                            //           height:50,
                            //           color: _users.indexOf(user) % 2 == 0
                            //               ? Colors.grey[100]
                            //               : const Color(0xFFE0E0E0),
                            //           padding: const EdgeInsets.only(top: 10,bottom: 10,left: 2,right: 2),
                            //           child: Padding(
                            //             padding: const EdgeInsets.only(left: 8.0),
                            //             child: Text(user['cat'],
                            //               style: const TextStyle(color: themeColor,
                            //                   fontSize: 10),
                            //             ),
                            //           )),
                            //       Container(
                            //           height:50,
                            //           color: _users.indexOf(user) % 2 == 0
                            //               ? Colors.grey[100]
                            //               : const Color(0xFFE0E0E0),
                            //           padding: const EdgeInsets.only(top: 10,bottom: 10,left: 2,right: 2),
                            //           child: Center(child:Text(user['completed'],
                            //             style: TextStyle(color: user['completed']=="P" ?Colors.red:Colors.green,fontSize: 12,fontWeight: FontWeight.bold),
                            //           ))),
                            //
                            //       Container(
                            //           height:50,
                            //           color: _users.indexOf(user) % 2 == 0
                            //               ? Colors.grey[100]
                            //               : const Color(0xFFE0E0E0),
                            //           padding:const EdgeInsets.only(top: 10,bottom: 10,left: 2,right: 2),
                            //           child: Center(child: Text(user['date'],
                            //             style: const TextStyle(color: themeColor,fontSize: 10),
                            //           ))),
                            //
                            //       Container(
                            //           height:50,
                            //           color: _users.indexOf(user) % 2 == 0
                            //               ? Colors.grey[100]
                            //               : const Color(0xFFE0E0E0),
                            //           padding:const EdgeInsets.only(top: 10,bottom: 10,left: 2,right: 2),
                            //           child: Center(child: Text(user['incentive'],
                            //             style: TextStyle(color:user['incentive']=="X"? Colors.red:themeColor,fontSize: 10,fontWeight: user['incentive']=="X"?FontWeight.bold:FontWeight.normal),
                            //           ))),
                            //
                            //       Container(
                            //           height:50,
                            //           color: _users.indexOf(user) % 2 == 0
                            //               ? Colors.grey[100]
                            //               : const Color(0xFFE0E0E0),
                            //           padding:const EdgeInsets.only(top: 10,bottom: 10,left: 2,right: 2),
                            //           child: Center(child: Text(user['reason'],
                            //             style: const TextStyle(color: themeColor,fontSize: 10),
                            //           ))),
                            //     ]);
                            //   }).toList(),
                            // ),
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
