import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor("#fe5858"),
            statusBarIconBrightness: Brightness.light),
        backgroundColor: HexColor("#fe5858"),
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: HexColor("#fe5858")),
        leading: IconButton(
            onPressed: ()=> Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 20,)
        ),
        title: Text("Notifications",style: TextStyle(fontSize: 18,color: Colors.white)),
      ),
      body: Center(
        child: Text("Notifications"),
      ),
    );
  }
}
