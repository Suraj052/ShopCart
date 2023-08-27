import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/Model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController
{

  var favoriteItems = <ProductModel>[].obs;

  // addToFavorite(ProductModel product)
  // {
  //   favoriteItems.add(product);
  // }

  static Future<void> addToFavorite(ProductModel product) async
  {
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('Users')
        .doc(user?.uid)
        .collection("UserFavorite")
        .doc(product.id.toString())
        .set(product.toJson());
  }

  Future<void> getFromFavorite() async
  {
    final user = FirebaseAuth.instance.currentUser;
    var val=  await FirebaseFirestore.instance.collection('Users')
        .doc(user?.uid)
        .collection("UserFavorite")
        .get();

    List<ProductModel> customModels = val.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return ProductModel.fromJson(data);
    }).toList();

    favoriteItems.value = customModels.map((model) => ProductModel(
      id: model.id,
      title: model.title,
      price: model.price,
      description: model.description,
      category: model.category,
      rating: model.rating,
      image: model.image,

    )).toList();
  }

  deleteFromFavorite(ProductModel product)
  {
    print("deleted");
    FirebaseFirestore.instance.collection('UserFavorite')
        .doc(product.id as String?)
        .delete().then((value) {
          print('Document deleted successfully');
        }).catchError((error) {
          print('Failed to delete document: $error');
        });
  }

}





