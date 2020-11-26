import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class CartItem {
  final String id;
  final String title;
  final int qunatity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.qunatity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};

  }

  int get cartItemCount {
    return _items.length;
  }

  double get cartTotalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.qunatity;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
      // chnage qunatity
      _items.update(
          productId,
          (existingCartItems) => CartItem(
                id: existingCartItems.id,
                title: existingCartItems.title,
                price: existingCartItems.price,
                qunatity: existingCartItems.qunatity + 1,
              ));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          qunatity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removieItem(String id) {
    print(_items);
    _items.remove(id);
    notifyListeners();
  }

  void cartClear() {
    _items = {};
    notifyListeners();
  }

  void cartRemovesSingleItem(String productId) {
    print('key' + productId);
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].qunatity > 1) {
      _items.update(
          productId,
          (existingCartItems) => CartItem(
                id: existingCartItems.id,
                title: existingCartItems.title,
                price: existingCartItems.price,
                qunatity: existingCartItems.qunatity - 1,
              ));
    }else{
      _items.remove(productId); 
    }
  }
}
