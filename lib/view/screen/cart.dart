import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/view/screen/OrderConfirmationScreen.dart';
import 'package:shopping_cart/view/screen/orderform.dart';
import 'package:shopping_cart/viewmodel/productVM.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsVM = Provider.of<ProductsVM>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Clear all orders from the cart
              productsVM.clearAll();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: productsVM.lst.isEmpty
                ? Center(child: Text('No items in the cart'))
                : ListView.builder(
                    itemCount: productsVM.lst.length,
                    itemBuilder: (context, index) {
                      final product = productsVM.lst[index];
                      return ListTile(
                        leading: Image.asset(
                          product.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(product.name),
                        subtitle: Text('Quantity: ${product.quantity}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                productsVM.decrementQuantity(index);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                productsVM.incrementQuantity(index);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                productsVM.del(index);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Check if the cart is empty before placing an order
                      if (productsVM.lst.isEmpty) {
                        // Show a message that the cart is empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Your cart is empty. Add items to proceed.'),
                          ),
                        );
                        return;
                      }

                      // Show order form dialog
                      showDialog(
                        context: context,
                        builder: (context) => OrderForm(
                          onOrderPlaced: () {
                            // Clear the cart and show confirmation after order is placed
                            productsVM.clearAll();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderConfirmationScreen(),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: Text('Place Order'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Clear all items from the cart
                    productsVM.clearAll();
                  },
                  child: Text('Clear All'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
