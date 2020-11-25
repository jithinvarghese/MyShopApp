import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/products_details_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShopApp',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductsDetailsScreen.screenName: (ctx) => ProductsDetailsScreen(),
          CartScreen.screenName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
