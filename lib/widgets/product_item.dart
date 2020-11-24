import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../screens/products_details_screen.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  // final Product productItem;
  // ProductItem(this.productItem);
  

  @override
  Widget build(BuildContext context) {
      final productItem = Provider.of<Product>(context,listen: false);
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
            builder :(ctx,productItem,child) => IconButton(
            icon: Icon(productItem.isFavorite ? Icons.favorite : Icons.favorite_border_outlined ),
            color: Theme.of(context).accentColor,
            onPressed: () {
              productItem.btnFavoritesPressed();
            },
          ),
          ),
          child:Text('Never chnages!'),
        ),
        footer: GridTileBar(
          trailing: IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
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
