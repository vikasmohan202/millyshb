import 'package:millyshb/models/product_model.dart';

// Model for DeliverySlot
class DeliverySlot {
  final String deliverySlotId;
  final String date;
  final String timePeriod;

  DeliverySlot({
    required this.deliverySlotId,
    required this.date,
    required this.timePeriod,
  });

  factory DeliverySlot.fromJson(Map<String, dynamic> json) {
    return DeliverySlot(
      deliverySlotId: json['deliverySlotId'] ?? '',
      date: json['date'] ?? '',
      timePeriod: json['timePeriod'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deliverySlotId': deliverySlotId,
      'date': date,
      'timePeriod': timePeriod,
    };
  }
}

// Model for Item
class Item {
  final Product product;
  final String name;
  final double price;
  final String quantity;
  final String id;

  Item({
    required this.product,
    required this.name,
    required this.price,
    required this.quantity,
    required this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      product: json['product'] != null
          ? Product.fromJson(json['product'])
          : Product(
              id: '',
              name: '',
              price: 12,
              description: '',
              subcategory: '',
              image: '',
              stock: 1,
              discount:
                  1), // Assuming Product.empty() is a default constructor for Product
      name: json['name'] ?? '',
      price: (json['price'] != null
              ? double.tryParse(json['price'].toString())
              : 0.0) ??
          0.0,
      quantity: json['quantity']?.toString() ?? '0',
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'name': name,
      'price': price,
      'quantity': quantity,
      '_id': id,
    };
  }
}

// Model for Order
class Order {
  final DeliverySlot deliverySlot;
  final String id;
  final String orderId;
  final String user;
  final List<Item> items;
  final String expectedDeliveryDate;
  final double totalAmount;
  final bool voucherUsed;
  final String status;

  Order({
    required this.deliverySlot,
    required this.id,
    required this.orderId,
    required this.user,
    required this.items,
    required this.expectedDeliveryDate,
    required this.totalAmount,
    required this.voucherUsed,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      deliverySlot: json['deliverySlot'] != null
          ? DeliverySlot.fromJson(json['deliverySlot'])
          : DeliverySlot(
              deliverySlotId: '',
              date: '',
              timePeriod: '',
            ),
      id: json['_id'] ?? '',
      orderId: json['orderId'] ?? '',
      user: json['user'] ?? '',
      items: (json['items'] as List<dynamic>? ?? [])
          .map((item) => Item.fromJson(item))
          .toList(),
      expectedDeliveryDate: json['expectedDeliveryDate'] ?? '',
      totalAmount:
          (json['totalAmount'] != null ? json['totalAmount'].toDouble() : 0.0),
      voucherUsed: json['voucherUsed'] ?? false,
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deliverySlot': deliverySlot.toJson(),
      '_id': id,
      'orderId': orderId,
      'user': user,
      'items': items.map((item) => item.toJson()).toList(),
      'expectedDeliveryDate': expectedDeliveryDate,
      'totalAmount': totalAmount,
      'voucherUsed': voucherUsed,
      'status': status,
    };
  }
}
