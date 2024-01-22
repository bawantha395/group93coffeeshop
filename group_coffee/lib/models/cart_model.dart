import 'package:flutter/foundation.dart';

class CartItem {
  final String name;
  int quantity;
  final double price;
  final String imageUrl; // Add this line

  CartItem({
    required this.name,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void incrementQuantity(int index) {
    _cartItems[index].quantity++;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_cartItems[index].quantity > 1) {
      _cartItems[index].quantity--;
      notifyListeners();
    }
  }

  double get totalPrice {
    return _cartItems.fold(0, (total, item) => total + (item.quantity * item.price));
  }
}
