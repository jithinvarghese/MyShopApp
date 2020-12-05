import 'package:flutter/foundation.dart';
import './cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  final String authToken;
  Orders(this.authToken, this._orders);

  Future<void> addOrders(List<CartItem> cartProducts, double total) async {
    final url =
        'https://shoppapp-39210.firebaseio.com/orders.json?auth=$authToken';
    final timestamp = DateTime.now();
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'dateTime': DateTime.now().toIso8601String(),
          'id': timestamp.toString(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'qunatity': cp.qunatity,
                    'price': cp.price,
                  })
              .toList(),
        }),
      );
      _orders.insert(
        0,
        OrderItem(
            amount: total,
            dateTime: timestamp,
            id: json.decode(response.body)['name'],
            products: cartProducts),
      );
    } catch (error) {}

    notifyListeners();
  }
}
