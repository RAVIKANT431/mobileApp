


// import 'dart:html';

// import 'package:flutter/cupertino.dart';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:apnaexam/signupPage.dart';
// import 'package:flutter_basics/main.dart';

class ForgetpasswordPage extends StatefulWidget {
  // var mailFrom;
  // const ForgetpasswordPage({key ? key ,required this.mailFrom}):super(key:key);
  // const ForgetpasswordPage(required this.mailFrom);

  @override
  State<ForgetpasswordPage> createState() => _ForgetpasswordPageState();
}

class _ForgetpasswordPageState extends State<ForgetpasswordPage> {
  var emailText = TextEditingController();
  var error_message="";
  Color cl = Colors.redAccent;
  var passText = TextEditingController();

  Future ResetPass() async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailText.text);
      setState(() {
        error_message="Reset Link sent on your email id";
        cl = Colors.green;
      });

    } on FirebaseAuthException catch (e){
      setState(() {
        error_message=e.message!;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    // emailText.text=widget.mailFrom;
    return Scaffold(
      appBar: AppBar(
          title:Text("Reset Password"),centerTitle: true),
      body: Center(
        child: Container(
          width: 300,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset("assets/images/study.jpeg"),
                CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.greenAccent,
                    child: Center(child: Icon(Icons.person,size: 70,))),
                // Text("Login",style: TextStyle(fontSize: 21,fontWeight: FontWeight.w400),),
                SizedBox(height: 20,),
                TextField(
                  showCursor: true,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailText,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.black87,
                              width: 2
                          )
                      ),
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email id"
                  ),),
                // SizedBox(height: 20,),
                // TextField(//password
                //   showCursor: true,
                //   keyboardType: TextInputType.visiblePassword,
                //   controller: passText,
                //   obscureText: true,
                //   obscuringCharacter: "*",
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(20),
                //           borderSide: BorderSide(
                //               color: Colors.black87,
                //               width: 2
                //           )
                //       ),
                //       // prefixIcon: Icon(Icons.pattern_rounded),
                //       labelText: "Password"
                //
                //   ),),
                SizedBox(height: 20,),
                // InkWell(
                //     onTap: (){
                //       print("login in rest pass fun click");
                //     },
                //     child: Text("Login",style: TextStyle(color: Colors.blue),)
                // ),
                SizedBox(height: 20,),
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: ElevatedButton(
                    onPressed: ResetPass,
                    child: Text("Send Reset password link",style: TextStyle(fontSize: 20),),
                  ),
                ),
                SizedBox(height: 50,
                  child: Center(child: Text(error_message,style: TextStyle(fontSize: 15,color: cl),)),),

                // InkWell(
                //     onTap: (){
                //       print("New User? Create Account");
                //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupPage(),));
                //       // Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage(),));
                //     },
                //     child: SizedBox(
                //         height: 30,
                //         child: Center(child: Text("New User? Create Account",style: TextStyle(color: Colors.green),)))
                // ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}