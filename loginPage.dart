
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:apnaexam/forgetpasswordPage.dart';
// import 'package:apnaexam/homePage.dart';
import 'package:apnaexam/signupPage.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:apnaexam/splash_services.dart';
import 'package:apnaexam/phonePage.dart';
// import 'package:flutter_basics/shared_prefrefered_data.dart';
// import 'package:flutter_basics/main.dart';

class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // static var mailText="";
  var mailText="";
  final _formKey = GlobalKey<FormState>();
  final emailText = TextEditingController();
  final passText = TextEditingController();
  var error_message="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValues();// it wirtten in shared preferfed dat code

    // emailText.text=mailText;
    // print("emm : ${emailText.text}");
  }
  var services=SplashServices();

  Future SignIn() async{
    try {
      setState(() {
        isLoading=true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailText.text, password: passText.text);
      var pref =await SharedPreferences.getInstance();
      pref.setString("mailText",emailText.text );
      services.home_navigator(context);

    } on FirebaseAuthException catch (e){
      setState(() {
        isLoading=false;
        error_message=e.message!;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();  // release memory in case of screen of
    emailText.dispose();
    passText.dispose();
  }
  bool isLoading=false;
  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
            title:Text("Login here"),centerTitle: true),
        body: Center(
          child: Container(
            width: 300,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey,
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
                    TextFormField(
                      showCursor: true,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailText,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter email";
                        } else {return null;}
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Colors.black87,
                                  width: 2
                              )
                          ),
                          prefixIcon: Icon(Icons.email),
                          labelText: "Email id",

                      ),),
                    SizedBox(height: 20,),
                    TextFormField(//password
                      showCursor: true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: passText,
                      obscureText: true,
                      obscuringCharacter: "*",
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter password";
                        } else {return null;}
                      },
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
                    InkWell(
                        onTap: () {

                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => ForgetpasswordPage(),));

                        },
                        child: Text("Forget Password",style: TextStyle(color: Colors.blue),)
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: ElevatedButton(

                        onPressed:(){
                          if (_formKey.currentState!.validate()){
                            SignIn();
                                 };
                          },
                        child:isLoading? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Loading..."),
                            SizedBox(width: 10,),
                            CircularProgressIndicator(color: Colors.white,
                            ),
                          ],
                        ): Text("Login",style: TextStyle(fontSize: 20),),
                      ),
                    ),
                    SizedBox(height: 40,),

                    Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)
                      ),
                      child: ElevatedButton(

                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PhonePage(),));
                        },
                        child: Text("Login with Phone",style: TextStyle(fontSize: 20),),
                      ),
                    ),

                    SizedBox(height: 50,
                    child: Center(child: Text(error_message!,style: TextStyle(fontSize: 15,color: Colors.redAccent),)),),
                    InkWell(
                        onTap: (){
                          print("New User? Create Account");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage(),));
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage(),));
                        },
                        child: SizedBox(
                            height: 30,
                            child: Center(child: Text("New User? Create Account",style: TextStyle(color: Colors.green),)))
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

      ),
    );

  }

  void getValues() async {
    var pref = await SharedPreferences
        .getInstance(); //SharePreferences.getInstance():
    var getmailText = pref.getString("mailText");
    // print("getmailText :$getmailText");
    mailText = getmailText != null ? mailText : "";
    print("getmailText :$getmailText");
    emailText.text=getmailText!;
    // var pref =
  }
}