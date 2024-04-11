// To parse this JSON data, do
//
//     final viewPostModel = viewPostModelFromJson(jsonString);

import 'dart:convert';

ViewPostModel viewPostModelFromJson(String str) =>
    ViewPostModel.fromJson(json.decode(str));

String viewPostModelToJson(ViewPostModel data) => json.encode(data.toJson());

class ViewPostModel {
  String? status;
  List<Datum>? data;

  ViewPostModel({
    this.status,
    this.data,
  });

  factory ViewPostModel.fromJson(Map<String, dynamic> json) => ViewPostModel(
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
  List<String>? polishType;
  String? id;
  BuyerId? buyerId;
  String? diamondImage;
  List<String>? diamondName;
  List<String>? qualityOfRough;
  List<String>? cutOfDiamond;
  List<String>? polishColor;
  String? diamondKarate;
  String? diamondQty;
  String? rating;
  String? description;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.polishType,
    this.id,
    this.buyerId,
    this.diamondImage,
    this.diamondName,
    this.qualityOfRough,
    this.cutOfDiamond,
    this.polishColor,
    this.description,
    this.diamondKarate,
    this.diamondQty,
    this.rating,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        polishType: json["polish_type"] == null
            ? []
            : List<String>.from(json["polish_type"]!.map((x) => x)),
        id: json["_id"],
        buyerId: json["buyer_id"] == null
            ? null
            : BuyerId.fromJson(json["buyer_id"]),
        diamondImage: json["diamond_image"],
        diamondName: json["diamond_name"] == null
            ? []
            : List<String>.from(json["diamond_name"]!.map((x) => x)),
        qualityOfRough: json["quality_of_rough"] == null
            ? []
            : List<String>.from(json["quality_of_rough"]!.map((x) => x)),
        cutOfDiamond: json["cut_of_diamond"] == null
            ? []
            : List<String>.from(json["cut_of_diamond"]!.map((x) => x)),
        polishColor: json["polish_color"] == null
            ? []
            : List<String>.from(json["polish_color"]!.map((x) => x)),
        diamondKarate: json["diamond_karate"],
        diamondQty: json["diamond_qty"],
        rating: json["rating"],
        description: json["description"],
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
        "polish_type": polishType == null
            ? []
            : List<dynamic>.from(polishType!.map((x) => x)),
        "_id": id,
        "buyer_id": buyerId?.toJson(),
        "diamond_image": diamondImage,
        "diamond_name": diamondName == null
            ? []
            : List<dynamic>.from(diamondName!.map((x) => x)),
        "quality_of_rough": qualityOfRough == null
            ? []
            : List<dynamic>.from(qualityOfRough!.map((x) => x)),
        "cut_of_diamond": cutOfDiamond == null
            ? []
            : List<dynamic>.from(cutOfDiamond!.map((x) => x)),
        "polish_color": polishColor == null
            ? []
            : List<dynamic>.from(polishColor!.map((x) => x)),
        "diamond_karate": diamondKarate,
        "diamond_qty": diamondQty,
        "rating": rating,
        "description": description,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class BuyerId {
  List<dynamic>? sellerCategory;
  String? id;
  String? name;
  String? email;
  String? password;
  String? role;
  String? fcmToken;
  bool? isVerified;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? contact;

  BuyerId({
    this.sellerCategory,
    this.id,
    this.name,
    this.email,
    this.password,
    this.role,
    this.isVerified,
    this.isDeleted,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.contact,
  });

  factory BuyerId.fromJson(Map<String, dynamic> json) => BuyerId(
        sellerCategory: json["seller_category"] == null
            ? []
            : List<dynamic>.from(json["seller_category"]!.map((x) => x)),
        id: json["_id"],
        name: json["name"],
        fcmToken: json["fcm_token"],
        isVerified: json["isVerifed"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "seller_category": sellerCategory == null
            ? []
            : List<dynamic>.from(sellerCategory!.map((x) => x)),
        "_id": id,
        "fcm_token": fcmToken,
        "name": name,
        "email": email,
        "password": password,
        "role": role,
        "isVerfied": isVerified,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "contact": contact,
      };
}
