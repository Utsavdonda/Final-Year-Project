import 'package:get/get.dart';
import 'package:omni_market/model/all_seller_model.dart';
import 'package:omni_market/repository/services/all_seller_service.dart';

class BuyerHomeScreenController extends GetxController {
  AllSellerModel allSellerModel = AllSellerModel();
  @override
  void onInit() {
    super.onInit();
    final result = ViewAllSellerImplementation().viewAllSellers();
    result.then((value) {
      value.fold((l) {
        print("Error");
      }, (r) {
        allSellerModel = r;
      });
      update();
    });
  }
}
