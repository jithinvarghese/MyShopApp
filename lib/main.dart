import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/products_details_screen.dart';
import './screens/cart_screen.dart';
import './screens/order_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_products.dart';
import './screens/auth_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';

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
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, prevousProducts) => Products(
              auth.token, prevousProducts == null ? [] : prevousProducts.items),
          create: null,
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, prevousProducts) => Orders(
            auth.token,
            prevousProducts == null ? [] : prevousProducts.orders,
          ),
          create: null,
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShopApp',
          theme: ThemeData(
            primarySwatch: Colors.orange,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          // home: AuthScreen(),
          routes: {
            '/': (ctx) => auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
            ProductsDetailsScreen.screenName: (ctx) => ProductsDetailsScreen(),
            CartScreen.screenName: (ctx) => CartScreen(),
            OrderScreen.screenName: (ctx) => OrderScreen(),
            UserProductsScreen.screenName: (ctx) => UserProductsScreen(),
            EditProductsScreen.screenName: (ctx) => EditProductsScreen(),
          },
        ),
      ),
    );
  }
}

// login completed
// dev completed
// QA complted
// prod completed
// http-login complted
