import 'package:flutter/foundation.dart';

class CartItem {
  final String name;
  final int quantity;
  final double price;

  CartItem({required this.name, required this.quantity, required this.price});
}

class CartModel extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(0, (total, item) => total + (item.quantity * item.price));
  }
}
