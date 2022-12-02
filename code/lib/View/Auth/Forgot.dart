import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {

  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor('#ebeff5'),
      body: SingleChildScrollView(
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(28.0, 80.0, 0.0, 0.0),
                  child: Text(
                    "Forgot\nPassword ",
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
                      Icons.question_mark_rounded,
                      color: HexColor("#091945"),
                      size: 70,
                    ),
                  ),
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
                            hintText: 'Enter your email Id',
                          ),
                        ),
                      ),
                    )
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22.0,0.0, 22.0,0.0),
                  child: Container(
                    height: size.height*0.070,
                    width: size.width*0.9,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#091945"),
                      ),
                      onPressed: ()=> forgot(),
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: new BorderRadius.circular(10)
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Reset',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child:Text('Back to Login Page',
                        style: TextStyle(
                            color: HexColor("#091945"),
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                        ),
                      )
                  ),
                )
              ],
            )
        ),
    );
  }
  Future forgot() async
  {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
    showToast();
  }


}


void showToast()=>Fluttertoast.showToast(
  msg: 'Password reset email sent',
  fontSize: 13.0,
  backgroundColor: HexColor("#091945"),
  textColor: Colors.white,
  gravity: ToastGravity.BOTTOM,
);

