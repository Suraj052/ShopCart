import 'package:code/Controller/cart_controller.dart';
import 'package:code/Model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  final CartController orderController = Get.put(CartController());

  @override
  void initState()
  {
    print("initState");
    orderController.getFromOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
        title: Text("My Orders",style: TextStyle(fontSize: 18,color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Expanded(
                child: Obx(() =>
                    ListView.separated(
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, index)=>Container(height: 8),
                      itemCount: orderController.orderItems.length,
                      itemBuilder: (context,index)
                      {
                        return productCard(orderController.orderItems[index],size);
                      },
                    ),
                )
            ),
          ],
        ),
      ),
    );
  }
  Widget productCard(ProductModel productModel,Size size)
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
                    padding: EdgeInsets.all(10),
                    height: size.height*0.10,
                    width: size.width*0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),

                      image: DecorationImage(
                        image: NetworkImage(productModel.image),
                        fit: BoxFit.contain,
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
                              "Delivery by "+ DateFormat('MMM d, yyyy').format(DateTime.now().add(Duration(days: 7))),
                              style: TextStyle(fontSize: 15,fontFamily: 'ProductSans',fontWeight: FontWeight.w500,color: Colors.black)
                          ),
                        ),
                        SizedBox(height: size.height*0.01),
                        Container(
                          width : size.width*0.55,
                          child: Text(
                              productModel.title,
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