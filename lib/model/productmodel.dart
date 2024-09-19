class Products {
  Products({
    required this.name,
    required this.image,
    this.quantity = 1, // Default quantity set to 1
  });

  String name;
  String image;
  int quantity; // Added quantity field

  // Convert to JSON including the quantity
  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "quantity": quantity, // Include quantity in JSON
      };
}
