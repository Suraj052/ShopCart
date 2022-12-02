import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: HexColor("#fe5858"),
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: HexColor("#fe5858")),
        leading: IconButton(
            onPressed: ()=> Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 20,)
        ),
        title: Text("My Orders",style: TextStyle(fontSize: 18,color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          child: ListView
            (
            children: [
              productCard(size),
              productCard(size),
              productCard(size),
              productCard(size),
            ],
          ),
        ),
      ),
    );
  }
  Widget productCard(Size size)
  {
    return Center(
      child: Column(
        children: [
          Container(
            height: size.height*0.14,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height*0.10,
                    width: size.width*0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage("https://images.unsplash.com/photo-1630080644615-0b157f1574ec?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: size.width*0.1),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width : size.width*0.50,
                          child: Text(
                              "Delivered on Nov 16,2021",
                              style: TextStyle(fontSize: 15,fontFamily: 'ProductSans',fontWeight: FontWeight.w500,color: Colors.black)
                          ),
                        ),
                        SizedBox(height: size.height*0.01),
                        Container(
                          width : size.width*0.55,
                          child: Text(
                              "WD 4TB Gaming Drive Works with Playstation 4 Portable External Hard Drive",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 15,fontFamily: 'ProductSans',color: Colors.grey)
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          Divider(thickness: 1)
        ],
      ),
    );
  }
  
}

//RED : fe5858
//BLUE : 39b5fd