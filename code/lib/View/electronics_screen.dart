
import 'package:carousel_slider/carousel_slider.dart';
import 'package:code/Controller/product_controller.dart';
import 'package:code/Model/product_model.dart';
import 'package:code/View/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ElectronicsScreen extends StatefulWidget {
  const ElectronicsScreen({Key? key}) : super(key: key);

  @override
  State<ElectronicsScreen> createState() => _ElectronicsScreenState();
}

List imageLink = [
  "https://images.unsplash.com/photo-1546027658-7aa750153465?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
  "https://images.unsplash.com/photo-1544237526-cae15a57ed1e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1291&q=80",
  "https://images.unsplash.com/photo-1615210230840-69c07c13b4d1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
  "https://images.unsplash.com/photo-1484154218962-a197022b5858?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1174&q=80"
];

class _ElectronicsScreenState extends State<ElectronicsScreen> {

  final ProductController electronicsController = Get.put(ProductController());
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        scrollcard(size),
        SizedBox(height: size.height*0.04),
        Text("Recent Products",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: HexColor("#fe5858"))),
        SizedBox(height: size.height*0.03),
        Expanded(
            child: Obx(() =>
                ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: electronicsController.electronicsList.length,
                itemBuilder: (BuildContext context, int index)
                {
                  return GestureDetector(
                      child: productCard(electronicsController.electronicsList[index],size),
                      onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context) => DetailPage(pModel: electronicsController.electronicsList[index])),
                  ));
                }, separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: size.height*0.015);
                },
              ),
            ),
        )
      ],
    );
  }

  Widget scrollcard(Size size)
  {
    return Center(
      child: Container(
        width: size.width*0.9,
          height: size.height*0.25,
          child:
          CarouselSlider.builder(
            itemCount: imageLink.length,
            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                Container(
                  child: cardimage(imageLink[itemIndex]),
                ), 
                options: CarouselOptions(
                    height: 400,
                    aspectRatio: 16/9,
                    viewportFraction: 0.99,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                ),
          ),
      ),
    );
  }



  Widget cardimage(String link)
  {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(link),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget productCard(ProductModel electronicsModel,Size size)
  {
    return Center(
      child: Container(
        height: size.height*0.2,
        width: size.width*0.9,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.25),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: Row(
            children: [
              Container(
                height: size.height*0.25,
                width: size.width*0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.network(electronicsModel.image),
                ),
              ),
              SizedBox(width: size.width*0.05),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width : size.width*0.32,
                      child: Text(
                          electronicsModel.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16,fontFamily: 'ProductSans',fontWeight: FontWeight.w500,color: Colors.black54)
                      ),
                    ),
                    //SizedBox(height: size.height*0.01),
                    Row(
                      children: [
                        Icon(Icons.star,color:HexColor("##39b5fd"),size: 18),
                        SizedBox(width: size.width*0.01),
                        Text(electronicsModel.rating.rate.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600))
                      ],
                    ),
                    //SizedBox(height: size.height*0.06),
                    Text('\Rs ' + electronicsModel.price.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
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

