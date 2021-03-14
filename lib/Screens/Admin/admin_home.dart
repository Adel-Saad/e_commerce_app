import 'package:flutter/material.dart';
import 'package:new_e_commerce_app/Screens/Admin/add_products.dart';
import 'package:new_e_commerce_app/Screens/Admin/manage_product.dart';
import 'package:new_e_commerce_app/Screens/Admin/view_orders.dart';
import 'package:new_e_commerce_app/constants.dart';

import 'orders_screen.dart';

class AdminHome extends StatefulWidget {
  // props ...
  static String id = 'admin home';
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
            child: Text('Add Products'),
            onPressed: () {
              Navigator.pushNamed(context, AddProducts.id);
            },
          ),
          RaisedButton(
            child: Text('Edit Products'),
            onPressed: () {
              Navigator.pushNamed(context, ManageProducts.id);
            },
          ),
          RaisedButton(
            child: Text('View Orders'),
            onPressed: () {
              Navigator.pushNamed(context, OrdersScreen.id);
            },
          ),
        ],
      ),
    );
  }
}
