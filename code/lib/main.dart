import 'package:code/View/Auth/auth.dart';
import 'package:code/View/homepage.dart';
import 'package:code/View/splash_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Services/firebase_services.dart';


final navigatorKey = GlobalKey<NavigatorState>();

void main() async
{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  runApp(
      GetMaterialApp(
          navigatorKey: navigatorKey,
          home: MyApp(),
          debugShowCheckedModeBanner: false,
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream:FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator());
            }
            else if (snapshot.hasError)
            {
              return Center(child: Text('Something went wrong !'));
            }
            if(snapshot.hasData)
            {
              return HomeScreen();
            }
            else
            {
              return Auth();
            }
          }
      ),
    );
  }
}
