// To parse this JSON data, do
//
//     final customerPostReq = customerPostReqFromJson(jsonString);

import 'dart:convert';

CustomerPostReq customerPostReqFromJson(String str) =>
    CustomerPostReq.fromJson(json.decode(str));

String customerPostReqToJson(CustomerPostReq data) =>
    json.encode(data.toJson());

class CustomerPostReq {
  String fullname;
  String phone;
  String email;
  String image;
  String password;

  CustomerPostReq({
    required this.fullname,
    required this.phone,
    required this.email,
    required this.image,
    required this.password,
  });

  factory CustomerPostReq.fromJson(Map<String, dynamic> json) =>
      CustomerPostReq(
        fullname: json["fullname"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "phone": phone,
        "email": email,
        "image": image,
        "password": password,
      };
}
