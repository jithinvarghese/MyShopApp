import 'package:flutter/material.dart';

import './screens/products_overview_screen.dart';
import './screens/products_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShopApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      home: ProductOverviewScreen(),
      routes: {
        ProductsDetailsScreen.screenName: (ctx) => ProductsDetailsScreen(),
      },
    );
  }
}
