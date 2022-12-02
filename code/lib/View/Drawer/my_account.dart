import 'package:code/View/Drawer/my_cart.dart';
import 'package:code/View/Drawer/my_favorite.dart';
import 'package:code/View/Drawer/my_orders.dart';
import 'package:flutter/material.dart';
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
          height: size.height*0.7,
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
                  CircleAvatar(
                    backgroundColor: HexColor("#fe5858"),
                    radius: size.width*0.17,
                    child: CircleAvatar(
                      radius: size.width*0.16,
                      backgroundImage:  NetworkImage("https://images.pexels.com/photos/1009904/pexels-photo-1009904.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                    ),
                  ),
                  SizedBox(height: size.height*0.02),
                  Text("Sierra Mike",style: TextStyle(letterSpacing:0.5,fontFamily: 'ProductSans',fontSize: 18,color: HexColor("#25262d"),fontWeight: FontWeight.bold)),
                  SizedBox(height: size.height*0.005),
                  Text("sierramike04@gmail.com",style: TextStyle(letterSpacing:0.5,fontFamily: 'ProductSans',fontSize: 18,color: HexColor("#25262d"))),
                  SizedBox(height: size.height*0.02),
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