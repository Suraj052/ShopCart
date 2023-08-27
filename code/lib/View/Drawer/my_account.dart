import 'dart:async';

import 'package:code/Model/user_model.dart';
import 'package:code/Services/firebase_services.dart';
import 'package:code/View/Drawer/my_cart.dart';
import 'package:code/View/Drawer/my_favorite.dart';
import 'package:code/View/Drawer/my_orders.dart';
import 'package:code/View/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        title: Text("My Account",style: TextStyle(fontSize: 18,color: Colors.white)),
      ),
      body: Center(
        child: Container(
          height: size.height*0.75,
          width: size.width*0.9,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            elevation: 25,
            shadowColor: HexColor("#39b5fd"),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 40, 10, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureBuilder<UserData>(
                      future: FirebaseApi.readUser(),
                      builder: (context,snapshot)
                      {
                        if(snapshot.hasData)
                          {
                            final data = snapshot.data;
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    FirebaseApi.updatePhoto();
                                    Timer(Duration(seconds: 3),()=>Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                        HomeScreen()), (Route<dynamic> route) => false) );
                                    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                    //     HomeScreen()), (Route<dynamic> route) => false);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: HexColor("#fe5858"),
                                    radius: size.width*0.17,
                                    child: CircleAvatar(
                                      radius: size.width*0.16,
                                      backgroundImage:  data?.PhotoUrl == null? AssetImage("assets/Icons/avatar.png") : NetworkImage(data!.PhotoUrl) as ImageProvider,
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height*0.02),
                                Text(data!.Name,style: TextStyle(letterSpacing:0.5,fontFamily: 'ProductSans',fontSize: 18,color: HexColor("#25262d"),fontWeight: FontWeight.bold)),
                                SizedBox(height: size.height*0.005),
                                Text(data.Email,style: TextStyle(letterSpacing:0.5,fontFamily: 'ProductSans',fontSize: 16,color: HexColor("#25262d"))),
                                SizedBox(height: size.height*0.005),
                                Text('+91 ${data.Mobile}',style: TextStyle(letterSpacing:0.5,fontFamily: 'ProductSans',fontSize: 16,color: Colors.blueAccent)),
                                SizedBox(height: size.height*0.02),
                              ],
                            );
                          }
                        else if(snapshot.hasError)
                          {
                            return Center(child: CircularProgressIndicator(color: Colors.red));
                          }
                        return Center(child:Text("Loading...",style: TextStyle(letterSpacing:0.5,fontFamily: 'ProductSans',fontSize: 16,color: HexColor("#25262d"))) );
                      }
                  ),
                  Divider(thickness: 2,color: Colors.grey.withOpacity(0.2)),
                  SizedBox(height: size.height*0.04),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,0, 5, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("My Orders",style: TextStyle(letterSpacing:0.2,fontFamily: 'ProductSans',fontSize: 16,color: Colors.grey,fontWeight: FontWeight.bold)),
                            IconButton(
                                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrders())),
                                icon: Icon(Icons.arrow_forward_ios_outlined,size: 20,color: Colors.grey)
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("My Favorities",style: TextStyle(letterSpacing:0.2,fontFamily: 'ProductSans',fontSize: 16,color: Colors.grey,fontWeight: FontWeight.bold)),
                            IconButton(
                                onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => MyFavorite())),
                                icon: Icon(Icons.arrow_forward_ios_outlined,size: 20,color: Colors.grey)
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("My Cart",style: TextStyle(letterSpacing:0.2,fontFamily: 'ProductSans',fontSize: 16,color: Colors.grey,fontWeight: FontWeight.bold)),
                            IconButton(
                                onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => MyCart())),
                                icon: Icon(Icons.arrow_forward_ios_outlined,size: 20,color: Colors.grey)
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height*0.06),
                  Text("Terms and Conditions",style: TextStyle(fontFamily: 'ProductSans',fontSize: 17,color: Colors.blueAccent)),
                  Text("Hope Developers Pvt. Ltd.",style: TextStyle(fontFamily: 'ProductSans',fontSize: 12,color: Colors.black54)),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}


//RED : fe5858
//BLUE : 39b5fd