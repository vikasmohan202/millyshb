class DeliverySlot {
  String id;
  DateTime date;
  String price;
  String maxOrders;
  String currentOrders;
  String deliveryType;
  String timePeriod;

  DeliverySlot({
    this.price = '0',
    this.id = '',
    DateTime? date,
    this.maxOrders = '0',
    this.currentOrders = '0',
    this.deliveryType = '',
    this.timePeriod = '',
  }) : date = date ?? DateTime.now();

  // Factory method to create a DeliverySlot from JSON
  factory DeliverySlot.fromJson(Map<String, dynamic> json) {
    return DeliverySlot(
      price: json["deliveryCharge"].toString() ?? '0',
      id: json['_id'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toString()),
      maxOrders: json['maxOrders']?.toString() ?? '0',
      currentOrders: json['currentOrders']?.toString() ?? '0',
      deliveryType: json['deliveryType'] ?? '',
      timePeriod: json['timePeriod'] ?? '',
    );
  }

  // Static method to create a default DeliverySlot
  static DeliverySlot defaultDeliverySlot() {
    return DeliverySlot();
  }
}
