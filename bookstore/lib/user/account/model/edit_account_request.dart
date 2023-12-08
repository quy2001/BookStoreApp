// To parse this JSON data, do
//
//     final editAccountRequest = editAccountRequestFromJson(jsonString);

import 'dart:convert';

EditAccountRequest editAccountRequestFromJson(String str) => EditAccountRequest.fromJson(json.decode(str));

String editAccountRequestToJson(EditAccountRequest data) => json.encode(data.toJson());

class EditAccountRequest {
  int id;
  String name;
  String email;

  EditAccountRequest({
    required this.id,
    required this.name,
    required this.email,
  });

  factory EditAccountRequest.fromJson(Map<String, dynamic> json) => EditAccountRequest(
    id: json["id"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
  };
}