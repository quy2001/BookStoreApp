// To parse this JSON data, do
//
//     final searchBookRequest = searchBookRequestFromJson(jsonString);

import 'dart:convert';

SearchBookRequest searchBookRequestFromJson(String str) => SearchBookRequest.fromJson(json.decode(str));

String searchBookRequestToJson(SearchBookRequest data) => json.encode(data.toJson());

class SearchBookRequest {
  int idAuthor;
  int idCategory;
  int page;
  String name;

  SearchBookRequest({
    required this.idAuthor,
    required this.idCategory,
    required this.page,
    required this.name,
  });

  factory SearchBookRequest.fromJson(Map<String, dynamic> json) => SearchBookRequest(
    idAuthor: json["idAuthor"],
    idCategory: json["idCategory"],
    page: json["page"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "idAuthor": idAuthor,
    "idCategory": idCategory,
    "page": page,
    "name": name,
  };
}
