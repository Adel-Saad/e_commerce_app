import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_e_commerce_app/Models/product.dart';
import 'package:new_e_commerce_app/Screens/User/product_info.dart';
import 'package:new_e_commerce_app/Services/store.dart';
import 'package:new_e_commerce_app/constants.dart';

import '../functions.dart';

Widget productView(String category) {
//prop...
  List<Product> _products = [];
  var _store = Store();
  return StreamBuilder<QuerySnapshot>(
    stream: _store.loadProducts(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<Product> products = [];
        for (var doc in snapshot.data.docs) {
          var data = doc.data();
          products.add(Product(
              pID: doc.id,
              pDescription: data[kProductDescription],
              pLocation: data[kProductLocation],
              pName: data[kProductName],
              pPrice: data[kProductPrice],
              pcategory: data[kProductCategory]));
        }

        _products = [...products];
        products.clear();

        products = getProductByCategory(category, _products);

        return GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.8),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, ProductInfo.id,
                  arguments: products[index]),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage(products[index].pLocation),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Opacity(
                      opacity: 0.7,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                products[index].pName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(products[index].pDescription),
                              Text('${products[index].pPrice} \$'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}
