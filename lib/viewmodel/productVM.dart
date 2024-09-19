import 'package:flutter/material.dart';
import 'package:shopping_cart/model/productmodel.dart';

class ProductsVM with ChangeNotifier {
  List<Products> lst = []; // List of products in the cart
  List<Products> wishlist = []; // List of products in the wishlist

  // Method to add a product
  void add(String image, String name) {
    var existingProduct = lst.indexWhere((product) => product.name == name);
    if (existingProduct >= 0) {
      lst[existingProduct].quantity++;
    } else {
      lst.add(Products(image: image, name: name, quantity: 1));
    }
    notifyListeners();
  }

  // Method to remove a product from the cart
  void removeFromCart(String name) {
    lst.removeWhere((product) => product.name == name);
    notifyListeners();
  }

  // Alias for removeFromCart
  void remove(String name) {
    removeFromCart(name);
  }

  // Method to delete a product at a specific index
  void del(int index) {
    lst.removeAt(index);
    notifyListeners();
  }

  // Method to clear all products from the cart
  void clearAll() {
    lst.clear();
    notifyListeners();
  }

  // Check if a product is already added to the cart
  bool isAlreadyAdded(String itemName) {
    return lst.any((product) => product.name == itemName);
  }

  // Increment the quantity of a product
  void incrementQuantity(int index) {
    lst[index].quantity++;
    notifyListeners();
  }

  // Decrement the quantity of a product
  void decrementQuantity(int index) {
    if (lst[index].quantity > 1) {
      lst[index].quantity--;
      notifyListeners();
    }
  }

  // Add a product to the wishlist
  void addToWishlist(String image, String name) {
    if (!isInWishlist(name)) {
      wishlist.add(Products(image: image, name: name, quantity: 1));
      notifyListeners();
    }
  }

  // Remove a product from the wishlist
  void removeFromWishlist(String name) {
    wishlist.removeWhere((product) => product.name == name);
    notifyListeners();
  }

  // Check if a product is in the wishlist
  bool isInWishlist(String itemName) {
    return wishlist.any((product) => product.name == itemName);
  }
}
