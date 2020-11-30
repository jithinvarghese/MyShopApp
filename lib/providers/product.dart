import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  Future<void> btnFavoritesPressed() async {
    // optimised updating pattern
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = 'https://shoppapp-39210.firebaseio.com/products/$id.json';
    try {
      http.patch(url,
          body: json.encode({
            'isFavorite': isFavorite,
          }));
    } catch (error) {
      isFavorite = oldStatus;
    }
  }
}
