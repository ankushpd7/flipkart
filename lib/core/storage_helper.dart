import 'dart:convert';

import 'package:flipkart/model/product_model.dart';
import 'package:flipkart/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static const String _emailKey = "userEmail";
  static const String _passwordKey = "userPassword";
  static const String _productKey = "products";

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

  // Save a list of products
  Future<void> saveProduct(Product product) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> productStrList = prefs.getStringList(_productKey) ?? [];

    Map<String, dynamic> map = product.toMap();
    String mapStr = jsonEncode(map);
    productStrList.add(mapStr);
    prefs.setStringList(_productKey, productStrList);
  }

  // Get the list of products
  Future<List<Product>> getProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> productStrList = prefs.getStringList(_productKey) ?? [];
    List<Product> productList = [];

    for(int i =0;i<productStrList.length;i++){
      String mapStr = productStrList[i];
      Map<String,dynamic> map = jsonDecode(mapStr);
      Product product = Product.fromMap(map);
      productList.add(product);
    }

    return productList;
  }
}
