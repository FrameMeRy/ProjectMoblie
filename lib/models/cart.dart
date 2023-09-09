// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';
List<Cart> cartFromJson(String str) => List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));


class Cart {
    String? namec;
    String? detailc;
    String? pricec;
    String? photoc;
    String? countc;
    int? id;

    Cart({
        this.namec,
        this.detailc,
        this.pricec,
        this.photoc,
        this.countc,
        this.id,
    });

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        namec: json["namec"],
        detailc: json["detailc"],
        pricec: json["pricec"],
        photoc: json["photoc"],
        countc: json["countc"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "namec": namec,
        "detailc": detailc,
        "pricec": pricec,
        "photoc": photoc,
        "countc": countc,
        "id": id,
    };
}
