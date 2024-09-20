import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:shopping_cart/model/order_model.dart';

class OrderService {
  // Other existing methods...

  Future<List<Map<String, dynamic>>> getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = prefs.getString('orders') ?? '[]';
    final List<dynamic> ordersList = jsonDecode(ordersJson);
    return ordersList.cast<Map<String, dynamic>>(); // Cast to List<Map<String, dynamic>>
  }

  Future<void> placeOrder(Order order) async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = prefs.getString('orders') ?? '[]';
    final List<dynamic> ordersList = jsonDecode(ordersJson);
    ordersList.add(order.toJson()); // Assuming Order class has a toJson() method
    await prefs.setString('orders', jsonEncode(ordersList));
  }

  Future<int> getTotalOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = prefs.getString('orders') ?? '[]';
    final List<dynamic> ordersList = jsonDecode(ordersJson);
    return ordersList.length;
  }

  Future<double> getTotalRevenue() async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = prefs.getString('orders') ?? '[]';
    final List<dynamic> ordersList = jsonDecode(ordersJson);
    double totalRevenue = 0.0;
    for (var order in ordersList) {
      totalRevenue += (order['totalPrice'] ?? 0.0);
    }
    return totalRevenue;
  }

  Future<void> clearOrders() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('orders');
  }
}
