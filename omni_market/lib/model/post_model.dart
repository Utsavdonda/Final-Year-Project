class PostModel {
  String? name;
  String? description;
  int? karat;
  List<String>? type;
  List<String>? category;
  double? rating;
  bool? paymentVerification;
  List<String>? images;

  PostModel(
      {this.name,
      this.description,
      this.karat,
      this.type,
      this.category,
      this.rating,
      this.paymentVerification,
      this.images});

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
      name: json["Username"],
      description: json["description"],
      karat: json["karat"],
      type: json["type"],
      category: json["category"],
      rating: json["rating"],
      paymentVerification: json["paymentVerification"],
      images: json["images"]);

  Map<String, dynamic> toJson() => {
    "Username":name,
    "description":description,
    "karat":karat,
    "type":type,
    "category":category,
    "rating":rating,
    "paymentVerification":paymentVerification,
    "images":images
  };
}
