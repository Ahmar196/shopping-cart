import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_cart/model/order_model.dart';

class OrderService {
  Future<void> placeOrder(Order order) async {
    final prefs = await SharedPreferences.getInstance();
    final orderCount = prefs.getInt('orderCount') ?? 0;

    await prefs.setString('orderName_$orderCount', order.name);
    await prefs.setString('orderSize_$orderCount', order.size);
    await prefs.setString('orderAddress_$orderCount', order.address);
    await prefs.setDouble('orderTotalPrice_$orderCount', order.totalPrice);
    await prefs.setString('orderDate_$orderCount', order.orderDate.toIso8601String());

    await prefs.setInt('orderCount', orderCount + 1);
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final orderCount = prefs.getInt('orderCount') ?? 0;

    List<Map<String, dynamic>> orders = [];
    for (int i = 0; i < orderCount; i++) {
      final name = prefs.getString('orderName_$i') ?? 'Unknown';
      final size = prefs.getString('orderSize_$i') ?? 'Unknown';
      final address = prefs.getString('orderAddress_$i') ?? 'Unknown';
      final totalPrice = prefs.getDouble('orderTotalPrice_$i') ?? 0.0;

      orders.add({
        'name': name,
        'size': size,
        'address': address,
        'totalPrice': totalPrice,
      });
    }

    return orders;
  }

  Future<void> clearOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final orderCount = prefs.getInt('orderCount') ?? 0;

    for (int i = 0; i < orderCount; i++) {
      await prefs.remove('orderName_$i');
      await prefs.remove('orderSize_$i');
      await prefs.remove('orderAddress_$i');
      await prefs.remove('orderTotalPrice_$i');
      await prefs.remove('orderDate_$i');
    }

    await prefs.remove('orderCount');
  }
}
