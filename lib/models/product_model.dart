class Product {
  final String id;
  final String name;
  double price;
  final String description;
  final String subcategory;
  final String image;
  final int stock;
  int discount;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.subcategory,
    required this.image,
    required this.stock,
    required this.discount,
  });

  // Factory method to create a Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(), // To handle if price is an int
      description: json['description'],
      subcategory: json['subcategory'],
      image: json['image'],
      stock: json['stock'],
      discount: json['discount'] ?? 0,
    );
  }
  factory Product.JsonForCart(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(), // To handle if price is an int
      description: json['description'],
      subcategory: json['subcategory'],
      image: json['image'],
      stock: json['stock'],
      discount: json['discount'],
    );
  }

  // Method to convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'description': description,
      'subcategory': subcategory,
      'image': image,
      'stock': stock,
      'discount': discount,
    };
  }
}
