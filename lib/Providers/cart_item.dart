import 'package:flutter/cupertino.dart';
import 'package:new_e_commerce_app/Models/product.dart';

class CartItem extends ChangeNotifier {
// props ...
  List<Product> products = [];

  addProduct(Product product) {
    products.add(product);
    notifyListeners();
  }

  removeProduct(Product product) {
    products.remove(product);
    notifyListeners();
  }
}
