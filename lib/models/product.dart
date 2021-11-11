import 'dart:convert';

class Product {
  Product(
      {required this.available,
      required this.name,
      this.desc,
      this.picture,
      required this.price,
      this.id});

  bool available;
  String name;
  String? desc;
  String? picture;
  double price;
  String? id;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        available: json["available"],
        name: json["name"],
        desc: json["desc"],
        picture: json["picture"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        "desc": desc,
        "picture": picture,
        "price": price,
      };
  Product copy() => Product(
      available: this.available,
      name: this.name,
      desc: this.desc,
      picture: this.picture,
      price: this.price,
      id: this.id);
}
