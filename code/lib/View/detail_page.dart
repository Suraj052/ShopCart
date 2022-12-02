import 'package:code/Model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DetailPage extends StatefulWidget {

  final ProductModel pModel;
  const DetailPage({Key? key,required this.pModel}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  late String title;
  late String price;
  late String description;
  late String category;
  late String image;
  late String rating;


  @override
  void initState()
  {
    initState();
    title = widget.pModel.title;
    price = widget.pModel.price.toString();
    description = widget.pModel.description;
    category =  widget.pModel.category;
    image = widget.pModel.image;
    rating = widget.pModel.rating.rate.toString();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: ()=> Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new,color: Colors.black),
        ),
        title: Center(child: Text("Details",style: TextStyle(color: Colors.black),)),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.favorite_border_outlined,color: Colors.black)
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: size.height*0.40,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.network(image),
            ),
          ),
          Row(
            children: [
              Text(title),
              Text(price)
            ],
          ),
          Row(
            children: [
              Icon(Icons.star,color:HexColor("##39b5fd"),size: 18),
              SizedBox(width: size.width*0.01),
              Text(rating,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600))
            ],
          ),
        ],
      ),
    );
  }
}
