import 'package:apnaexam/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VarifyPage extends StatefulWidget{
  final String verificationId;
  VarifyPage({super.key,required this.verificationId});

  @override
  State<VarifyPage> createState() => _VarifyPageState();
}

class _VarifyPageState extends State<VarifyPage> {
  var error_message="";
  var varify_controller = TextEditingController();
  final auth =FirebaseAuth.instance;
  bool isLoading=false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title:Text("Varify code"),centerTitle: true),
      body:Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                showCursor: true,
                keyboardType: TextInputType.phone,
                controller: varify_controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Colors.black87,
                            width: 2
                        )
                    ),
                    prefixIcon: Icon(Icons.code),
                    labelText: "Varification Code"
                ),),

              SizedBox(height: 80,
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
                    setState(() {
                      isLoading=true;
                    });
                      final mycredential=PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: varify_controller.text);
                      // print("token : ${mycredential}");
                      try{
                        await auth.signInWithCredential(mycredential);
                        // print(auth.currentUser);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => StartPage(),));
                      } on FirebaseAuthException catch(e){
                        setState(() {
                          isLoading=false;
                          print("e$e");
                          print("em${e.message}");
                          error_message=(e.message).toString();
                        });
                      }
                  },

                  child: isLoading? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Loading..."),
                      SizedBox(width: 10,),
                      CircularProgressIndicator(color: Colors.white,
                      ),
                    ],
                  ):Text("Varify",style: TextStyle(fontSize: 20),)
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}