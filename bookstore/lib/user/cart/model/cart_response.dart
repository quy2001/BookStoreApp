// To parse this JSON data, do
//
//     final cartResponse = cartResponseFromJson(jsonString);

import 'dart:convert';

CartResponse cartResponseFromJson(String str) => CartResponse.fromJson(json.decode(str));

String cartResponseToJson(CartResponse data) => json.encode(data.toJson());

class CartResponse {
  int success;
  List<Cart>? data;

  CartResponse({
    required this.success,
    required this.data,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
    success: json["success"],
    data: List<Cart>.from((json["data"] ?? []).map((x) => Cart.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
  };
}

class Cart {
  int id;
  int idUser;
  int idBook;
  int status;

  Cart({
    required this.id,
    required this.idUser,
    required this.idBook,
    required this.status,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"],
    idUser: json["idUser"],
    idBook: json["idBook"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idUser": idUser,
    "idBook": idBook,
    "status": status,
  };
}
