// To parse this JSON data, do
//
//     final cartNotification = cartNotificationFromJson(jsonString);

import 'dart:convert';

CartNotification cartNotificationFromJson(String str) => CartNotification.fromJson(json.decode(str));

String cartNotificationToJson(CartNotification data) => json.encode(data.toJson());

class CartNotification {
  int success;
  String message;

  CartNotification({
    required this.success,
    required this.message,
  });

  factory CartNotification.fromJson(Map<String, dynamic> json) => CartNotification(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
