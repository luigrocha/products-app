// To parse this JSON data, do
//
//     final produc = producFromMap(jsonString);

import 'dart:convert';

class Produc {
  Produc({
    required this.available,
    required this.name,
    this.picture,
    required this.price,
  });

  bool available;
  String name;
  String? picture;
  double price;

  factory Produc.fromJson(String str) => Produc.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Produc.fromMap(Map<String, dynamic> json) => Produc(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
      };
}
