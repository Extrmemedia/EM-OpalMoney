import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opal_money/Common/constants.dart';
import 'package:opal_money/Controller/buying_screen.dart';
import 'package:opal_money/Controller/houses_apartments_tab_list_screen.dart';
import 'package:opal_money/Controller/selling_items_list.dart';
import 'package:opal_money/Controller/selling_screen.dart';

import 'home_page_screen.dart';

class RealEstateScreen extends StatefulWidget {
  const RealEstateScreen({Key key}) : super(key: key);

  @override
  State<RealEstateScreen> createState() => _RealEstateScreenState();
}

class _RealEstateScreenState extends State<RealEstateScreen> {
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
        title:const Text("Real Estate",
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
        height:size.height ,
        width: size.width,
        color: themeColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 20,bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 230,
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
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 160,
                              width: size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/real_bg.jpg",height: 160,width: 250,fit: BoxFit.cover,),
                                ],
                              ),
                            ),

                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buttonRow()
                              ],
                            )
                          ],
                        )
                      ),
                    ),
                  ),

                ),
                const SizedBox(height: 20,),
                
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height:120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                 return const HousesApartmentsTabListScreen(property_id: "2",);
                                }));
                              },

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 10,),
                                  Image.asset("assets/images/house_apartments.png",fit:BoxFit.fill,height: 50,width: 50,),
                                  const SizedBox(height: 10,),
                                  const Text("Houses & Apartments",style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Roboto",
                                    fontSize: 12.0
                                  ),)
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return const HousesApartmentsTabListScreen(property_id: "1",);
                                }));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 10,),
                                  Image.asset("assets/images/lands_plots.png",fit:BoxFit.fill,height: 50,width: 50,),
                                  const SizedBox(height: 10,),
                                  const Text("Lands & Plots",style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Roboto",
                                      fontSize: 12.0
                                  ),)
                                ],
                              ),
                            ),


                            GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                  return SellingItemsList();
                                }));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 10,),
                                  Image.asset("assets/images/selling_items_list.png",fit:BoxFit.fill,height: 50,width: 50,),
                                  const SizedBox(height: 10,),
                                  const Text("Selling Items List",style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Roboto",
                                      fontSize: 12.0
                                  ),)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 60,),
                      GestureDetector(
                        onTap:() {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                            return const BuyingScreen();
                          }));
                        },
                        child: const ListTile(
                          title:Text("Share Customized Requirement",
                            style: TextStyle(
                              fontSize: 18,
                              color: themeColor,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                            ),
                          ) ,
                          subtitle:Text("Flat/Apartments, Villas..",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w300,
                          ),
                        ) ,

                          trailing: Icon(Icons.arrow_forward_ios,color: themeColor,),
                        ),
                      ),
                      const SizedBox(height:20),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0,right: 10),
                        child: Divider(height: 1,thickness: 1,color: Colors.black12,),
                      ),
                      const SizedBox(height:20),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) {
                            return const HousesApartmentsTabListScreen(property_id: "2");
                          }));
                        },
                        child: const ListTile(
                          title:Text("Market Place House",
                            style: TextStyle(
                              color: themeColor,
                              fontSize: 18,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                            ),
                          ) ,
                          subtitle:Text("Flat/Apartments, Villas..",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w300,
                            ),
                          ) ,

                          trailing: Icon(Icons.arrow_forward_ios,color: themeColor,),
                        ),
                      ),
                      const SizedBox(height:20),
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0,right: 10),
                        child: Divider(height: 1,thickness: 1,color: Colors.black12,),
                      ),
                      const SizedBox(height:100),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  buttonRow() {
    return  Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: themeColor,
                padding: const EdgeInsets.only(left: 50, right: 50),
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 15,
                ),
                // Set this
              ),
              onPressed: () {},
              child: const Text('Buying',style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.w500),),
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
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) {
                  return const SellingScreen();
                }));
              },
              child: const Text('Selling',style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.w500),),
            ),
          ),
        ],
      ),
    );
  }
}
