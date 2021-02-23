
import 'package:supermall/models/product.dart';



List<Product> getProductByCategory(String KFruts, List<Product> allproducts) {
  List<Product> products = [];
  try {
    for (var product in allproducts) {
      if (product.pCategory == KFruts) {
        products.add(product);
      }
    }
  } on Error catch (ex) {
    print(ex);
  }
  return products;
}