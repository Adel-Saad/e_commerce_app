import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_e_commerce_app/Models/orderModel.dart';
import 'package:new_e_commerce_app/Services/store.dart';
import 'package:new_e_commerce_app/constants.dart';

import 'order_details.dart';

class OrdersScreen extends StatelessWidget {
// prop ...
  static String id = 'OrdersScreen';
  final _store = Store();
// Main Build ...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<OrderModel> orders = [];
            for (var doc in snapshot.data.docs) {
              var data = doc.data();
              orders.add(
                OrderModel(
                  docId: doc.id,
                  address: data[kAddress],
                  totalPrice: data[kTotalPrice],
                ),
              );
            }
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, OrderDetails.id,
                        arguments: orders[index].docId);
                  },
                  child: Card(
                    elevation: 10,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Address : ${orders[index].address}',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                              'Total Price ${orders[index].totalPrice.toString()} \$'),
                        ],
                      ),
                    ),
                    shadowColor: Colors.blueAccent,
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
