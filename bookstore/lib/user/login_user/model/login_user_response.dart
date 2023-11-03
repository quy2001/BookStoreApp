// To parse this JSON data, do
//
//     final loginUserResponse = loginUserResponseFromJson(jsonString);

import 'dart:convert';

LoginUserResponse loginUserResponseFromJson(String str) => LoginUserResponse.fromJson(json.decode(str));

String loginUserResponseToJson(LoginUserResponse data) => json.encode(data.toJson());

class LoginUserResponse {
  bool status;
  Data? data;

  LoginUserResponse({
    required this.status,
    required this.data,
  });

  factory LoginUserResponse.fromJson(Map<String, dynamic> json) => LoginUserResponse(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  User user;
  String token;

  Data({
    required this.user,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "token": token,
  };
}

class User {
  int id;
  String name;
  String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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