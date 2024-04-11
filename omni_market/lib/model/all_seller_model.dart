// To parse this JSON data, do
//
//     final allSellerModel = allSellerModelFromJson(jsonString);

import 'dart:convert';

AllSellerModel allSellerModelFromJson(String str) =>
    AllSellerModel.fromJson(json.decode(str));

String allSellerModelToJson(AllSellerModel data) => json.encode(data.toJson());

class AllSellerModel {
  String? status;
  List<Datum>? data;

  AllSellerModel({
    this.status,
    this.data,
  });

  factory AllSellerModel.fromJson(Map<String, dynamic> json) => AllSellerModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  dynamic profile;
  String? id;
  String? name;
  String? email;
  String? contact;
  String? password;
  List<String>? sellerCategory;
  String? role;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.profile,
    this.id,
    this.name,
    this.email,
    this.contact,
    this.password,
    this.sellerCategory,
    this.role,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        profile: json["profile"],
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        contact: json["contact"],
        password: json["password"],
        sellerCategory: json["seller_category"] == null
            ? []
            : List<String>.from(json["seller_category"]!.map((x) => x)),
        role: json["role"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "profile": profile,
        "_id": id,
        "name": name,
        "email": email,
        "contact": contact,
        "password": password,
        "seller_category": sellerCategory == null
            ? []
            : List<dynamic>.from(sellerCategory!.map((x) => x)),
        "role": role,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
