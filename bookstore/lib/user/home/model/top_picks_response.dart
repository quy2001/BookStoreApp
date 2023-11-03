// To parse this JSON data, do
//
//     final topPickResponse = topPickResponseFromJson(jsonString);

import 'dart:convert';

TopPickResponse topPickResponseFromJson(String str) => TopPickResponse.fromJson(json.decode(str));

String topPickResponseToJson(TopPickResponse data) => json.encode(data.toJson());

class TopPickResponse {
  int success;
  List<TopPick> data;

  TopPickResponse({
    required this.success,
    required this.data,
  });

  factory TopPickResponse.fromJson(Map<String, dynamic> json) => TopPickResponse(
    success: json["success"],
    data: List<TopPick>.from(json["data"].map((x) => TopPick.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TopPick {
  int id;
  String name;
  int idAuthor;
  int idCategory;
  String description;
  String cover;
  String file;
  int price;

  TopPick({
    required this.id,
    required this.name,
    required this.idAuthor,
    required this.idCategory,
    required this.description,
    required this.cover,
    required this.file,
    required this.price,
  });

  factory TopPick.fromJson(Map<String, dynamic> json) => TopPick(
    id: json["id"],
    name: json["name"],
    idAuthor: json["idAuthor"],
    idCategory: json["idCategory"],
    description: json["description"],
    cover: json["cover"],
    file: json["file"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "idAuthor": idAuthor,
    "idCategory": idCategory,
    "description": description,
    "cover": cover,
    "file": file,
    "price": price,
  };
}
