import 'dart:async';

import 'package:code/Controller/cart_controller.dart';
import 'package:code/Model/product_model.dart';
import 'package:code/Model/user_model.dart';
import 'package:code/Services/firebase_services.dart';
import 'package:code/View/Drawer/my_orders.dart';
import 'package:code/View/pincode_edit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MyCart extends StatefulWidget
{
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {

  final CartController cartController = Get.put(CartController());

  final user = FirebaseAuth.instance.currentUser;

  //RAZORPAY
  Razorpay _razorpay = Razorpay();

  @override
  void initState()
  {
    print("initState");
    cartController.getFromCart();
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("\nSUCCESS : ${response.paymentId!+ "  "+ response.orderId!}\n");
    showToast(response.paymentId!+ "  "+ response.orderId!);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("\n${response.code.toString()+response.message!}\n");
    showToast(response.code.toString()+response.message!);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    print("\n${response.walletName!}\n");
    showToast(response.walletName!);
  }

  _makePayment(String amount)
  {
    var options = {
      'key': 'rzp_test_sUOUwQCEDENAVI',
      'amount': amount, //in the smallest currency sub-unit.
      'name': 'SHOPCART',
      'description': 'E-Shopping from SHOPCART',
    };

    try
    {
      _razorpay.open(options);
      print("\ntry done\n");
    }
    catch(e)
    {
      showToast(e.toString());
      print("\n\n");
      print(e.toString());
    }

  }

  @override
  void dispose()
  {
    super.dispose() ;
    _razorpay.clear(); // Removes all listeners
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor('#ebeff5'),
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

                    FutureBuilder<UserData>(
                        future: FirebaseApi.readUser(),
                        builder: (context,snapshot)
                        {
                          if(snapshot.hasData)
                            {
                              final data= snapshot.data;
                              return Container(
                                width: size.width*0.6,
                                  child: Row(
                                    children: [
                                      Text("Deliver to Pin code : ",overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 15)),
                                      Text("${data?.Address}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))
                                    ],
                                  ),
                              );
                            }
                          else if(snapshot.hasError)
                            {
                              return Center(child: CircularProgressIndicator(color: Colors.red));
                            }
                          return Text("Loading...",style: TextStyle(fontSize: 15));
                        }
                    ),

                    GestureDetector(
                      onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => PincodeEdit())),
                      child: Container(
                        height: size.height*0.04,
                        width: size.width*0.22,
                        decoration: BoxDecoration(
                          color: HexColor("#39b5fd"),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(child: Text("Change",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.white))),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
                child: Obx(() =>
                  ListView.separated(
                    physics: BouncingScrollPhysics(),
                    separatorBuilder: (context, index)=>Container(height: 8),
                    itemCount: cartController.cartItems.length,
                    itemBuilder: (context,index)
                    {
                      return productCard(cartController.cartItems[index],size);
                    },
                  ),
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
                        Text("Total Amount : Rs ",style: TextStyle(fontFamily: 'ProductSans',fontSize: 15)),
                        Text(cartController.price.toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'ProductSans',fontSize: 16)),
                      ],
                    ),
                    Container(
                        height: size.height*0.06,
                        width: size.width*0.49,
                        decoration: BoxDecoration(
                          color: HexColor("#14BDEB"),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: GestureDetector(
                                onTap: (){
                                  _makePayment((cartController.price*100).toString());
                                  cartController.addToOrder();
                                  cartController.deleteToCart();
                                  Timer(Duration(seconds: 3), () {
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                        MyOrders()), (Route<dynamic> route) => false);
                                    });
                                },
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
                      )

                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }

  Widget productCard(ProductModel pModel,Size size) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 5),
        height: size.height * 0.20,
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
                                  pModel.image),
                              fit: BoxFit.contain,
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
                              pModel.title,
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
                            Text(pModel.rating.rate.toString(), style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'ProductSans'))
                          ],
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text("Rs ${pModel.price.toString()}", style: TextStyle(fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'ProductSans')),
                        SizedBox(height: size.height * 0.020),
                        Row(
                          children: [
                            Text(DateFormat('MMM d, yyyy').format(DateTime.now().add(Duration(days: 7)))+" | ", style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
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

void showToast(String text)=>Fluttertoast.showToast(
  msg: text,
  fontSize: 15.0,
  backgroundColor: HexColor("#091945"),
  textColor: Colors.white,
  gravity: ToastGravity.TOP_LEFT,
);

//RED : fe5858
//BLUE : 39b5fd