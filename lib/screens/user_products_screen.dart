import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import '../screens/edit_products.dart';

class UserProductsScreen extends StatelessWidget {
  static const screenName = '/user-product-screen';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductsScreen.screenName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (ctx, index) => Card(
            child: UserProductsItem(
              productsData.items[index],
            ),
          ),
          itemCount: productsData.items.length,
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
