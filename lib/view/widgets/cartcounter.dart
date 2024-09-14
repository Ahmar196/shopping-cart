import 'package:flutter/material.dart';

class CartCounter extends StatelessWidget {
  const CartCounter({
    required Key key,
    required this.count,
  }) : super(key: key);

  final String count;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 16,
        width: 16,
        decoration:
            BoxDecoration(color: Colors.red[800], shape: BoxShape.circle),
        child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                        count ?? "0",
                        style: TextStyle(color: Colors.white, fontSize:12),
                      ),
            )));
  }
}