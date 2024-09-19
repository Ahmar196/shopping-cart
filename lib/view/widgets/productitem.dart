import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/viewmodel/productVM.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    required Key key,
    required this.screenSize,
    required this.image,
    required this.itemName,
    required this.isDarkMode,
  }) : super(key: key);

  final Size screenSize;
  final String image, itemName;
 final bool isDarkMode;
  @override
  Widget build(BuildContext context) {
    double imageSize = screenSize.height * 0.15; // Adjust size as needed

    return Container(
      margin: EdgeInsets.all(10),
      height: screenSize.height * 0.25,
      width: screenSize.width * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            offset: Offset(0, 0),
            blurRadius: 3,
            spreadRadius: 3,
          )
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: imageSize,
                  height: imageSize,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  itemName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.black : Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Consumer<ProductsVM>(
                builder: (context, value, child) {
                  bool isAddedToCart = value.isAlreadyAdded(itemName);

                  return ElevatedButton(
                    onPressed: () {
                      if (isAddedToCart) {
                        value.removeFromCart(itemName); // Remove if already added
                      } else {
                        value.add(image, itemName); // Add to cart
                      }
                    },
                    child: Text(isAddedToCart ? "Added" : "Add to Cart"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: isAddedToCart ? Colors.blue : Colors.blue, // Change color for "Added"
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Consumer<ProductsVM>(
              builder: (context, value, child) {
                bool isInWishlist = value.isInWishlist(itemName);

                return IconButton(
                  icon: Icon(
                    isInWishlist ? Icons.favorite : Icons.favorite_border,
                    color: isInWishlist ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    if (isInWishlist) {
                      value.removeFromWishlist(itemName); // Remove from wishlist
                    } else {
                      value.addToWishlist(image, itemName); // Add to wishlist
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
