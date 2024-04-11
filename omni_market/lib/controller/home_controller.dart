import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:omni_market/config/local_storage.dart';
import 'package:omni_market/model/viewpost_model.dart';
import 'package:omni_market/repository/services/view_post_service.dart';

class HomeController extends GetxController {
  ViewPostModel viewPostModel = ViewPostModel();
  ViewPostModel searchViewPostModel = ViewPostModel();
  final AdvancedDrawerController _advancedDrawerController =
      AdvancedDrawerController();
  List<bool>? isExpandedList;
  List<bool>? isFavouriteList;
  double rating = 0.0;

  bool isLoading = true;
  bool isSearching = false;
  bool isNoDataFound = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    print(
        "=================================>${LocalStorage.sharedPreferences.getString(LocalStorage.fcmToken)}");
    final result = await ViewPostsImplementation().viewPosts();
    result.fold(
      (error) {
        isLoading = false;
      },
      (data) {
        data.fold((l) {
          isLoading = false;
          isNoDataFound = true;
          viewPostModel.data = [];
          print("object 1");
        }, (r) {
          isLoading = false;
          viewPostModel = r;

          isExpandedList =
              List.generate(viewPostModel.data?.length ?? 5, (index) => false);
          isFavouriteList =
              List.generate(viewPostModel.data?.length ?? 5, (index) => false);
          print("object 2");
        });
      },
    );
    print(isLoading);
    print(isNoDataFound);
    print(viewPostModel.data);
    update();
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    print("refresh is called");
    final result = await ViewPostsImplementation().viewPosts();
    result.fold(
      (error) {
        isLoading = false;
      },
      (data) {
        data.fold((l) {
          isLoading = false;
          isNoDataFound = true;
          viewPostModel.data = [];
          print("object 3");
        }, (r) {
          isLoading = false;
          viewPostModel = r;

          isExpandedList =
              List.generate(viewPostModel.data?.length ?? 5, (index) => false);
          isFavouriteList =
              List.generate(viewPostModel.data?.length ?? 5, (index) => false);
          print("object 4");
        });
      },
    );
  }

  final RxBool isExpanded = false.obs;
  RxBool isFavourite = true.obs;
  void startSearch() {
    isSearching = true;
    update();
  }

  void cancelSearch() {
    isSearching = false;
    update();
  }

  void handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  void toggleExpanded() {
    isExpanded.toggle();
  }
}
