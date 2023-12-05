// To parse this JSON data, do
//
//     final authorResponse = authorResponseFromJson(jsonString);

import 'dart:convert';

AuthorResponse authorResponseFromJson(String str) => AuthorResponse.fromJson(json.decode(str));

String authorResponseToJson(AuthorResponse data) => json.encode(data.toJson());

class AuthorResponse {
  int success;
  List<Author>? data;

  AuthorResponse({
    required this.success,
    required this.data,
  });

  factory AuthorResponse.fromJson(Map<String, dynamic> json) => AuthorResponse(
    success: json["success"],
    data: List<Author>.from((json["data"] ?? []).map((x) => Author.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
  };
}

class Author {
  int id;
  String name;

  Author({
    required this.id,
    required this.name,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}