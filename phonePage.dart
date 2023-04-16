import 'package:apnaexam/varifyPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhonePage extends StatefulWidget{

  PhonePage({super.key});

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  var error_message="";
  var countryCode="+91";

  final auth =FirebaseAuth.instance;

  var phone_controller = TextEditingController();//text: "+91");
  bool isLoading=false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title:Text("Login with phone"),centerTitle: true),
      body:Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                showCursor: true,
                keyboardType: TextInputType.phone,
                controller: phone_controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Colors.black87,
                            width: 2
                        )
                    ),
                    prefixText: "+91",

                    prefixIcon: Icon(Icons.phone),
                    labelText: "Phone No"
                ),),

              SizedBox(height: 60,
                  child:Center(child: Text(error_message,style: TextStyle(fontSize: 18,color: Colors.redAccent),))
              ),


              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)
                ),
                child: ElevatedButton(
                  onPressed: () async{
                    setState(() {isLoading=true; });
                    print(phone_controller.text);
                    if(phone_controller.text.length!=10){
                      error_message="Enter a valid phone no";
                      setState(() {isLoading=false;
                      });
                      return null;
                    }
                    setState(() {
                      error_message="";
                    });
                    await auth.verifyPhoneNumber(
                      phoneNumber: countryCode+phone_controller.text,
                        verificationCompleted: (_){},
                        verificationFailed: (e){
                        error_message=e.message!;
                        setState(() {isLoading=false;});
                        },
                        codeSent: (String verificationId, int? token){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VarifyPage(verificationId:verificationId,),));
                        },
                        codeAutoRetrievalTimeout: (e){
                          // error_message=e;
                          setState(() {isLoading=false;});
                        });
                  },
                  child: isLoading? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Loading..."),
                      CircularProgressIndicator(color: Colors.white,
                      ),
                    ],
                  ): Text("Login",style: TextStyle(fontSize: 20),),
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}