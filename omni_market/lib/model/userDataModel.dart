// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
    List<Datum>? data;
    String? token;

    UserDataModel({
        this.data,
        this.token,
    });

    factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "token": token,
    };
}

class Datum {
    List<dynamic>? sellerCategory;
    String? id;
    String? name;
    String? email;
    String? password;
    String? role;
    bool? isDeleted;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? contact;

    Datum({
        this.sellerCategory,
        this.id,
        this.name,
        this.email,
        this.password,
        this.role,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.contact,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        sellerCategory: json["seller_category"] == null ? [] : List<dynamic>.from(json["seller_category"]!.map((x) => x)),
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        contact: json["contact"],
    );

    Map<String, dynamic> toJson() => {
        "seller_category": sellerCategory == null ? [] : List<dynamic>.from(sellerCategory!.map((x) => x)),
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "role": role,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "contact": contact,
    };
}
