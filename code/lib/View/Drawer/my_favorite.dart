import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyFavorite extends StatefulWidget
{
  const MyFavorite({Key? key}) : super(key: key);

  @override
  State<MyFavorite> createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> {
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
        title: Text("My Favorites",style: TextStyle(fontSize: 18,color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            productCard(size)
          ],
        ),
      )
    );
  }

  Widget productCard(Size size)
  {
    return Center(
      child: Container(
        height: size.height*0.2,
        width: size.width*0.95,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Container(
                height: size.height*0.25,
                width: size.width*0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54.withOpacity(0.2),
                      offset: const Offset(
                        3.0,
                        3.0,
                      ),
                      blurRadius:8.0,
                      spreadRadius: 0.0,
                    )
                  ],
                  image: DecorationImage(
                    image: NetworkImage("https://images.unsplash.com/photo-1630080644615-0b157f1574ec?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: size.width*0.05),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width : size.width*0.40,
                      child: Text(
                          "WD 4TB Gaming Drive Works with Playstation 4 Portable External Hard Drive",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16,fontFamily: 'ProductSans',fontWeight: FontWeight.w500,color: Colors.black54)
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star,color:HexColor("##39b5fd"),size: 18),
                        SizedBox(width: size.width*0.01),
                        Text("4.9",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("\$ 3999",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//RED : fe5858
//BLUE : 39b5fd