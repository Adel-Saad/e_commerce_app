import 'package:flutter/material.dart';
import 'package:new_e_commerce_app/Models/product.dart';
import 'package:new_e_commerce_app/Providers/cart_item.dart';
import 'package:new_e_commerce_app/constants.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

import '../../functions.dart';

class ProductInfo extends StatefulWidget {
// prop ...
  static String id = 'ProductInfo';
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

//================================ STATE =======================================
class _ProductInfoState extends State<ProductInfo> {
// prop ...
  int _quantity;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _quantity = 1;
  }

// MAin Build ...
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    CartItem cartItem = Provider.of<CartItem>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(product.pLocation),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Badge(
                      position: BadgePosition(top: -15, end: -15),
                      child: Icon(Icons.shopping_cart),
                      toAnimate: true,
                      badgeContent: Text('${cartItem.products.length}',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  Opacity(
                    opacity: 0.50,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 08),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.25,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  product.pName,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              ClipOval(
                                child: Material(
                                  color: kMainColor,
                                  child: IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        _quantity++;
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  product.pDescription,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: ClipOval(
                                  child: Text(
                                    '${_quantity}',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${product.pPrice} \$',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              ClipOval(
                                child: Material(
                                  color: kMainColor,
                                  child: IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        if (_quantity > 1) {
                                          _quantity--;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Builder(
                    builder: (context) => ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.10,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        color: kMainColor,
                        child: Text(
                          'Add To Cart'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          addToCart(product, context, _quantity);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
