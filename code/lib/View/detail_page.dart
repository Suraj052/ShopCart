import 'package:code/Controller/cart_controller.dart';
import 'package:code/Controller/favorite_controller.dart';
import 'package:code/Model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class DetailPage extends StatefulWidget {

  final ProductModel pModel;
  const DetailPage({Key? key,required this.pModel}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  final CartController cartController = Get.put(CartController());
  final FavoriteController favoriteController = Get.put(FavoriteController());
  bool active = true;
  bool fav = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: ()=> Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new,color: Colors.black),
        ),
        title: Center(child: Text("Product Details",style: TextStyle(color: Colors.black),)),
        actions: [
          IconButton(
              onPressed: fav ?(){
                FavoriteController.addToFavorite(widget.pModel);
                setState(() {
                  fav=false;
                });
                showToast("Added to favorite");
              }:null,
              icon: fav? Icon(Icons.favorite_border_outlined,color: Colors.black) : Icon(Icons.favorite,color: Colors.red)
          )
        ],
      ),
      body: Column(
        children:[
          Expanded(
              child: ListView(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              children: [
                Container(
                  height: size.height*0.40,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.3)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(widget.pModel.image),
                  ),
                ),
                SizedBox(height: size.height*0.02),
                Text(widget.pModel.title,style: TextStyle(fontFamily: 'ProductSans',fontSize: 20,
                    color: HexColor("#25262d"),fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                Container(
                  width: 20,
                  height: size.height*0.05,
                  decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(6),
                      color: HexColor("#091945")
                  ),
                  child: Center(
                    child: Text(
                        "Rating ${widget.pModel.rating.rate}",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'ProductSans',
                            color: Colors.white
                        )
                    ),
                  ),
                ),
                SizedBox(height: size.height*0.02),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset("assets/Icons/people.png",width: size.width*0.2),
                    SizedBox(width: size.width*0.05),
                    Text("Reviews  ${widget.pModel.rating.count.toString()}",style: TextStyle(fontFamily: 'ProductSans',fontSize: 18,color: HexColor("#25262d"),fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: size.height*0.02),
                Text(widget.pModel.description,style: TextStyle(fontFamily: 'ProductSans',fontSize: 15,color: Colors.grey),textAlign: TextAlign.justify,),
                SizedBox(height: 15),

              ],
            ),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: size.height*0.06,
                    width: size.width*0.45,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2,color: HexColor("#40cde8")),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: Text(
                        "Rs  ${widget.pModel.price}",
                        style: TextStyle(
                          fontSize: 19.0,
                          color: HexColor("#25262d"),
                          fontFamily:'ProductSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: active ?(){
                      CartController.addToCart(widget.pModel);
                      setState(() {
                        active =  false;
                      });
                      showToast("Added to cart");
                    }:null,
                    child: active ?Container(
                      height: size.height*0.06,
                      width: size.width*0.45,
                      decoration: BoxDecoration(
                        color: HexColor("#14BDEB"),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          "Add to cart",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: HexColor("#25262d"),
                            fontFamily:'ProductSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ):
                    Container(
                      height: size.height*0.06,
                      width: size.width*0.45,
                      decoration: BoxDecoration(
                        color: HexColor("#14BDEB").withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          "Added to cart",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: HexColor("#25262d").withOpacity(0.3),
                            fontFamily:'ProductSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}
void showToast(String s)=>Fluttertoast.showToast(
  msg: s,
  fontSize: 15.0,
  backgroundColor: HexColor("#091945"),
  textColor: Colors.white,
  gravity: ToastGravity.TOP_LEFT,
);
