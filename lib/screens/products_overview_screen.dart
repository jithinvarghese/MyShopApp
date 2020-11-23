import 'package:flutter/material.dart';

import '../widgets/product_gride.dart';

class ProductOverviewScreen extends StatelessWidget {
  static const screenName = "/product-overview";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My shop'),
      ),
      body: ProductGrid(),
    );
  }
}
