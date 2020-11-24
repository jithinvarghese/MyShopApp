import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_item.dart';
import '../providers/products.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: productsData.items.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value( 
        // builder:(ctx) => products[index],
        value: products[index],
        child:ProductItem(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    ),
    );
  }
}
