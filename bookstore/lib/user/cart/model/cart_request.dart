// To parse this JSON data, do
//
//     final cartRequest = cartRequestFromJson(jsonString);

import 'dart:convert';

CartRequest cartRequestFromJson(String str) => CartRequest.fromJson(json.decode(str));

String cartRequestToJson(CartRequest data) => json.encode(data.toJson());

class CartRequest {
  int idUser;
  int idBook;
  bool status;

  CartRequest({
    required this.idUser,
    required this.idBook,
    required this.status,
  });

  factory CartRequest.fromJson(Map<String, dynamic> json) => CartRequest(
    idUser: json["idUser"],
    idBook: json["idBook"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "idUser": idUser,
    "idBook": idBook,
    "status": status,
  };
}
