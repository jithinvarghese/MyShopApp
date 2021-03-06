import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../screens/products_details_screen.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

class ProductItem extends StatelessWidget {
  // final Product productItem;
  // ProductItem(this.productItem);

  @override
  Widget build(BuildContext context) {
    final productItem = Provider.of<Product>(context, listen: false);
    final cartItem = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    print('product rebuild');
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            productItem.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductsDetailsScreen.screenName,
              arguments: productItem.id,
            );
          },
          // onTap: () {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => ProductsDetailsScreen(productItem),
          //     ),
          //   );
          // },
        ),
        header: GridTileBar(
          leading: Consumer<Product>(
            builder: (ctx, productItem, _) => IconButton(
              icon: Icon(productItem.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border_outlined),
              color: Theme.of(context).accentColor,
              onPressed: () {
                productItem.btnFavoritesPressed(authData.token);
              },
            ),
          ),
        ),
        footer: GridTileBar(
          trailing: IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              cartItem.addItem(
                  productItem.id, productItem.price, productItem.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added Item to ccart!'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cartItem.cartRemovesSingleItem(productItem.id);
                    },
                  ),
                ),
              );
            },
          ),
          backgroundColor: Colors.black38,
          title: (Text(
            productItem.title,
            textAlign: TextAlign.center,
          )),
        ),
      ),
    );
  }
}
