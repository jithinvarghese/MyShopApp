import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/cart_item.dart' as ci;
import '../providers/orders.dart';
import '../screens/order_screen.dart';

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
                      '\$${cartItems.cartTotalAmount.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cartItems: cartItems),
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cartItems,
  }) : super(key: key);

  final Cart cartItems;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isloading = false;

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (widget.cartItems.cartTotalAmount <= 0 || _isloading)
          ? null
          : () async {
              setState(() {
                _isloading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrders(
                widget.cartItems.items.values.toList(),
                widget.cartItems.cartTotalAmount,
              );
              setState(() {
                _isloading = false;
              });
              widget.cartItems.cartClear();
              Navigator.of(context).pushNamed(OrderScreen.screenName);
            },
      child: _isloading
          ? CircularProgressIndicator()
          : Text(
              'ORDER NOW',
            ),
      textColor: Theme.of(context).accentColor,
    );
  }
}
