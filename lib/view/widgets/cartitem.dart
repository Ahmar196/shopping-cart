import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/viewmodel/themeprovider.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    required Key key,
    required this.screenSize,
    required this.image,
    required this.itemName,
    required this.del, // Deletion method
    required this.quantity, // Quantity of the product
    required this.increment, // Increment function
    required this.decrement, // Decrement function
  }) : super(key: key);

  final Size screenSize;
  final String image, itemName;
  final Function del; // Delete function passed from the parent
  final int quantity; // Quantity of the item
  final Function increment; // Function to increment quantity
  final Function decrement; // Function to decrement quantity

  @override
  Widget build(BuildContext context) {
    // Get the current theme mode from the ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Set background and shadow colors based on dark mode
    final backgroundColor = themeProvider.isDarkMode ? Colors.grey[800] : Colors.white;
    final shadowColor = themeProvider.isDarkMode ? Colors.black.withOpacity(0.3) : Colors.blue.withOpacity(0.3);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0), // Margin adjusted
      width: screenSize.width, // Full width of the screen
      height: screenSize.height * 0.15,
      decoration: BoxDecoration(
        color: backgroundColor, // Adapt background color for dark mode
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: shadowColor, // Adapt shadow color for dark mode
            offset: Offset(0, 0),
            blurRadius: 3,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          // Display image with adjusted size
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: screenSize.width * 0.25, // Adjust image width to 25% of screen width
              height: screenSize.height * 0.12, // Adjust image height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(image), // Ensure the correct image is passed here
                  fit: BoxFit.cover, // Make sure the image fits correctly
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display item name with text color based on theme
                Text(
                  itemName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black, // Text color for dark mode
                  ),
                ),
              ],
            ),
          ),
          // Column for increment, quantity, decrement, and delete icons
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Increment button
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  increment(); // Increase quantity
                },
              ),
              // Quantity text centered between increment and decrement
              Text(
                quantity.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              // Decrement button
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  if (quantity > 1) {
                    decrement(); // Decrease quantity
                  }
                },
              ),
            ],
          ),
          // Delete button at the bottom
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () => del(), // Call the delete function
          ),
        ],
      ),
    );
  }
}
