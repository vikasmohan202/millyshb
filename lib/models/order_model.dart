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
      deliverySlotId: json['deliverySlotId'],
      date: json['date'],
      timePeriod: json['timePeriod'],
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

// Model for Product

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
      product: Product.fromJson(json['product']),
      name: json['name'],
      price: double.parse(json['price'].toString()),
      quantity: json['quantity'].toString(),
      id: json['_id'],
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
      deliverySlot: DeliverySlot.fromJson(json['deliverySlot']),
      id: json['_id'],
      orderId: json['orderId'],
      user: json['user'],
      items: List<Item>.from(json['items'].map((item) => Item.fromJson(item))),
      expectedDeliveryDate: json['expectedDeliveryDate'],
      totalAmount: json['totalAmount'].toDouble(),
      voucherUsed: json['voucherUsed'],
      status: json['status'],
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
