import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/viewmodel/productVM.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    required Key key,
    required this.screenSize,
    required this.image,
    required this.itemName,
  }) : super(key: key);

  final Size screenSize;
  final String image, itemName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: screenSize.height * 0.2,
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
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            // Add CachedNetworkImage logic or any other image widget
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(itemName),
          ),
          Consumer<ProductsVM>(
            builder: (context, value, child) {
              bool isAdded = value.isAlreadyAdded(itemName);
              return InkWell(
                onTap: () {
                  if (!isAdded) {
                    value.add(image, itemName);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: screenSize.height * 0.03,
                    width: screenSize.width * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: isAdded ? Colors.blue : Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        isAdded ? "Added" : "ADD",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
