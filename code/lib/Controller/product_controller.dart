import 'package:code/Model/product_model.dart';
import 'package:code/Services/api_services.dart';
import 'package:get/get.dart';


class ProductController extends GetxController
{
  var electronicsList = <ProductModel>[].obs;
  var jeweleryList = <ProductModel>[].obs;
  var menList = <ProductModel>[].obs;
  var womenList = <ProductModel>[].obs;

  @override
  void onInit()
  {
    fetchJewelery();
    fetchElectronics();
    fetchMen();
    fetchWomen();
    super.onInit();
  }

  void fetchElectronics() async
  {
    var products = await ApiServices.fetchElectronics();
    if(products != null)
    {
      electronicsList.value = products;
    }
  }

  void fetchJewelery() async
  {
    var products = await ApiServices.fetchJewelery();
    if(products != null)
    {
      jeweleryList.value = products;
    }
  }

  void fetchMen() async
  {
    var products = await ApiServices.fetchMen();
    if(products != null)
    {
      menList.value = products;
    }
  }

  void fetchWomen() async
  {
    var products = await ApiServices.fetchWomen();
    if(products != null)
      {
        womenList.value = products;
      }
  }
}