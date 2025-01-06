class SubCategory {
  String title;
  String id;
  String pictureUrl;
  String categoryId;

  SubCategory({
    required this.title,
    required this.id,
    required this.pictureUrl,
    required this.categoryId,
  });

  // Convert a SubCategory object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'pictureUrl': pictureUrl,
    };
  }

  // Create a SubCategory object from a JSON map
  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      categoryId: json['parentCategory'] ?? '',
      title: json['title'] ?? "",
      id: json['_id'] ?? "",
      pictureUrl: json['image'] ?? "",
    );
  }
}
