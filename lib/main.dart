import 'dart:async';

import 'package:final_project4/ThemeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Login.dart';


void main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(create: (_) => MyThemes(),
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,

        ),
        debugShowCheckedModeBanner: false,
        title: ' Shopping App',
        home: SplashScreen(),
      ),
    );
  }
}
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    }
    );

    return Scaffold(
      backgroundColor:Provider.of<MyThemes>(context).backGroundColor ,
      body: Center(
        child: Image.asset("images/splash.png"),
      ),

    );
  }
}


