import 'package:flutter/material.dart';
import 'package:new_e_commerce_app/Models/product.dart';
import 'package:new_e_commerce_app/Services/store.dart';
import 'package:provider/provider.dart';

import 'Providers/cart_item.dart';
import 'Screens/User/home_page.dart';
import 'Screens/User/product_info.dart';
import 'Widgets/custom_pop_up_menu.dart';
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
  bool productExists = false;
  var myProducts = cartItem.products;

  for (var productInCart in myProducts) {
    if (productInCart.pID == product.pID) {
      productExists = true;
    }
  }
  if (productExists) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You \'ve added This Item before'),
      ),
    );
  } else {
    cartItem.addProduct(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_quantity} Added To Cart'),
      ),
    );
  }
}

void showCustommenu(
    TapUpDetails details, BuildContext context, Product product) async {
  double dx = details.globalPosition.dx;
  double dy = details.globalPosition.dy;
  double dx2 = MediaQuery.of(context).size.width - dx;
  double dy2 = MediaQuery.of(context).size.width - dy;
  await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
      items: [
        MyPopupMenuItem(
          onClick: () {
            Navigator.pop(context);
            Provider.of<CartItem>(context, listen: false)
                .removeProduct(product);
            Navigator.pushNamed(context, ProductInfo.id, arguments: product);
          },
          child: Text('Edit'),
        ),
        MyPopupMenuItem(
          onClick: () {
            Navigator.pop(context);
            Provider.of<CartItem>(context, listen: false)
                .removeProduct(product);
          },
          child: Text('Delete'),
        ),
      ]);
}

int totalPrice;
showCustomDialog(List<Product> products, BuildContext context) async {
  getTotalPrice() {
    var totalPrice = 0;
    for (var item in products) {
      totalPrice += int.parse(item.pPrice) * item.quantity;
    }
    return totalPrice;
  }

  var address;
  Store _store = Store();
  int totalPrice = getTotalPrice();
  var myAlertDialoge = AlertDialog(
    title: Text(
      'Total Price : ${totalPrice} \$',
      style: TextStyle(fontSize: 18),
    ),
    actions: [
      MaterialButton(
        child: Text('Cxl'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      MaterialButton(
        child: Text('Confirm'),
        onPressed: () {
          try {
            _store.storeOrders({
              kTotalPrice: totalPrice,
              kAddress: address,
            }, products);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Ordered Successfully'),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.message),
              ),
            );
          }
        },
      ),
    ],
    content: TextField(
      onChanged: (value) {
        address = value;
      },
      decoration: InputDecoration(hintText: 'Enter Your Address..'),
    ),
  );

  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return myAlertDialoge;
    },
  );
}
