import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/view/widgets/cartitem.dart';
import 'package:shopping_cart/viewmodel/productVM.dart'; // Import your ProductsVM

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Function to remove a specific item from the cart
  void removeItem(int index) {
    Provider.of<ProductsVM>(context, listen: false).del(index);
  }

  // Function to clear all items from the cart
  void clearAllItems() {
    Provider.of<ProductsVM>(context, listen: false).clearAll();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    // Get the cart items from the ProductsVM provider
    var cartItems = Provider.of<ProductsVM>(context).lst;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          // List of cart items
          Expanded(
            child: cartItems.isNotEmpty
                ? ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      var item = cartItems[index];
                      return Dismissible(
                        key: Key(item.name), // Unique key for each item
                        direction: DismissDirection.horizontal, // Swipe left/right
                        onDismissed: (direction) {
                          // Remove the item when dismissed
                          removeItem(index);
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        child: CartItem(
                          key: UniqueKey(),
                          screenSize: screenSize,
                          image: item.image,
                          itemName: item.name,
                          del: () => removeItem(index),
                        ),
                      );
                    },
                  )
                : Center(child: Text("Your cart is empty!")), // Display if the cart is empty
          ),

          // Show Clear All button below the list of items
          if (cartItems.isNotEmpty) // Only show if there are items in the cart
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: clearAllItems,
                  child: Text(
                    "Clear All",
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
