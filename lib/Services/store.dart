import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_e_commerce_app/Models/product.dart';
import 'package:new_e_commerce_app/constants.dart';

class Store {
// props ...
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

// methods ...
  addProduct(Product product) async {
    await _firestore.collection(kProductCollection).add({
      kProductName: product.pName,
      kProductPrice: product.pPrice,
      kProductDescription: product.pDescription,
      kProductCategory: product.pcategory,
      kProductLocation: product.pLocation,
    });
  }

  // Stream<QuerySnapshot> loadProduct() {
  //   return _firestore.collection(kProductCollection).snapshots();
  // }

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(kProductCollection).snapshots();
  }
}
