// To parse this JSON data, do
//
//     final bookcaseRequest = bookcaseRequestFromJson(jsonString);

import 'dart:convert';

BookcaseRequest bookcaseRequestFromJson(String str) => BookcaseRequest.fromJson(json.decode(str));

String bookcaseRequestToJson(BookcaseRequest data) => json.encode(data.toJson());

class BookcaseRequest {
  int idUser;
  String bname;

  BookcaseRequest({
    required this.idUser,
    required this.bname,
  });

  factory BookcaseRequest.fromJson(Map<String, dynamic> json) => BookcaseRequest(
    idUser: json["idUser"],
    bname: json["bname"],
  );

  Map<String, dynamic> toJson() => {
    "idUser": idUser,
    "bname": bname,
  };
}
