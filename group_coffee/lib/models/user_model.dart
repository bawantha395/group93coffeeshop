import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  String _name = '';
  String _email = '';

  String get name => _name;
  String get email => _email;

  // Method to set user details
  void setUserDetails(String name, String email) {
    _name = name;
    _email = email;
    notifyListeners(); // Notify listeners about the change
  }

  // Method to perform logout
  void logout() {
    _name = '';
    _email = '';
    notifyListeners(); // Notify listeners about the change
  }
}
