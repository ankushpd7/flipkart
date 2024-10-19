

import 'package:flipkart/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static const String _emailKey = "userEmail";
  static const String _passwordKey = "userPassword";

  Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, user.email);
    await prefs.setString(_passwordKey, user.password);
  }

  // Retrieve user email and password
  Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString(_emailKey);
    String? password = prefs.getString(_passwordKey);

    if (email != null && password != null) {
      return User(email: email, password: password);
    }
    return null;
  }

  // Clear saved user data
  Future<void> clearUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey);
    await prefs.remove(_passwordKey);
  }
}
