import 'package:code/View/Auth/auth.dart';
import 'package:code/View/detail_page.dart';
import 'package:code/View/homepage.dart';
import 'package:flutter/material.dart';


final navigatorKey = GlobalKey<NavigatorState>();
void main()
{
  runApp(MaterialApp(
    navigatorKey: navigatorKey,
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailPage();
  }
}
