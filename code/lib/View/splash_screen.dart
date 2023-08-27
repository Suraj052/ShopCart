import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    HomeScreen()
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        backgroundColor: Colors.white,
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/Icons/drawercart.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text("SHOPCART",style: TextStyle(color: Color(0xFF25262d),fontSize: 20,fontFamily: 'Recoleta')),
              ],
          ),
        )
    );
  }
}
