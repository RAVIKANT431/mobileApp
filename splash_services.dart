

import 'dart:async';
import 'package:apnaexam/forgetpasswordPage.dart';
import 'package:apnaexam/homePage.dart';
import 'package:apnaexam/loginPage.dart';
// import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices{
  void isLogin(BuildContext context){
    final auth =FirebaseAuth.instance;
    final user =auth.currentUser;

    if (user!=null){
      Timer(const Duration(seconds: 2),
              ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StartPage(),)));
    } else{
      Timer(const Duration(seconds: 2),
      ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),)));
    }
  }
  void home_navigator(context){
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => StartPage(),));//HomePage
  }
  void sigin_navigator(context){
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage(),));
  }
  // void forget_navigator(context){
  //   Navigator.push(context,MaterialPageRoute(builder: (context) => ForgetpasswordPage(),));
  // }
}
