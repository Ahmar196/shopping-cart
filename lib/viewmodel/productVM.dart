import 'package:flutter/widgets.dart';
import 'package:shopping_cart/model/productmodel.dart';

class ProductsVM with ChangeNotifier {
  List<Products> lst = [];

  // Method to add a product
  void add(String image, String name) {
    lst.add(Products(image: image, name: name));
    notifyListeners();
  }

  // Method to delete a product at a specific index
  void del(int index) {
    lst.removeAt(index);
    notifyListeners();
  }

  // Method to clear all products
  void clearAll() {
    lst.clear();
    notifyListeners();
  }

  // Method to check if a product is already added
  bool isAlreadyAdded(String itemName) {
    return lst.any((product) => product.name == itemName);
  }
}
