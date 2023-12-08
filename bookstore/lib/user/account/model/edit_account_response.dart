// To parse this JSON data, do
//
//     final editAccountResponse = editAccountResponseFromJson(jsonString);

import 'dart:convert';

EditAccountResponse editAccountResponseFromJson(String str) => EditAccountResponse.fromJson(json.decode(str));

String editAccountResponseToJson(EditAccountResponse data) => json.encode(data.toJson());

class EditAccountResponse {
  int success;
  DataAccount data;

  EditAccountResponse({
    required this.success,
    required this.data,
  });

  factory EditAccountResponse.fromJson(Map<String, dynamic> json) => EditAccountResponse(
    success: json["success"],
    data: DataAccount.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class DataAccount {
  int id;
  String name;
  String email;

  DataAccount({
    required this.id,
    required this.name,
    required this.email,
  });

  factory DataAccount.fromJson(Map<String, dynamic> json) => DataAccount(
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