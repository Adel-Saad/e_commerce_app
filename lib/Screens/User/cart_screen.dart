import 'package:flutter/material.dart';
import 'package:new_e_commerce_app/Models/product.dart';
import 'package:new_e_commerce_app/Providers/cart_item.dart';
import 'package:new_e_commerce_app/Screens/Admin/edit_product.dart';
import 'package:new_e_commerce_app/Screens/User/product_info.dart';
import 'package:new_e_commerce_app/Services/store.dart';
import 'package:new_e_commerce_app/Widgets/custom_pop_up_menu.dart';
import 'package:new_e_commerce_app/constants.dart';
import 'package:provider/provider.dart';

import '../../functions.dart';

class CartScreen extends StatelessWidget {
  static String id = 'CartScreen';
  @override
  Widget build(BuildContext context) {
    // prop ...
    final _screenHeight = MediaQuery.of(context).size.height;
    List<Product> products = Provider.of<CartItem>(context).products;
    final _statusBarSheight = MediaQuery.of(context).padding.top;
    final _appBarHeight = AppBar().preferredSize.height;
    final _buttonHeight = _screenHeight * 0.07;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'My Cart',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          )),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 02),
                    child: GestureDetector(
                      onTapUp: (details) {
                        showCustommenu(details, context, products[index]);
                      },
                      child: Card(
                        shadowColor: Colors.blueAccent[100],
                        elevation: 10,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: _screenHeight * 0.15 / 1.8,
                              backgroundImage:
                                  AssetImage(products[index].pLocation),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 08),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          products[index].pName,
                                        ),
                                        Text(
                                          '${products[index].pPrice} \$',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Text(
                                        products[index].quantity.toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ButtonTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            height: _buttonHeight,
            minWidth: MediaQuery.of(context).size.width,
            child: RaisedButton(
              color: kMainColor,
              child: Text(
                'ORDER',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                showCustomDialog(products, context);
              },
            ),
          ),
        ],
      ),
    );
  }

// Helping Methods .................................

}
