import 'dart:convert';

import 'package:millyshb/models/product_model.dart';



class CartItem {
  final String id;
  final Product product;
  final int quantity;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
  });
//  Cart _cart = Cart(id: '', user: '', products: [], createdAt: DateTime.now(), updatedAt: DateTime.now(), version: 0);
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['_id'],
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}

class Cart {
  final String id;
  final String user;
  final List<CartItem> products;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  Cart({
    required this.id,
    required this.user,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    var productsList = json['products'] as List;
    List<CartItem> products = productsList.map((i) => CartItem.fromJson(i)).toList();

    return Cart(
      id: json['_id'],
      user: json['user'],
      products: products,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'products': products.map((i) => i.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}

void main() {
  // Example JSON data
  String jsonData = '''
  {
    "success": true,
    "status": 200,
    "message": "Cart fetched successfully!",
    "data": {
      "_id": "66acb662c9d8f6d881382e7c",
      "user": "66a5e81a61cbe653080376be",
      "products": [
        {
          "product": {
            "_id": "669e12afe7fc24dc7b5b5607",
            "name": "Revlon Makeup Brush",
            "price": 15.49,
            "description": "Revlon Blending Brush for Professional Makeup",
            "subcategory": "6699088a85b13a13a7ee7daf",
            "image": "https://res.cloudinary.com/dqhh1rff5/image/upload/v1722194860/Blog/gwvd3q1gi0ctsi43bae8.png",
            "stock": 150,
            "createdAt": "2024-07-22T08:05:03.519Z",
            "updatedAt": "2024-08-01T17:35:35.537Z",
            "__v": 0,
            "discount": 0
          },
          "quantity": 11,
          "_id": "66acb662c9d8f6d881382e7e"
        },
        {
          "product": {
            "_id": "669e12e7e7fc24dc7b5b560d",
            "name": "L'Oreal Paris Lipstick",
            "price": 10.99,
            "description": "L'Oreal Paris Colour Riche Lipcolour, Fairest Nude",
            "subcategory": "6699088a85b13a13a7ee7daf",
            "image": "https://res.cloudinary.com/dqhh1rff5/image/upload/v1722194878/Blog/s5tfz0kgxrpzs2jycogk.png",
            "stock": 244,
            "createdAt": "2024-07-22T08:05:59.782Z",
            "updatedAt": "2024-08-01T16:38:58.212Z",
            "__v": 0,
            "discount": 0
          },
          "quantity": 1,
          "_id": "66acb66fc9d8f6d881382e83"
        }
      ],
      "createdAt": "2024-08-02T10:35:14.490Z",
      "updatedAt": "2024-08-02T10:42:19.662Z",
      "__v": 1
    }
  }
  ''';

  // Parse JSON data
  Map<String, dynamic> jsonMap = json.decode(jsonData);
  Cart cart = Cart.fromJson(jsonMap['data']);

  // Print parsed data
  print(cart);
}
