// To parse this JSON data, do
//
//     final authoByIdResponse = authoByIdResponseFromJson(jsonString);

import 'dart:convert';

AuthoByIdResponse authoByIdResponseFromJson(String str) => AuthoByIdResponse.fromJson(json.decode(str));

String authoByIdResponseToJson(AuthoByIdResponse data) => json.encode(data.toJson());

class AuthoByIdResponse {
  int success;
  Data data;

  AuthoByIdResponse({
    required this.success,
    required this.data,
  });

  factory AuthoByIdResponse.fromJson(Map<String, dynamic> json) => AuthoByIdResponse(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  int id;
  String name;

  Data({
    required this.id,
    required this.name,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}