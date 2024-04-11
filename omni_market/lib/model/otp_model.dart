import 'dart:convert';

CommentModel commentModelFromJson(String str) =>
    CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  String? otp;

  CommentModel({
    this.otp,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
      };
}
