import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../screens/edit_products.dart';
import '../providers/product.dart';
import '../providers/products.dart';

class UserProductsItem extends StatelessWidget {
  final Product productItem;
  UserProductsItem(this.productItem);
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(productItem.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(productItem.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductsScreen.screenName,
                  arguments: productItem.id,
                );
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(productItem.id);
                } catch (error) {
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text('Deleting failed'),
                    ),
                  );
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
