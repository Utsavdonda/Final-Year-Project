import 'package:get/get.dart';
import 'package:omni_market/model/view_contract_model.dart';
import 'package:omni_market/repository/services/view_contract._service.dart';

class ViewContractController extends GetxController {
  ViewContractModel viewContractModel = ViewContractModel();

  bool isLoading = true;
  bool isNoDataFound = false;

  @override
  onInit() async {
    super.onInit();
    isLoading = true;
    final result = await ViewContractImplementation().viewContract();
    print(result);
    result.fold((error) {
      isLoading = false;
    }, (data) {
      data.fold((l) {
        isLoading = false;
        isNoDataFound = true;
      }, (r) {
        isLoading = false;
        viewContractModel = r;
      });
    });
    update();
  }
}
