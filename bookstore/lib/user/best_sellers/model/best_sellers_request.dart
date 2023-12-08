// To parse this JSON data, do
//
//     final bestSellerRequest = bestSellerRequestFromJson(jsonString);

import 'dart:convert';

BestSellersRequest bestSellersRequestFromJson(String str) => BestSellersRequest.fromJson(json.decode(str));

String bestSellersRequestToJson(BestSellersRequest data) => json.encode(data.toJson());

class BestSellersRequest {
  int idUser;
  String bname;

  BestSellersRequest({
    required this.idUser,
    required this.bname,
  });

  factory BestSellersRequest.fromJson(Map<String, dynamic> json) => BestSellersRequest(
    idUser: json["idUser"],
    bname: json["bname"],
  );

  Map<String, dynamic> toJson() => {
    "idUser": idUser,
    "bname": bname,
  };
}
