import 'package:flutter/material.dart';

import '../model/product.dart';

class ProductsDetailsScreen extends StatelessWidget {
  // final Product productDetail;
  // ProductsDetailsScreen(this.productDetail);
  static const screenName = "/product-detail";

  @override
  Widget build(BuildContext context) {
    // to get the value  when screen changes
    // and top get the value from the aruguments
    final productId = ModalRoute.of(context).settings.arguments as String;
    // get all the data using product id
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
    );
  }
}
