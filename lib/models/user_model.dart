
class UserModel {
  String id;
  String userName;
  String mobileNumber;
  String age;
  String gender;
  String email;
  String password;
  String token;
  UserModel(
      {required this.id,
      required this.userName,
      required this.mobileNumber,
      required this.age,
      required this.gender,
      required this.email,
      required this.token,
      required this.password});

  // Factory method to create a User from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json["token"] ?? "",
      password: json['password'] ?? "",
      id: json['id'] ?? "",
      userName: json['userName'] ?? "",
      mobileNumber: json['mobileNumber'] ?? "",
      age: json['age'].toString() ?? "",
      gender: json['gender'] ?? "",
      email: json['email'] ?? "",
    );
  }

  // Method to convert a User instance to JSON
  Map<String, String> toJson() {
    return {
      'id': id,
      'userName': userName,
      'mobileNumber': mobileNumber,
      'age': age.toString(),
      'gender': gender,
      'email': email,
      'password': password
    };
  }
}
