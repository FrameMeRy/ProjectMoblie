// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    int? id;
    String? namep;
    String? detailp;
    String? pricep;
    String? amountp;

    Product({
        this.id,
        this.namep,
        this.detailp,
        this.pricep,
        this.amountp,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        namep: json["namep"],
        detailp: json["detailp"],
        pricep: json["pricep"],
        amountp: json["amountp"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "namep": namep,
        "detailp": detailp,
        "pricep": pricep,
        "amountp": amountp,
    };
}
