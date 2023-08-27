// ignore_for_file: deprecated_member_use


import 'package:code/View/Auth/Forgot.dart';
import 'package:code/View/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../main.dart';

class Login extends StatefulWidget {

  final VoidCallback onClickedSignedUp;
  const Login({Key? key,required this.onClickedSignedUp}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(28.0, 80.0, 0.0, 0.0),
                  child: Text(
                    "Hello Again ! \nWelcome \nback",
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Recoleta',
                        color: HexColor('#39b5fd')
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: EdgeInsets.fromLTRB(28.0, 15.0, 0.0, 15.0),
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Icon(
                      Icons.how_to_reg_rounded,
                      color: HexColor("#39b5fd"),
                      size: 70,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Padding(
                    padding: const EdgeInsets.fromLTRB(22.0,0.0, 22.0,0.0),
                    child:Container(
                      height: size.height*0.06,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5.0,
                            offset: Offset(0.0,2.0),
                          )]
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email Id',
                          ),
                        ),
                      ),
                    )
                ),
                SizedBox(height: 20.0),
                Padding(
                    padding: const EdgeInsets.fromLTRB(22.0,0.0, 22.0,0.0),
                    child:Container(
                      height: size.height*0.06,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5.0,
                            offset: Offset(0.0,2.0),
                          )]
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                          ),
                        ),
                      ),
                    )
                ),
                SizedBox(height: 25),
                Padding(
                  padding: EdgeInsets.fromLTRB(22.0,0.0, 22.0,0.0),
                  child: Container(
                    height: size.height*0.070,
                    width: size.width*0.9,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#fe5858"),
                      ),
                      onPressed: () => signin(),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text('Sign In',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Forgot())),
                        child:Text('Forgot Password',
                          style: TextStyle(
                              color: HexColor("#39b5fd"),
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0
                          ),
                        )
                    )
                  ],
                ),
                const SizedBox(height: 25),
                Center(
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black45, fontSize: 18.0),
                        text: "Don't have account? ",
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignedUp,
                            text: 'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: HexColor("#39b5fd"),
                              fontSize: 17.0,
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

  Future signin() async {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.white))),
    );


    try
    {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );

    }on FirebaseAuthException catch (e)
    {
      print(e.toString());
      showToast();


    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst
    );

  }

}

void showToast()=>Fluttertoast.showToast(
  msg: 'Invalid Email Id or Password',
  fontSize: 13.0,
  backgroundColor: HexColor("#091945"),
  textColor: Colors.white,
  gravity: ToastGravity.BOTTOM,
);

//RED : fe5858
//BLUE : 39b5fd