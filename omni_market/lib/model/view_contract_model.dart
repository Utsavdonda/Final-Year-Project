// To parse this JSON data, do
//
//     final viewContractModel = viewContractModelFromJson(jsonString);

import 'dart:convert';

ViewContractModel viewContractModelFromJson(String str) =>
    ViewContractModel.fromJson(json.decode(str));

String viewContractModelToJson(ViewContractModel data) =>
    json.encode(data.toJson());

class ViewContractModel {
  bool? status;
  List<Datum>? data;

  ViewContractModel({
    this.status,
    this.data,
  });

  factory ViewContractModel.fromJson(Map<String, dynamic> json) =>
      ViewContractModel(
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
  ErId? sellerId;
  String? postId;
  ErId? buyerId;
  String? diamondImage;
  String? sellerName;
  String? sellerContact;
  List<String>? diamondName;
  List<String>? qualityOfRough;
  List<dynamic>? cutOfDiamond;
  String? rating;
  String? bidAmount;
  String? totalAmount;
  List<String>? diamondCategory;
  List<String>? roughQuality;
  List<String>? polishType;
  List<String>? polishColor;
  String? startDate;
  String? endDate;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.id,
    this.sellerId,
    this.postId,
    this.buyerId,
    this.diamondImage,
    this.sellerName,
    this.sellerContact,
    this.diamondName,
    this.qualityOfRough,
    this.cutOfDiamond,
    this.rating,
    this.bidAmount,
    this.totalAmount,
    this.diamondCategory,
    this.roughQuality,
    this.polishType,
    this.polishColor,
    this.startDate,
    this.endDate,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        sellerId:
            json["seller_id"] == null ? null : ErId.fromJson(json["seller_id"]),
        postId: json["post_id"],
        buyerId:
            json["buyer_id"] == null ? null : ErId.fromJson(json["buyer_id"]),
        diamondImage: json["diamond_image"],
        sellerName: json["seller_name"],
        sellerContact: json["seller_contact"],
        diamondName: json["diamond_name"] == null
            ? []
            : List<String>.from(json["diamond_name"]!.map((x) => x)),
        qualityOfRough: json["quality_of_rough"] == null
            ? []
            : List<String>.from(json["quality_of_rough"]!.map((x) => x)),
        cutOfDiamond: json["cut_of_diamond"] == null
            ? []
            : List<dynamic>.from(json["cut_of_diamond"]!.map((x) => x)),
        rating: json["rating"],
        bidAmount: json["bid_amount"],
        totalAmount: json["total_amount"],
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
            : List<String>.from(json["polish_color"]!.map((x) => x)),
        startDate: json["start_date"],
        endDate: json["end_date"],
        description: json["description"],
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
        "post_id": postId,
        "buyer_id": buyerId?.toJson(),
        "diamond_image": diamondImage,
        "seller_name": sellerName,
        "seller_contact": sellerContact,
        "diamond_name": diamondName == null
            ? []
            : List<dynamic>.from(diamondName!.map((x) => x)),
        "quality_of_rough": qualityOfRough == null
            ? []
            : List<dynamic>.from(qualityOfRough!.map((x) => x)),
        "cut_of_diamond": cutOfDiamond == null
            ? []
            : List<dynamic>.from(cutOfDiamond!.map((x) => x)),
        "rating": rating,
        "bid_amount": bidAmount,
        "total_amount": totalAmount,
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class ErId {
  String? id;
  dynamic profile;
  String? name;
  String? email;
  String? contact;
  List<dynamic>? sellerCategory;
  String? role;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ErId({
    this.id,
    this.profile,
    this.name,
    this.email,
    this.contact,
    this.sellerCategory,
    this.role,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ErId.fromJson(Map<String, dynamic> json) => ErId(
        id: json["_id"],
        profile: json["profile"],
        name: json["name"],
        email: json["email"],
        contact: json["contact"],
        sellerCategory: json["seller_category"] == null
            ? []
            : List<dynamic>.from(json["seller_category"]!.map((x) => x)),
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
        "_id": id,
        "profile": profile,
        "name": name,
        "email": email,
        "contact": contact,
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
