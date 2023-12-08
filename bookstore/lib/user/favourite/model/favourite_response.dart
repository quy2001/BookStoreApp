// To parse this JSON data, do
//
//     final favouriteResponse = favouriteResponseFromJson(jsonString);

import 'dart:convert';

FavouriteResponse favouriteResponseFromJson(String str) => FavouriteResponse.fromJson(json.decode(str));

String favouriteResponseToJson(FavouriteResponse data) => json.encode(data.toJson());

class FavouriteResponse {
  int success;
  List<Favourite>? data;

  FavouriteResponse({
    required this.success,
    required this.data,
  });

  factory FavouriteResponse.fromJson(Map<String, dynamic> json) => FavouriteResponse(
    success: json["success"],
    data: List<Favourite>.from((json["data"] ?? []).map((x) => Favourite.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
  };
}

class Favourite {
  int id;
  int idUser;
  int idBook;
  String bname;
  String bimage;

  Favourite({
    required this.id,
    required this.idUser,
    required this.idBook,
    required this.bname,
    required this.bimage,
  });

  factory Favourite.fromJson(Map<String, dynamic> json) => Favourite(
    id: json["id"],
    idUser: json["idUser"],
    idBook: json["idBook"],
    bname: json["bname"],
    bimage: json["bimage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idUser": idUser,
    "idBook": idBook,
    "bname": bname,
    "bimage": bimage,
  };
}