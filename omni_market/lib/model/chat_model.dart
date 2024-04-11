import 'package:omni_market/model/all_seller_model.dart';

class ChatModel {
  final String id;
  final String name;
  final dynamic profile;

  ChatModel({
    required this.id,
    required this.name,
    required this.profile,
  });

  factory ChatModel.fromDatum(Datum datum) {
    return ChatModel(
      id: datum.id ?? '',
      name: datum.name ?? '',
      profile: datum.profile,
    );
  }
}

extension AllSellerModelToChatModel on AllSellerModel {
  List<ChatModel> toChatModels() {
    return data?.map((datum) => ChatModel.fromDatum(datum)).toList() ?? [];
  }
}
