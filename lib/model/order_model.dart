class Order {
  final List<Map<String, dynamic>> items;
  final double totalPrice;
  final DateTime orderDate;
  final String name;
  final String size;
  final String address;

  Order({
    required this.items,
    required this.totalPrice,
    required this.orderDate,
    required this.name,
    required this.size,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
    'items': items,
    'totalPrice': totalPrice,
    'orderDate': orderDate.toIso8601String(),
    'name': name,
    'size': size,
    'address': address,
  };
}
