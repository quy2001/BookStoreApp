// To parse this JSON data, do
//
//     final loginUserRequest = loginUserRequestFromJson(jsonString);

import 'dart:convert';

LoginUserRequest loginUserRequestFromJson(String str) => LoginUserRequest.fromJson(json.decode(str));

String loginUserRequestToJson(LoginUserRequest data) => json.encode(data.toJson());

class LoginUserRequest {
  String name;
  String password;

  LoginUserRequest({
    required this.name,
    required this.password,
  });

  factory LoginUserRequest.fromJson(Map<String, dynamic> json) => LoginUserRequest(
    name: json["name"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "password": password,
  };
}
