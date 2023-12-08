// To parse this JSON data, do
//
//     final favouriteRequest = favouriteRequestFromJson(jsonString);

import 'dart:convert';

FavouriteRequest favouriteRequestFromJson(String str) => FavouriteRequest.fromJson(json.decode(str));

String favouriteRequestToJson(FavouriteRequest data) => json.encode(data.toJson());

class FavouriteRequest {
  int idUser;
  int idBook;

  FavouriteRequest({
    required this.idUser,
    required this.idBook,
  });

  factory FavouriteRequest.fromJson(Map<String, dynamic> json) => FavouriteRequest(
    idUser: json["idUser"],
    idBook: json["idBook"],
  );

  Map<String, dynamic> toJson() => {
    "idUser": idUser,
    "idBook": idBook,
  };
}
