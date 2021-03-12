import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:new_e_commerce_app/Models/product.dart';
import 'package:new_e_commerce_app/Providers/cart_item.dart';
import 'package:new_e_commerce_app/Services/store.dart';
import 'package:new_e_commerce_app/constants.dart';
import 'package:new_e_commerce_app/Widgets/custom_tab_view.dart';
import 'package:new_e_commerce_app/functions.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  // prop ...
  static String id = 'HomePage';
  @override
  _HomePageState createState() => _HomePageState();
}

//============================= STATE ==========================================
class _HomePageState extends State<HomePage> {
// props ...
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  var _store = Store();
  List<Product> _products = [];
// Main Build ...
  @override
  Widget build(BuildContext context) {
    CartItem cartItem = Provider.of<CartItem>(context);
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: kMainColor,
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
                tabs: [
                  buildTabText('Jackets', 0),
                  buildTabText('Trousers', 1),
                  buildTabText('T-Shirts', 2),
                  buildTabText('Shoes', 3),
                ],
              ),
            ),
            body: Center(
              child: TabBarView(
                children: [
                  productView(kJackets),
                  productView(kTrousers),
                  productView(kTShirts),
                  productView(kShoes),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                setState(() {
                  _bottomBarIndex = value;
                });
              },
              currentIndex: _bottomBarIndex,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  label: 'test',
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: 'test',
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: 'test',
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: 'test',
                  icon: Icon(Icons.person),
                ),
              ],
            ),
          ),
        ),
        Material(
          child: Container(
            height: MediaQuery.of(context).size.height * .18,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Discover',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
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
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
