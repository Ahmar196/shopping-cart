// lib/model/order_model.dart
import 'dart:convert';

class Order {
  final List<Map<String, dynamic>> items;
  final double totalPrice;
  final DateTime orderDate;
  final String name;
  final String size;
  final String address;

  Order({
    required this.items,
    required this.totalPrice,
    required this.orderDate,
    required this.name,
    required this.size,
    required this.address,
  });

  // Convert order to JSON
  String toJson() {
    final orderMap = {
      'items': items,
      'totalPrice': totalPrice,
      'orderDate': orderDate.toIso8601String(),
      'name': name,
      'size': size,
      'address': address,
    };
    return orderMap.toString();
  }

  // Create an Order from JSON
  static Order fromJson(String json) {
    final orderMap = Map<String, dynamic>.from(jsonDecode(json));
    return Order(
      items: List<Map<String, dynamic>>.from(orderMap['items']),
      totalPrice: orderMap['totalPrice'],
      orderDate: DateTime.parse(orderMap['orderDate']),
      name: orderMap['name'],
      size: orderMap['size'],
      address: orderMap['address'],
    );
  }
}
