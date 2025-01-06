
// Enum for address type
enum AddressType {
  HOME,
  WORK,
}

class Address {
  String name;
  String userId;
  String addressId;
  String houseNumber;
  String mobileNumber;
  String street;
  String city;
  String state;
  String postalCode;
  String country;
  AddressType addressType;

  Address({
    required this.houseNumber,
    required this.userId,
    this.addressId = '',
    required this.name,
    required this.mobileNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.addressType,
  });

  // Factory constructor to create an Address from a JSON map
  factory Address.fromJson(Map<String, dynamic> json) {
    // Set default addressType to AddressType.home if json['addressType'] is null or invalid
    AddressType addressType = AddressType.values.firstWhere(
      (e) => e.toString() == 'AddressType.${json['addressType']}',
      orElse: () => AddressType.HOME, // Provide a default value
    );
    print(json["_id"]);
    return Address(
      houseNumber: json["houseNumber"] ?? "",
      userId: json["user"],
      addressId: json["_id"] ?? "",
      mobileNumber: json["contactNumber"] ?? "",
      name: json["receiverName"] ?? "",
      street: json['area'] ?? "",
      city: json['city'] ?? "",
      state: json['state'] ?? "",
      postalCode: json['pinCode'] ?? "",
      country: json['country'] ?? "",
      addressType: addressType,
    );
  }

  // Method to convert an Address to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'houseNumber': houseNumber,
      'userId': userId,
      'addressId': addressId,
      'mobileNumber': mobileNumber,
      'name': name,
      'area': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'addressType': addressType.toString().split('.').last,
    };
  }
}
