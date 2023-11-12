// To parse this JSON data, do
//
//     final bookResponse = bookResponseFromJson(jsonString);

import 'dart:convert';

BookResponse bookResponseFromJson(String str) => BookResponse.fromJson(json.decode(str));

String bookResponseToJson(BookResponse data) => json.encode(data.toJson());

class BookResponse {
  int success;
  Book data;

  BookResponse({
    required this.success,
    required this.data,
  });

  factory BookResponse.fromJson(Map<String, dynamic> json) => BookResponse(
    success: json["success"],
    data: Book.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Book {
  int id;
  String name;
  int idAuthor;
  int idCategory;
  String description;
  String cover;
  String file;
  int price;
  String cname;
  String aname;

  Book({
    required this.id,
    required this.name,
    required this.idAuthor,
    required this.idCategory,
    required this.description,
    required this.cover,
    required this.file,
    required this.price,
    required this.cname,
    required this.aname,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"],
    name: json["name"],
    idAuthor: json["idAuthor"],
    idCategory: json["idCategory"],
    description: json["description"],
    cover: json["cover"],
    file: json["file"],
    price: json["price"],
    cname: json["cname"],
    aname: json["aname"],
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
    "cname": cname,
    "aname": aname,
  };
}