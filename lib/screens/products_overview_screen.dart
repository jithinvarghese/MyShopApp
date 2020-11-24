import 'package:flutter/material.dart';


import '../widgets/product_gride.dart';


enum FilterOptions
{
  Favorites,
  All,
}

class ProductOverviewScreen extends StatelessWidget {
  static const screenName = "/product-overview";
  @override
  Widget build(BuildContext context) {
      final productscontainer = Provider.of<Products>(context,listen : false);
    return Scaffold(
      appBar: AppBar(
        title: Text('My shop'),
      ),
      action : <Widget>[
        PopMenuButton(
          onSelected : (FilterOptions selectedValue){
            print(selectedValue);
            if(selectedValue == FilterOptions.Favorites)
            {
              // productscontainer.showFavoritesOnly();
            }
            else{
                //  productscontainer.showAll();
            }

          },
          icon:Icon(Icons.more_vert,),itemBuilder:(_) => [
          PopMenuItem(child:text('Only Favorites'),value :FilterOptions.Favorites,)
          PopMenuItem(child:text('Show All'),value :FilterOptions.All,)
        ],),
      ],
      body: ProductGrid(),
    );
  }
}
