import 'package:flutter/material.dart';
import 'package:new_e_commerce_app/Models/product.dart';
import 'package:new_e_commerce_app/Providers/cart_item.dart';
import 'package:new_e_commerce_app/constants.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String id = 'CartScreen';
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Container(
                height: screenHeight * 0.20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 08),
                  child: Card(
                    shadowColor: Colors.blueAccent[100],
                    elevation: 10,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: screenHeight * 0.15 / 1.8,
                          backgroundImage:
                              AssetImage(products[index].pLocation),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 08),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        ),
                        Text(
                          products[index].quantity.toString(),
                        ),
                      ],
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
