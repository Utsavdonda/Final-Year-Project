import 'package:get/get.dart';
import 'package:omni_market/model/view_post_bid_model.dart';
import 'package:omni_market/repository/services/view_posts_bid.dart';

class YourPostController extends GetxController {
  ViewPostsBidModel viewPostBidModel = ViewPostsBidModel();
  YourPostController({
    required this.data,
  });
  Map<String, dynamic> data;

  @override
  void onInit() async {
    super.onInit();
    print(data);
    final result = await ViewBidImplementation().viewBids(data);
    result.fold(
      (error) {
        print("error");
      },
      (data) {
        viewPostBidModel = data;
        print("data123:viewBidPostModel   ${viewPostBidModel.data?[0]}");
      },
    );
    update();
    
  }
}
