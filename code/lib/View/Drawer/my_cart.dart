import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyCart extends StatefulWidget
{
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor('#ebeff5'),
      appBar: AppBar(
        backgroundColor: HexColor("#fe5858"),
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: HexColor("#fe5858")),
        leading: IconButton(
            onPressed: ()=> Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 20,)
        ),
        title: Text("My Cart",style: TextStyle(fontSize: 18,color: Colors.white)),
      ),
      body: Column(
          children: [
            Container(
              height: size.height*0.07,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text("Deliver to: ",style: TextStyle(fontSize: 15)),
                          Text("Bhubaneswar-751001",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Container(
                      height: size.height*0.04,
                      width: size.width*0.22,
                      decoration: BoxDecoration(
                        color: HexColor("#39b5fd"),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(child: Text("Change",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.white))),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
                child: ListView(
                  children: [
                    productCard(size),
                    productCard(size),
                    productCard(size),
                    productCard(size),
                  ],
                )
            ),
            Container(
              width: size.width,
              height: size.height*0.08 ,
              decoration: BoxDecoration(
                  color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text("Total Amount : ",style: TextStyle(fontFamily: 'ProductSans',fontSize: 15)),
                        Text("\$ 100",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'ProductSans',fontSize: 16)),
                      ],
                    ),
                    Container(
                      height: size.height*0.06,
                      width: size.width*0.49,
                      decoration: BoxDecoration(
                        color: HexColor("#14BDEB"),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          "Place Order Now",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: HexColor("#25262d"),
                            fontFamily:'ProductSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
    );
  }

  Widget productCard(Size size) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 5),
        height: size.height * 0.26,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: size.height * 0.15,
                          width: size.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.unsplash.com/photo-1630080644615-0b157f1574ec?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          width: size.width*0.40,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                FloatingActionButton.small(
                                  child: Icon(Icons.add, color: Colors.black87,size: 20),
                                  backgroundColor: Colors.white,
                                  onPressed: () {},
                                ),
                                Text(
                                  '10',
                                  style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold,color: HexColor("#fe5858")),
                                ),
                                FloatingActionButton.small(
                                  child: Icon(Icons.remove, color: Colors.black87,size: 20),
                                  backgroundColor: Colors.white,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: size.width * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width * 0.45,
                          child: Text(
                              "WD 4TB Gaming Drive Works with Playstation 4 Portable External Hard Drive",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14,
                                  fontFamily: 'ProductSans',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54)
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Row(
                          children: [
                            Icon(Icons.star, color: HexColor("##39b5fd"), size: 18),
                            SizedBox(width: size.width * 0.01),
                            Text("4.9", style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'ProductSans'))
                          ],
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text("\$ 3999", style: TextStyle(fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'ProductSans')),
                        SizedBox(height: size.height * 0.020),
                        Row(
                          children: [
                            Text("Delivery by Dec 10 | ", style: TextStyle(
                                fontSize: 12,
                                color: Colors.black38,
                                fontFamily: 'ProductSans')),
                            Text("FREE Delivery", style: TextStyle(fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontFamily: 'ProductSans')),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
      ),
    );
  }
}

//RED : fe5858
//BLUE : 39b5fd