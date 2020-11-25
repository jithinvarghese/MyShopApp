import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

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
    // final productsData = Provider.of<Products>(context)
    //     .items
    //     .firstWhere((pdt) => pdt.id == productId);
    // Better logic is to call the data from products

    // setting listen false will not call when notificaer is called
    final productsData =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(productsData.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(productsData.imageUrl, fit: BoxFit.cover),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$${productsData.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                productsData.description,
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
