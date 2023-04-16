
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apnaexam/splash_services.dart';

class SplashPage extends StatefulWidget{

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  var splash_services =SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash_services.isLogin(context);
  }
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(child: Text("Welcome",style: TextStyle(fontSize: 21,color: Colors.blue),)),
    );
  }
}