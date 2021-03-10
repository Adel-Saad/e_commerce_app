import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_e_commerce_app/Providers/admin_mode.dart';
import 'package:new_e_commerce_app/Screens/add_products.dart';
import 'package:new_e_commerce_app/Screens/admin_home.dart';
import 'package:new_e_commerce_app/Screens/edit_products.dart';
import 'package:new_e_commerce_app/Screens/home_page.dart';
import 'package:new_e_commerce_app/Screens/view_orders.dart';
import 'package:provider/provider.dart';
import 'package:new_e_commerce_app/Providers/model_hud.dart';
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
        EditProducts.id: (context) => EditProducts(),
        ViewOrders.id: (context) => ViewOrders(),
      },
    );
  }
}
