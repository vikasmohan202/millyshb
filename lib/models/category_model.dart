class ProductCategory {
  String title;

  String id;
  String pictureUrl;

  ProductCategory({
    required this.title,
    required this.id,
    required this.pictureUrl,
  });

  // Convert a Category object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'pictureUrl': pictureUrl,
    };
  }

  // Create a Category object from a JSON map
  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      title: json['title'],
      id: json['_id'],
      pictureUrl: json['image'],
    );
  }
}
