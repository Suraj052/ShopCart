// ignore_for_file: deprecated_member_use


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../main.dart';

class Signup extends StatefulWidget {


  final VoidCallback onClickedSignIn;

  const Signup({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final nameController = TextEditingController();
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
      backgroundColor: HexColor('#ebeff5'),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(28.0, 60.0, 0.0, 0.0),
                  child: Text(
                    "Hello ! \nSignup to \nget started",
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Recoleta',
                        color: HexColor('#091945')
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
                      Icons.admin_panel_settings_rounded,
                      color: HexColor("#091945"),
                      size: 70,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
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
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Name',
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
                            hintText: 'New Password',
                          ),
                        ),
                      ),
                    )
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22.0,0.0, 22.0,0.0),
                  child: Container(
                    height: size.height*0.070,
                    width: size.width*0.9,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#091945"),
                      ),
                      onPressed: signup,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: new BorderRadius.circular(10)
                      // ),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text('Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),
                Center(
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black45, fontSize: 18.0),
                        text: 'Already have account? ',
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onClickedSignIn,
                            text: 'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: HexColor("#091945"),
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
  Future signup() async {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.white))),
    );

    try
    {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );
      var user = FirebaseAuth.instance.currentUser!;
      user.updateDisplayName(nameController.text.trim());
    }on FirebaseAuthException catch (e)
    {
      print(e);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
