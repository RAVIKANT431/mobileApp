

// import 'dart:html';

// import 'package:flutter/cupertino.dart';
import 'dart:ffi';

import 'package:apnaexam/homePage.dart';
import 'package:flutter/material.dart';
import 'package:apnaexam/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


// import 'package:flutter_basics/main.dart';

class SignupPage extends StatefulWidget{
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var emailText = TextEditingController();
  var passText = TextEditingController();
  var repassText = TextEditingController();
  var error_message ="";


  Future SignUp() async{
    setState(() {
      isLoading=true;
    });
    if (passText.text!=repassText.text){
      error_message="both password not same";
      setState(() {
        isLoading=false;

      });
      return null;
    }
    try {
      setState(() {
        isLoading=true;
      });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailText.text, password: passText.text);
      var pref =await SharedPreferences.getInstance();
      pref.setString("mailText",emailText.text );
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
    } on FirebaseAuthException catch (e){
      setState(() {
        isLoading=false;
        error_message=e.message!;
      });
    }
  }

  bool isLoading=false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false, //leading button back
          title:Text("SignUp Page"),centerTitle: true),
      body: Center(
        child: Container(
          width: 300,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(radius: 40,
                    backgroundColor: Colors.greenAccent,
                    child: Icon(Icons.person,size: 70,)),
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
                SizedBox(height: 20,),
                TextField(//password
                  showCursor: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passText,
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.black87,
                              width: 2
                          )
                      ),
                      // prefixIcon: Icon(Icons.pattern_rounded),
                      labelText: "Password"

                  ),),
                SizedBox(height: 20,),
                TextField(//re enter password
                  showCursor: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: repassText,
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.black87,
                              width: 2
                          )
                      ),
                      // prefixIcon: Icon(Icons.pattern_rounded),
                      labelText: "Re-enter Password"

                  ),),
                SizedBox(height: 20,),


                // InkWell(
                //     onTap: (){
                //       print("forget pass fun click");
                //     },
                //     child: Text("Forget Password",style: TextStyle(color: Colors.blue),)
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
                    onPressed: SignUp,
                    child: isLoading? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Loading..."),
                        CircularProgressIndicator(color: Colors.white,
                        ),
                      ],
                    ) :Text("SignUp",style: TextStyle(fontSize: 20),),
                  ),
                ),
                SizedBox(height: 40,
                  child: Center(child: Text(error_message!,style: TextStyle(fontSize: 15,color: Colors.redAccent),)),),

                InkWell(
                    onTap: (){
                      print("Already User? just Login");
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                    },
                    child: SizedBox(
                        height: 30,
                        child: Center(child: Text("Already User? just Login",style: TextStyle(color: Colors.green),)))
                ),
                SizedBox(height: 10,),






              ],
            ),
          ),
        ),
      ),

    );
  }
}