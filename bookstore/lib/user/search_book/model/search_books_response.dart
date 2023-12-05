// To parse this JSON data, do
//
//     final searchBookResponse = searchBookResponseFromJson(jsonString);

import 'dart:convert';

SearchBookResponse searchBookResponseFromJson(String str) => SearchBookResponse.fromJson(json.decode(str));

String searchBookResponseToJson(SearchBookResponse data) => json.encode(data.toJson());

class SearchBookResponse {
  int success;
  List<SearchBook>? data;

  SearchBookResponse({
    required this.success,
    required this.data,
  });

  factory SearchBookResponse.fromJson(Map<String, dynamic> json) => SearchBookResponse(
    success: json["success"],
    data: List<SearchBook>.from((json["data"] ?? []).map((x) => SearchBook.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
  };
}

class SearchBook {
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
  String status;

  SearchBook({
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
    required this.status,
  });

  factory SearchBook.fromJson(Map<String, dynamic> json) => SearchBook(
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
    status: json["status"],
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
    "status": status,
  };
}