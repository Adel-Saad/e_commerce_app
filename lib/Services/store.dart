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

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(kProductCollection).snapshots();
  }

  deleteProduct(documentID) async {
    await _firestore.collection(kProductCollection).doc(documentID).delete();
  }

  editProduct(productID, data) async {
    await _firestore.collection(kProductCollection).doc(productID).update(data);
  }

  storeOrders(data, List<Product> products) {
    var documentRef = _firestore.collection(kOrdersCollection).doc();
    documentRef.set(data);

    for (var product in products) {
      documentRef.collection(kOrderDetailsCollection).doc().set({
        kProductName: product.pName,
        kProductPrice: product.pPrice,
        kProductLocation: product.pLocation,
        kProductQuantity: product.quantity,
      });
    }
  }

// ******************* CLASS END *****************************
}
