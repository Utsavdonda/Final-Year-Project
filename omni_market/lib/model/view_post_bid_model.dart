// To parse this JSON data, do
//
//     final viewPostsBidModel = viewPostsBidModelFromJson(jsonString);

import 'dart:convert';

ViewPostsBidModel viewPostsBidModelFromJson(String str) =>
    ViewPostsBidModel.fromJson(json.decode(str));

String viewPostsBidModelToJson(ViewPostsBidModel data) =>
    json.encode(data.toJson());

class ViewPostsBidModel {
  String? status;
  List<Datum>? data;

  ViewPostsBidModel({
    this.status,
    this.data,
  });

  factory ViewPostsBidModel.fromJson(Map<String, dynamic> json) =>
      ViewPostsBidModel(
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
  String? id;
  SellerId? sellerId;
  PostId? postId;
  String? bidAmount;
  List<String>? diamondCategory;
  List<String>? roughQuality;
  List<String>? polishType;
  List<dynamic>? polishColor;
  String? startDate;
  String? endDate;
  String? description;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.id,
    this.sellerId,
    this.postId,
    this.bidAmount,
    this.diamondCategory,
    this.roughQuality,
    this.polishType,
    this.polishColor,
    this.startDate,
    this.endDate,
    this.description,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        sellerId: json["seller_id"] == null
            ? null
            : SellerId.fromJson(json["seller_id"]),
        postId:
            json["post_id"] == null ? null : PostId.fromJson(json["post_id"]),
        bidAmount: json["bid_amount"],
        diamondCategory: json["diamond_category"] == null
            ? []
            : List<String>.from(json["diamond_category"]!.map((x) => x)),
        roughQuality: json["rough_quality"] == null
            ? []
            : List<String>.from(json["rough_quality"]!.map((x) => x)),
        polishType: json["polish_type"] == null
            ? []
            : List<String>.from(json["polish_type"]!.map((x) => x)),
        polishColor: json["polish_color"] == null
            ? []
            : List<dynamic>.from(json["polish_color"]!.map((x) => x)),
        startDate: json["start_date"],
        endDate: json["end_date"],
        description: json["description"],
        isDeleted: json["is_deleted"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "seller_id": sellerId?.toJson(),
        "post_id": postId?.toJson(),
        "bid_amount": bidAmount,
        "diamond_category": diamondCategory == null
            ? []
            : List<dynamic>.from(diamondCategory!.map((x) => x)),
        "rough_quality": roughQuality == null
            ? []
            : List<dynamic>.from(roughQuality!.map((x) => x)),
        "polish_type": polishType == null
            ? []
            : List<dynamic>.from(polishType!.map((x) => x)),
        "polish_color": polishColor == null
            ? []
            : List<dynamic>.from(polishColor!.map((x) => x)),
        "start_date": startDate,
        "end_date": endDate,
        "description": description,
        "is_deleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class PostId {
  String? id;
  String? buyerId;
  String? diamondImage;
  List<String>? diamondName;
  List<String>? qualityOfRough;
  List<dynamic>? cutOfDiamond;
  List<String>? polishColor;
  List<String>? polishType;
  String? diamondKarate;
  String? rating;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  PostId({
    this.id,
    this.buyerId,
    this.diamondImage,
    this.diamondName,
    this.qualityOfRough,
    this.cutOfDiamond,
    this.polishColor,
    this.polishType,
    this.diamondKarate,
    this.rating,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PostId.fromJson(Map<String, dynamic> json) => PostId(
        id: json["_id"],
        buyerId: json["buyer_id"],
        diamondImage: json["diamond_image"],
        diamondName: json["diamond_name"] == null
            ? []
            : List<String>.from(json["diamond_name"]!.map((x) => x)),
        qualityOfRough: json["quality_of_rough"] == null
            ? []
            : List<String>.from(json["quality_of_rough"]!.map((x) => x)),
        cutOfDiamond: json["cut_of_diamond"] == null
            ? []
            : List<dynamic>.from(json["cut_of_diamond"]!.map((x) => x)),
        polishColor: json["polish_color"] == null
            ? []
            : List<String>.from(json["polish_color"]!.map((x) => x)),
        polishType: json["polish_type"] == null
            ? []
            : List<String>.from(json["polish_type"]!.map((x) => x)),
        diamondKarate: json["diamond_karate"],
        rating: json["rating"],
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
        "_id": id,
        "buyer_id": buyerId,
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
        "polish_type": polishType == null
            ? []
            : List<dynamic>.from(polishType!.map((x) => x)),
        "diamond_karate": diamondKarate,
        "rating": rating,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class SellerId {
  String? id;
  String? name;
  String? email;
  String? fcmToken;
  String? role;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? contact;
  List<String>? sellerCategory;

  SellerId({
    this.id,
    this.name,
    this.email,
    this.role,
    this.fcmToken,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.contact,
    this.sellerCategory,
  });

  factory SellerId.fromJson(Map<String, dynamic> json) => SellerId(
        id: json["_id"],
        name: json["name"],
        fcmToken: json["fcm_token"],
        email: json["email"],
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
        sellerCategory: json["seller_category"] == null
            ? []
            : List<String>.from(json["seller_category"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "role": role,
        "fcm_token": fcmToken,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "contact": contact,
        "seller_category": sellerCategory == null
            ? []
            : List<dynamic>.from(sellerCategory!.map((x) => x)),
      };
}
