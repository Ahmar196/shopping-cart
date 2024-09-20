import 'package:flutter/material.dart';
import 'package:shopping_cart/services/order_service.dart';

class OrderServiceScreen extends StatefulWidget {
  @override
  _OrderServiceScreenState createState() => _OrderServiceScreenState();
}

class _OrderServiceScreenState extends State<OrderServiceScreen> {
  late Future<List<Map<String, dynamic>>> _ordersFuture;
  late Future<int> _totalOrdersFuture;
  late Future<double> _totalRevenueFuture;

  @override
  void initState() {
    super.initState();
    _refreshOrders();
  }

  Future<void> _refreshOrders() async {
    final orderService = OrderService();
    setState(() {
      _ordersFuture = orderService.getOrders();
      _totalOrdersFuture = orderService.getTotalOrders();
      _totalRevenueFuture = orderService.getTotalRevenue();
    });
  }

  Future<void> _clearOrders() async {
    final orderService = OrderService();
    await orderService.clearOrders();
    _refreshOrders(); // Refresh the orders list after clearing
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _clearOrders,
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder<int>(
            future: _totalOrdersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Center(child: Text('No data available'));
              } else {
                final totalOrders = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Total Orders: $totalOrders', style: TextStyle(fontSize: 18)),
                );
              }
            },
          ),
          FutureBuilder<double>(
            future: _totalRevenueFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Center(child: Text('No data available'));
              } else {
                final totalRevenue = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Total Revenue: \$${totalRevenue.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
                );
              }
            },
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _ordersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No orders found'));
                } else {
                  final orders = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Size')),
                          DataColumn(label: Text('Address')),
                          DataColumn(label: Text('Total Price')),
                        ],
                        rows: orders.map((order) {
                          return DataRow(
                            cells: [
                              DataCell(Text(order['name'] ?? '')),
                              DataCell(Text(order['size'] ?? '')),
                              DataCell(Text(order['address'] ?? '')),
                              DataCell(Text('\$${order['totalPrice']?.toStringAsFixed(2) ?? '0.00'}')),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
