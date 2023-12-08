// To parse this JSON data, do
//
//     final bestSellerResponse = bestSellerResponseFromJson(jsonString);

import 'dart:convert';

BestSellersResponse bestSellerResponseFromJson(String str) => BestSellersResponse.fromJson(json.decode(str));

String bestSellersResponseToJson(BestSellersResponse data) => json.encode(data.toJson());

class BestSellersResponse {
  int success;
  List<BestSellers>? data;

  BestSellersResponse({
    required this.success,
    required this.data,
  });

  factory BestSellersResponse.fromJson(Map<String, dynamic> json) => BestSellersResponse(
    success: json["success"],
    data: List<BestSellers>.from((json["data"] ?? []).map((x) => BestSellers.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from((data ?? []).map((x) => x.toJson())),
  };
}

class BestSellers {
  int idBook;
  int tongBan;
  String bname;
  int bprice;
  String bimage;
  String status;
  String statusFavourite;

  BestSellers({
    required this.idBook,
    required this.tongBan,
    required this.bname,
    required this.bprice,
    required this.bimage,
    required this.status,
    required this.statusFavourite,
  });

  factory BestSellers.fromJson(Map<String, dynamic> json) => BestSellers(
    idBook: json["idBook"],
    tongBan: json["tongBan"],
    bname: json["bname"],
    bprice: json["bprice"],
    bimage: json["bimage"],
    status: json["status"],
    statusFavourite: json["statusFavourite"],
  );

  Map<String, dynamic> toJson() => {
    "idBook": idBook,
    "tongBan": tongBan,
    "bname": bname,
    "bprice": bprice,
    "bimage": bimage,
    "status": status,
    "statusFavourite": statusFavourite,
  };
}
