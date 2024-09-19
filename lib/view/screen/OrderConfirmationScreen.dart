// lib/view/screen/order_confirmation.dart
import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Confirmation'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Your order has been placed successfully!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
