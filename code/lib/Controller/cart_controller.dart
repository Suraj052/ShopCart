import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/Model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartController extends GetxController
{

  var cartItems = <ProductModel>[].obs;
  var orderItems = <ProductModel>[].obs;

  double get price => cartItems.fold(0, (sum,item) => sum + item.price);


  static Future<void> addToCart(ProductModel product) async
  {
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('Users')
        .doc(user?.uid)
        .collection("UserCart")
        .doc(product.id.toString())
        .set(product.toJson());
  }

  Future<void> getFromCart() async
  {

    final user = FirebaseAuth.instance.currentUser;
    var val=  await FirebaseFirestore.instance.collection('Users')
        .doc(user?.uid)
        .collection("UserCart")
        .get();

    List<ProductModel> customModels = val.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return ProductModel.fromJson(data);
    }).toList();

    cartItems.value = customModels.map((model) => ProductModel(
      id: model.id,
      title: model.title,
      price: model.price,
      description: model.description,
      category: model.category,
      rating: model.rating,
      image: model.image,

    )).toList();
  }

  Future<void> addToOrder() async
  {
    final user = FirebaseAuth.instance.currentUser;
    var orderCollection = FirebaseFirestore.instance.collection('Users')
        .doc(user?.uid)
        .collection("UserOrder");

    for(int i=0;i<cartItems.length;i++)
    {
        orderCollection.doc(cartItems[i].id.toString()).set(cartItems[i].toJson());
    }

    var val=  await FirebaseFirestore.instance.collection('Users')
        .doc(user?.uid)
        .collection("UserCart")
        .get();

    final WriteBatch batch = FirebaseFirestore.instance.batch();

    for (DocumentSnapshot docSnapshot in val.docs) {
      batch.delete(docSnapshot.reference);
    }
    await batch.commit();

  }

  Future<void> getFromOrder() async
  {
    final user = FirebaseAuth.instance.currentUser;
    var val=  await FirebaseFirestore.instance.collection('Users')
        .doc(user?.uid)
        .collection("UserOrder")
        .get();

    List<ProductModel> customModels = val.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return ProductModel.fromJson(data);
    }).toList();

    orderItems.value = customModels.map((model) => ProductModel(
      id: model.id,
      title: model.title,
      price: model.price,
      description: model.description,
      category: model.category,
      rating: model.rating,
      image: model.image,
    )).toList();
  }

  deleteToCart()
  {
    cartItems.clear();
  }

}





