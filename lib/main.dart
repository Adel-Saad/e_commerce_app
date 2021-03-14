import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_e_commerce_app/Providers/admin_mode.dart';
import 'package:new_e_commerce_app/Providers/cart_item.dart';
import 'package:new_e_commerce_app/Screens/Admin/add_products.dart';
import 'package:new_e_commerce_app/Screens/Admin/admin_home.dart';
import 'package:new_e_commerce_app/Screens/Admin/edit_product.dart';
import 'package:new_e_commerce_app/Screens/Admin/manage_product.dart';
import 'package:new_e_commerce_app/Screens/Admin/orders_screen.dart';
import 'package:new_e_commerce_app/Screens/Admin/view_orders.dart';
import 'package:new_e_commerce_app/Screens/User/home_page.dart';
import 'package:new_e_commerce_app/Screens/User/product_info.dart';
import 'package:provider/provider.dart';
import 'package:new_e_commerce_app/Providers/model_hud.dart';
import 'Screens/Admin/order_details.dart';
import 'Screens/User/cart_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/signup_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
          create: (context) => ModelHud(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        ),
        ChangeNotifierProvider<CartItem>(
          create: (context) => CartItem(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LogInScreen.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        LogInScreen.id: (contex) => LogInScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        AdminHome.id: (context) => AdminHome(),
        AddProducts.id: (context) => AddProducts(),
        ManageProducts.id: (context) => ManageProducts(),
        ViewOrders.id: (context) => ViewOrders(),
        EditProduct.id: (context) => EditProduct(),
        ProductInfo.id: (context) => ProductInfo(),
        CartScreen.id: (context) => CartScreen(),
        OrdersScreen.id: (context) => OrdersScreen(),
        OrderDetails.id: (context) => OrderDetails(),
      },
    );
  }
}
