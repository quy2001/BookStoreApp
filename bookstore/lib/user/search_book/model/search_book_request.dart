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
  int userid;

  SearchBookRequest({
    required this.idAuthor,
    required this.idCategory,
    required this.page,
    required this.name,
    required this.userid,
  });

  factory SearchBookRequest.fromJson(Map<String, dynamic> json) => SearchBookRequest(
    idAuthor: json["idAuthor"],
    idCategory: json["idCategory"],
    page: json["page"],
    name: json["name"],
    userid: json["userid"],
  );

  Map<String, dynamic> toJson() => {
    "idAuthor": idAuthor,
    "idCategory": idCategory,
    "page": page,
    "name": name,
    "userid": userid,
  };
}