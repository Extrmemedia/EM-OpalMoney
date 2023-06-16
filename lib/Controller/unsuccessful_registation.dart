import 'package:flutter/material.dart';
class UnSuccessRegistration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                  "assets/images/wrong.png",

                  fit: BoxFit.fill,
                ),
              ),
              SizedBox( height: 15,),
              Text('Oops!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,

                ),),
              SizedBox( height: 20,),
              Text('Something Went Wrong',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,

                ),),
              SizedBox( height: 15,),
              Text('Retry',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,

                ),),


            ],
          ),
        ),
      ),

    );
  }
}

