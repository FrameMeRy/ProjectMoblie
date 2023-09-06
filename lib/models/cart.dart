// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';
List<Cart> cartFromJson(String str) => List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));


String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
    int? id;
    String? namec;
    String? detailc;
    String? pricec;
    String? photoc;

    Cart({
        this.id,
        this.namec,
        this.detailc,
        this.pricec,
        this.photoc,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        namec: json["namec"],
        detailc: json["detailc"],
        pricec: json["pricec"],
        photoc: json["photoc"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "namec": namec,
        "detailc": detailc,
        "pricec": pricec,
        "photoc": photoc,
    };
}
