
import 'package:flutter/material.dart';

class FavoriteItemsModel extends ChangeNotifier {
  final Set<String> _favoriteItems = {};

  Set<String> get favoriteItems => _favoriteItems;

  void addToFavorites(String item) {
    _favoriteItems.add(item);
    notifyListeners();
  }

  void removeFromFavorites(String item) {
    _favoriteItems.remove(item);
    notifyListeners();
  }
}
