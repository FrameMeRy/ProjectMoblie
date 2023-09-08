// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';
List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));


String productToJson(Product data) => json.encode(data.toJson());

class Product {
    int? id;
    String? namep;
    String? detailp;
    String? pricep;
    String? photo;
    String? count;

    Product({
        this.id,
        this.namep,
        this.detailp,
        this.pricep,
        this.photo,
        this.count,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        namep: json["namep"],
        detailp: json["detailp"],
        pricep: json["pricep"],
        photo: json["photo"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "namep": namep,
        "detailp": detailp,
        "pricep": pricep,
        "photo": photo,
        "count": count,
    };
}
