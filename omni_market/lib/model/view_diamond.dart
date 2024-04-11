// To parse this JSON data, do
//
//     final viewDiamondModel = viewDiamondModelFromJson(jsonString);

import 'dart:convert';

ViewDiamondModel viewDiamondModelFromJson(String str) =>
    ViewDiamondModel.fromJson(json.decode(str));

String viewDiamondModelToJson(ViewDiamondModel data) =>
    json.encode(data.toJson());

class ViewDiamondModel {
  String? status;
  List<Datum>? data;

  ViewDiamondModel({
    this.status,
    this.data,
  });

  factory ViewDiamondModel.fromJson(Map<String, dynamic> json) =>
      ViewDiamondModel(
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
  List<String>? diamondName;
  List<String>? qualityOfRough;
  List<String>? cutOfDiamond;
  List<String>? polishColor;
  List<String>? polishType;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.id,
    this.diamondName,
    this.qualityOfRough,
    this.cutOfDiamond,
    this.polishColor,
    this.polishType,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
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
        polishType: json["polish_type"] == null
            ? []
            : List<String>.from(json["polish_type"]!.map((x) => x)),
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
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
