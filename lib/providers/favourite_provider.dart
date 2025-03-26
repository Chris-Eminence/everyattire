import 'package:flutter/material.dart';
import '../model/product_model.dart';

class FavouriteProvider with ChangeNotifier {
  final Map<String, FavouriteItem> _favouriteItems = {}; // Use Map for efficient lookups

  Map<String, FavouriteItem> get favouriteItems => _favouriteItems;

  /// Get total number of items in cart
  int get favouriteCount => _favouriteItems.length;

  /// Get total price of all items in cart
  double get totalPrice {
    double total = 0.0;
    _favouriteItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  /// Add a product to the cart
  void addToCart(Product product) {
    if (_favouriteItems.containsKey(product.id.toString())) {
      _favouriteItems.update(
        product.id!.toString(),
            (existingItem) => FavouriteItem(
          id: existingItem.id,
          title: existingItem.title,
          price: existingItem.price,
          description: existingItem.description,
          quantity: existingItem.quantity + 1,
          imageUrl: existingItem.imageUrl,
        ),
      );
    } else {
      _favouriteItems.putIfAbsent(
        product.id!.toString(),
            () => FavouriteItem(
          id: product.id!,
          title: product.title!,
          description: product.description!,
          price: product.price!,
          quantity: 1,
          imageUrl: product.image!,
        ),
      );
    }
    notifyListeners();
  }

  /// Remove a product from the cart
  void removeFromFavourite(String productId) {
    if (_favouriteItems.containsKey(productId)) {
      if (_favouriteItems[productId]!.quantity > 1) {
        _favouriteItems.update(
          productId,
              (existingItem) => FavouriteItem(
            id: existingItem.id,
            title: existingItem.title,
            description: existingItem.description,
            price: existingItem.price,
            quantity: existingItem.quantity - 1,
            imageUrl: existingItem.imageUrl,
          ),
        );
      } else {
        _favouriteItems.remove(productId);
      }
      notifyListeners();
    }
  }

  /// Clear the entire cart
  void clearFavourite() {
    _favouriteItems.clear();
    notifyListeners();
  }

  /// Check if a product is in the cart
  bool isInFavourite(String productId) {
    return _favouriteItems.containsKey(productId);
  }
}

/// **Cart Item Model**
class FavouriteItem {
  final int id;
  final String title;
  final double price;
  final String description;
  final String imageUrl;
  int quantity;

  FavouriteItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
}
