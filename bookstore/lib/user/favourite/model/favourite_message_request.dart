// To parse this JSON data, do
//
//     final favouriteMessageRequest = favouriteMessageRequestFromJson(jsonString);

import 'dart:convert';

FavouriteMessageRequest favouriteMessageRequestFromJson(String str) => FavouriteMessageRequest.fromJson(json.decode(str));

String favouriteMessageRequestToJson(FavouriteMessageRequest data) => json.encode(data.toJson());

class FavouriteMessageRequest {
  int success;
  String message;

  FavouriteMessageRequest({
    required this.success,
    required this.message,
  });

  factory FavouriteMessageRequest.fromJson(Map<String, dynamic> json) => FavouriteMessageRequest(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}