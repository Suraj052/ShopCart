import 'package:code/Controller/favorite_controller.dart';
import 'package:code/Model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class MyFavorite extends StatefulWidget
{
  const MyFavorite({Key? key}) : super(key: key);

  @override
  State<MyFavorite> createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> {

  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  void initState()
  {
    print("initstate fav");
    favoriteController.getFromFavorite();
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
        title: Text("My Favorites",style: TextStyle(fontSize: 18,color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                  child: Obx(() =>
                      ListView.separated(
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (context, index)=>Container(height: 8),
                        itemCount: favoriteController.favoriteItems.length,
                        itemBuilder: (context,index)
                        {
                          return productCard(favoriteController.favoriteItems[index],size);
                        },
                      ),
                  )

              ),
          ],
        ),
      ),
    );
  }

  Widget productCard(ProductModel pModel,Size size)
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
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: size.height*0.18,
                width: size.width*0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),

                  image: DecorationImage(
                    image: NetworkImage(pModel.image),
                    fit: BoxFit.contain,
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
                          pModel.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16,fontFamily: 'ProductSans',fontWeight: FontWeight.w500,color: Colors.black54)
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star,color:HexColor("##39b5fd"),size: 18),
                        SizedBox(width: size.width*0.01),
                        Text(pModel.rating.rate.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600))
                      ],
                    ),
                    Container(
                      width: size.width*0.40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Rs ${pModel.price.toString()}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                          IconButton(
                            onPressed: ()=>favoriteController.deleteFromFavorite(pModel),
                            icon:Icon(Icons.favorite,color: Colors.red))
                        ],
                      ),
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