// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
    int? id;
    String? namec;
    String? pricec;
    String? amountc;

    Cart({
        this.id,
        this.namec,
        this.pricec,
        this.amountc,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        namec: json["namec"],
        pricec: json["pricec"],
        amountc: json["amountc"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "namec": namec,
        "pricec": pricec,
        "amountc": amountc,
    };
}
