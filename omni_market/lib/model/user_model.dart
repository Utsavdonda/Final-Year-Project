class UserModel {
  List<Datum>? data;
  String? token;

  UserModel({
    this.data,
    this.token,
  });
}

class Datum {
  String? id;
  String? name;
  String? email;
  String? contact;
  String? password;
  String? role;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.id,
    this.name,
    this.email,
    this.contact,
    this.password,
    this.role,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });
}
