// To parse this JSON data, do
//
//     final accountResponse = accountResponseFromJson(jsonString);

import 'dart:convert';

AccountResponse accountResponseFromJson(String str) => AccountResponse.fromJson(json.decode(str));

String accountResponseToJson(AccountResponse data) => json.encode(data.toJson());

class AccountResponse {
  int success;
  Account data;

  AccountResponse({
    required this.success,
    required this.data,
  });

  factory AccountResponse.fromJson(Map<String, dynamic> json) => AccountResponse(
    success: json["success"],
    data: Account.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Account {
  int id;
  String name;
  String email;
  String password;

  Account({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
  };
}