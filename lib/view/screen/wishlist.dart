import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/viewmodel/productVM.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsVM = Provider.of<ProductsVM>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        backgroundColor: Colors.blue,
      ),
      body: productsVM.wishlist.isEmpty
          ? Center(
              child: Text(
                'Your wishlist is empty!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: productsVM.wishlist.length,
              itemBuilder: (context, index) {
                final product = productsVM.wishlist[index];
                bool isAddedToCart = productsVM.isAlreadyAdded(product.name);

                return ListTile(
                  leading: Image.asset(product.image),
                  title: Text(product.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          productsVM.removeFromWishlist(product.name);
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (isAddedToCart) {
                            productsVM.remove(product.name); // Remove from cart
                          } else {
                            productsVM.add(product.image, product.name); // Add to cart
                          }
                        },
                        child: Text(isAddedToCart ? "Added " : "Add to Cart"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: isAddedToCart ? Colors.blue : Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
