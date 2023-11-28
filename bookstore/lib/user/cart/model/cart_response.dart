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
  String bname;
  int bprice;
  String bimage;

  Cart({
    required this.id,
    required this.idUser,
    required this.idBook,
    required this.status,
    required this.bname,
    required this.bprice,
    required this.bimage,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"],
    idUser: json["idUser"],
    idBook: json["idBook"],
    status: json["status"],
    bname: json["bname"],
    bprice: json["bprice"],
    bimage: json["bimage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idUser": idUser,
    "idBook": idBook,
    "status": status,
    "bname": bname,
    "bprice": bprice,
    "bimage": bimage,
  };
}