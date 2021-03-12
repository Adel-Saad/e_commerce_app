import 'package:flutter/material.dart';
import 'package:new_e_commerce_app/Models/product.dart';
import 'package:provider/provider.dart';

import 'Providers/cart_item.dart';
import 'constants.dart';

// 1 -
List<Product> getProductByCategory(String category, List<Product> list) {
  List<Product> products = [];
  for (var product in list) {
    if (product.pcategory == category) {
      products.add(product);
    }
  }
  return products;
}

// 2 -
Widget buildTabText(String title, int tabIndex) {
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  return Text(
    title,
    style: TextStyle(
        color: _tabBarIndex == tabIndex ? Colors.black : kUnActiveColor,
        fontSize: _tabBarIndex == tabIndex ? 14 : null),
  );
}

// add product to Cart ...
void addToCart(Product product, BuildContext context, int _quantity) {
  CartItem cartItem = Provider.of<CartItem>(context, listen: false);

  product.quantity = _quantity;
  cartItem.addProduct(product);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${_quantity} Added To Cart'),
    ),
  );
}
