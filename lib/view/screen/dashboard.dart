import 'package:flutter/material.dart';
import 'package:shopping_cart/services/order_service.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<int> _totalOrdersFuture;
  late Future<double> _totalRevenueFuture;
  late Future<List<Map<String, dynamic>>> _ordersFuture;
  final int _peopleOnline = 4; // Static for now

  @override
  void initState() {
    super.initState();
    _refreshOrders();
  }

  Future<void> _refreshOrders() async {
    final orderService = OrderService();
    setState(() {
      _totalOrdersFuture = orderService.getTotalOrders();
      _totalRevenueFuture = orderService.getTotalRevenue();
      _ordersFuture = orderService.getOrders();
    });
  }

  void _showOrderList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderListScreen(
          ordersFuture: _ordersFuture,
        ),
      ),
    );
  }

  Widget buildInfoCard(String title, IconData icon, Future<dynamic> futureValue, String suffix) {
    return Card(
      elevation: 4,
      color: Color(0xffd9bfa6),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 20,
            color: Color(0xffb58151),
            alignment: Alignment.center,
            child: Text(title, style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<dynamic>(
              future: futureValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final value = snapshot.data ?? 0;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(icon, size: 40, color: Colors.white),
                          Text('$value$suffix', style: TextStyle(fontSize: 24, color: Colors.white)),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: 20,
            color: Color(0xffb58151),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: _showOrderList,
              child: Text('View more...',textAlign: TextAlign.start, style: TextStyle(fontSize: 16, color: Colors.white,)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Dashboard'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshOrders,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  buildInfoCard('Total Orders', Icons.shopping_cart, _totalOrdersFuture, ''),
                  SizedBox(height: 10),
                  buildInfoCard('Total Revenue', Icons.credit_card, _totalRevenueFuture, ' \$'),
                  SizedBox(height: 10),
                  buildInfoCard('People Online', Icons.people, Future.value(_peopleOnline), ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderListScreen extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> ordersFuture;

  OrderListScreen({required this.ordersFuture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order List'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: ordersFuture,
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
    );
  }
}
