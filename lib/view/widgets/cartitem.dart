import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    required Key key,
    required this.screenSize,
    required this.image,
    required this.itemName,
    required this.del, // Deletion method
  }) : super(key: key);

  final Size screenSize;
  final String image, itemName;
  final Function del; // Delete function passed from the parent

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0), // Margin adjusted
      width: screenSize.width, // Full width of the screen
      height: screenSize.height * 0.15,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            offset: Offset(0, 0),
            blurRadius: 3,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          // Display image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: screenSize.width * 0.4, // Adjust image width if needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(image), // Ensure the correct image is passed here
                  fit: BoxFit.cover,
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
                // Display item name
                Text(
                  itemName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
               // Uncomment and use delete button if needed
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => del(), // Call the delete function
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
