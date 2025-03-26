import 'package:flutter/material.dart';
import '../model/product_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _cartItems = {}; // Use Map for efficient lookups

  Map<String, CartItem> get cartItems => _cartItems;

  /// Get total number of items in cart
  int get cartCount => _cartItems.length;

  /// Get total price of all items in cart
  double get totalPrice {
    double total = 0.0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  /// Add a product to the cart
  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id.toString())) {
      _cartItems.update(
        product.id!.toString(),
            (existingItem) => CartItem(
          id: existingItem.id,
          title: existingItem.title,
          price: existingItem.price,
          description: existingItem.description,
          quantity: existingItem.quantity + 1,
          imageUrl: existingItem.imageUrl,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        product.id!.toString(),
            () => CartItem(
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
  void removeFromCart(String productId) {
    if (_cartItems.containsKey(productId)) {
      if (_cartItems[productId]!.quantity > 1) {
        _cartItems.update(
          productId,
              (existingItem) => CartItem(
            id: existingItem.id,
            title: existingItem.title,
            description: existingItem.description,
            price: existingItem.price,
            quantity: existingItem.quantity - 1,
            imageUrl: existingItem.imageUrl,
          ),
        );
      } else {
        _cartItems.remove(productId);
      }
      notifyListeners();
    }
  }

  /// Clear the entire cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  /// Check if a product is in the cart
  bool isInCart(String productId) {
    return _cartItems.containsKey(productId);
  }
}

/// **Cart Item Model**
class CartItem {
  final int id;
  final String title;
  final double price;
  final String description;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
}
