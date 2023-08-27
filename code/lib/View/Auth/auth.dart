
import 'package:code/View/Auth/login.dart';
import 'package:code/View/Auth/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? Login(onClickedSignedUp: toggle)
      : Signup(onClickedSignIn: toggle);
  void toggle() => setState(() => isLogin = !isLogin);
}


