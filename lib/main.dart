import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'Controller/splash_screen.dart';
import 'dart:async';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // set the publishable key for Stripe - this is mandatory
  ///
  /// secret key for live =   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
  // ///
  // Stripe.publishableKey =
  // 'pk_live_51Lr5DwSFsBDs6QSDD61EDk7LaMZFrwQs5QgTzYznXbTVdpnjC9qvVjjLvUU0zpY14yU9XLPLM7K5gVZuu4FRGkYb00X6vMiYaM';
  //'pk_test_51Lr5DwSFsBDs6QSDaUdmexXGYWptrDtmvu2Dm0uJU15LNW0bBLK00Kc6OE7km0INODUilrL6PNYG97qeeF3iibUQ00cazHgSqC';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);


    return MaterialApp(
      title: 'Opal Money',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
       home: const SplashScreen(),
    //home: MyWalletScreen(),
    );
  }
}


