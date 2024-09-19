import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:shopping_cart/model/order_model.dart';
import 'package:shopping_cart/services/order_service.dart';
import 'package:shopping_cart/viewmodel/productVM.dart';

import 'package:shopping_cart/view/screen/OrderConfirmationScreen.dart';

class OrderForm extends StatefulWidget {
  final VoidCallback onOrderPlaced;

  OrderForm({required this.onOrderPlaced});

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final _nameController = TextEditingController();
  final _sizeController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Access ProductsVM from the provider
    final productsVM = Provider.of<ProductsVM>(context);

    return AlertDialog(
      title: Text('Order Form'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _sizeController,
              decoration: InputDecoration(labelText: 'Size'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            final cartItems = productsVM.lst; // Get cart items from ProductsVM

            if (cartItems.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Add items to the cart before placing an order.'),
                ),
              );
              return; // Exit the function
            }

            // Calculate total price
            final totalPrice = cartItems.fold(0.0, (sum, item) => sum + item.quantity * 1.0); // Assuming each item is 1.0 for demonstration

            Order order = Order(
              items: cartItems.map((product) => product.toJson()).toList(), // Convert items to JSON
              totalPrice: totalPrice,
              orderDate: DateTime.now(),
              name: _nameController.text,
              size: _sizeController.text,
              address: _addressController.text,
            );

            OrderService orderService = OrderService();
            await orderService.placeOrder(order);

            widget.onOrderPlaced();

            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderConfirmationScreen(),
              ),
            );
          },
          child: Text('Place Order'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
