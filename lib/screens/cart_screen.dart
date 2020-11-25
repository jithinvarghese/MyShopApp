import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/cart_item.dart' as ci;

class CartScreen extends StatelessWidget {
  static const screenName = '/cart-screen';
  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('You Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      // cartItems.cartTotalAmount.toString(), or
                      '\$${cartItems.cartTotalAmount}',
                      style: TextStyle(fontSize: 18),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'ORDER NOW',
                    ),
                    textColor: Theme.of(context).accentColor,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) => ci.CartMainItem(
                cartItems.items.values.toList()[index],
                cartItems.items.keys.toList()[index],
              ),
              itemCount: cartItems.cartItemCount,
            ),
          ),
        ],
      ),
    );
  }
}
