// To parse this JSON data, do
//
//     final bookcaseResponse = bookcaseResponseFromJson(jsonString);

import 'dart:convert';

BookcaseResponse bookcaseResponseFromJson(String str) => BookcaseResponse.fromJson(json.decode(str));

String bookcaseResponseToJson(BookcaseResponse data) => json.encode(data.toJson());

class BookcaseResponse {
  int success;
  List<Bookcase>? data;

  BookcaseResponse({
    required this.success,
    required this.data,
  });

  factory BookcaseResponse.fromJson(Map<String, dynamic> json) => BookcaseResponse(
    success: json["success"],
    data: List<Bookcase>.from((json["data"] ?? []).map((x) => Bookcase.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
  };
}

class Bookcase {
  int id;
  int idUser;
  int idBook;
  int status;
  String bname;
  int bprice;
  String bimage;

  Bookcase({
    required this.id,
    required this.idUser,
    required this.idBook,
    required this.status,
    required this.bname,
    required this.bprice,
    required this.bimage,
  });

  factory Bookcase.fromJson(Map<String, dynamic> json) => Bookcase(
    id: json["id"],
    idUser: json["idUser"],
    idBook: json["idBook"],
    status: json["status"],
    bname: json["bname"],
    bprice: json["bprice"],
    bimage: json["bimage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idUser": idUser,
    "idBook": idBook,
    "status": status,
    "bname": bname,
    "bprice": bprice,
    "bimage": bimage,
  };
}
