// To parse this JSON data, do
//
//     final pay = payFromJson(jsonString);

import 'dart:convert';

Pay payFromJson(String str) => Pay.fromJson(json.decode(str));

String payToJson(Pay data) => json.encode(data.toJson());

class Pay {
    int? id;
    String? namepa;
    String? pricepa;
    String? amountpa;
    String? addressp;
    String? deliveryFee;

    Pay({
        this.id,
        this.namepa,
        this.pricepa,
        this.amountpa,
        this.addressp,
        this.deliveryFee,
    });

    factory Pay.fromJson(Map<String, dynamic> json) => Pay(
        id: json["id"],
        namepa: json["namepa"],
        pricepa: json["pricepa"],
        amountpa: json["amountpa"],
        addressp: json["addressp"],
        deliveryFee: json["delivery_fee"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "namepa": namepa,
        "pricepa": pricepa,
        "amountpa": amountpa,
        "addressp": addressp,
        "delivery_fee": deliveryFee,
    };
}
