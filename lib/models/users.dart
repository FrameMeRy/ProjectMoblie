// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
    int? id;
    String? user;
    String? password;
    String? name;
    String? lastname;
    String? accountNumber;
    String? address;
    String? gender;

    Users({
        this.id,
        this.user,
        this.password,
        this.name,
        this.lastname,
        this.accountNumber,
        this.address,
        this.gender,
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        user: json["user"],
        password: json["password"],
        name: json["name"],
        lastname: json["lastname"],
        accountNumber: json["account_number"],
        address: json["address"],
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "password": password,
        "name": name,
        "lastname": lastname,
        "account_number": accountNumber,
        "address": address,
        "gender": gender,
    };
}
