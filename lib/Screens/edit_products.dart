import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_e_commerce_app/Models/product.dart';
import 'package:new_e_commerce_app/Providers/model_hud.dart';
import 'package:new_e_commerce_app/Services/store.dart';
import 'package:new_e_commerce_app/constants.dart';
import 'package:provider/provider.dart';

class EditProducts extends StatefulWidget {
  static String id = 'EditProducts';
  @override
  _EditProductsState createState() => _EditProductsState();
}

// ========================= STATE CLASS =======================================
class _EditProductsState extends State<EditProducts> {
// props ...
  static String id = 'edit products';
  final _store = Store();

  @override
  void initState() {
    super.initState();
  }

  // main build ...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.docs) {
              var data = doc.data();
              products.add(Product(
                  pDescription: data[kProductDescription],
                  pLocation: data[kProductLocation],
                  pName: data[kProductName],
                  pPrice: data[kProductPrice],
                  pcategory: data[kProductCategory]));
            }
            return GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.8),
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTapUp: (details) async {
                    double dx = details.globalPosition.dx;
                    double dy = details.globalPosition.dy;
                    double dx2 = MediaQuery.of(context).size.width - dx;
                    double dy2 = MediaQuery.of(context).size.width - dy;
                    return await showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                        items: [
                          MyPopUpMenuItem(
                            onClick: () {},
                            child: Text('Edit'),
                          ),
                          MyPopUpMenuItem(
                            onClick: () {},
                            child: Text('Delete'),
                          ),
                        ]);
                  },
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
            Text('Loading ... ');
          }
        },
      ),
    );
  }
}

//  ****************** TEST ****************

class MyPopUpMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onClick;
  MyPopUpMenuItem({@required this.child, @required this.onClick})
      : super(child: child);
  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopUpmentItemState();
  }
}

class MyPopUpmentItemState<T, PopupMenuItem>
    extends PopupMenuItemState<T, MyPopUpMenuItem<T>> {
  @override
  void handleTap() {
    widget.onClick;
  }
}
