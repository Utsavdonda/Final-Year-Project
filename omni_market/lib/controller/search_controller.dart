import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:omni_market/model/viewpost_model.dart';
import 'package:omni_market/repository/services/view_post_service.dart';

class SearchScreenController extends GetxController {
  ViewPostModel viewPostModel = ViewPostModel();
  ViewPostModel searchViewPostModel = ViewPostModel();
  final AdvancedDrawerController _advancedDrawerController =
      AdvancedDrawerController();
  List<bool>? isExpandedList;
  List<bool>? isFavouriteList;

  // Define isLoading
  bool isLoading = true;
  bool isSearching = false;
  bool isNoDataFound = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading = true;

    final result = await ViewPostsImplementation().viewPosts();
    result.fold(
      (error) {
        isLoading = false;
      },
      (data) {
        data.fold((l) {
          isNoDataFound = true;
        }, (r) {
          isLoading = false;
          viewPostModel = r;

          isExpandedList =
              List.generate(viewPostModel.data?.length ?? 5, (index) => false);
          isFavouriteList =
              List.generate(viewPostModel.data?.length ?? 5, (index) => false);
        });

        update();
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

  // void searchPosts(String query) {
  //   if (query.isEmpty) {
  //     isNoDataFound = false;
  //     searchViewPostModel.data = [];
  //   } else {
  //     searchViewPostModel.data = viewPostModel.data!
  //         .where((post) =>
  //             post.buyerId?.name?.toLowerCase().contains(query.toLowerCase()) ??
  //             false)
  //         .toList();
  //     isNoDataFound = searchViewPostModel.data!.isEmpty;
  //   }
  //   update();
  // }

  void handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  void toggleExpanded() {
    isExpanded.toggle();
  }
}
