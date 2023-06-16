import 'package:flutter/material.dart';











class EnquirySucessScreen extends StatefulWidget {
  String screenType='';


   EnquirySucessScreen({Key key,this.screenType}) : super(key: key);

  @override
  State<EnquirySucessScreen> createState() => _EnquirySucessScreenState();
}

class _EnquirySucessScreenState extends State<EnquirySucessScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
      Navigator.pop(context);

    });
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,

      child: Scaffold(
        body: Container(
          color: Color(0xff4242432),
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    "assets/images/withdrawsucs2.png",

                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox( height: 15,),
                Text('Thank You!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,

                  ),),
                SizedBox( height: 20,),
                Text(widget.screenType=='enquiry'?'Your Enquiry is send successfully\nOur Team Will Get Back You Soon':widget.screenType=='r'?'Your Registration is successful':'',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,

                  ),),


              ],
            ),
          ),
        ),

      ),
    );
  }
}

