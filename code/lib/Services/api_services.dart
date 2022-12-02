import 'package:code/Model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class ApiServices
{

  static var client = http.Client();

  static Future<List<ProductModel>?> fetchElectronics() async
  {
    var response = await
    client.get(Uri.parse('https://fakestoreapi.com/products/category/electronics'));

    if(response.statusCode == 200)
    {
      var jsonString = response.body;
      return electronicsModelFromJson(jsonString);
    }
    else
    {
      return null;
    }
  }

  static Future<List<ProductModel>?> fetchJewelery() async
  {
    var response = await
    client.get(Uri.parse('https://fakestoreapi.com/products/category/jewelery'));

    if(response.statusCode == 200)
    {
      var jsonString = response.body;
      return electronicsModelFromJson(jsonString);
    }
    else
    {
      return null;
    }
  }

  static Future<List<ProductModel>?> fetchMen() async
  {
    var response = await
    client.get(Uri.parse("https://fakestoreapi.com/products/category/men's%20clothing"));

    if(response.statusCode == 200)
    {
      var jsonString = response.body;
      return electronicsModelFromJson(jsonString);
    }
    else
    {
      return null;
    }
  }

  static Future<List<ProductModel>?> fetchWomen() async
  {
    var response = await
    client.get(Uri.parse("https://fakestoreapi.com/products/category/women's%20clothing"));

    if(response.statusCode == 200)
    {
      var jsonString = response.body;
      return electronicsModelFromJson(jsonString);
    }
    else
    {
      return null;
    }
  }
}

void showToast(String text) => Fluttertoast.showToast
  (
  msg: text,
  fontSize: 13.0,
  backgroundColor: HexColor("#39b5fd"),
  textColor: Colors.white,
  gravity: ToastGravity.BOTTOM,
);


//RED : fe5858
//BLUE : 39b5fd