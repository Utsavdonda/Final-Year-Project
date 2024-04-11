import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';
import 'package:omni_market/controller/view_contract_controller.dart';
import 'package:omni_market/screens/pannel/seller/bottombar/contract/view_contract_details.dart';
import 'package:omni_market/widgets/common/app_bar.dart';
import 'package:omni_market/widgets/navigation.dart';
import 'package:omni_market/widgets/size.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class SellerContractScreen extends StatelessWidget {
  const SellerContractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewContractController>(
        init: ViewContractController(),
        builder: (viewContractController) {
          return Scaffold(
            appBar: appBar(
                context: context,
                title: "Contract",
                isBackIcon: false,
                elevation: 0,
                icon: Icons.assignment),
            body: viewContractController.isLoading == true
                ? _buildShimmerContent()
                : viewContractController.isNoDataFound == true
                    ? Center(child: Lottie.asset('assets/lottie/nodata.json'))
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.s8.w, vertical: Sizes.s8.h),
                        child: ListView.builder(
                            itemCount: viewContractController
                                .viewContractModel.data?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.5)))),
                                child: ListTile(
                                  onTap: () {
                                    navigationPush(
                                        context,
                                        SellerViewContractDetailsScreen(
                                          index: index,
                                          viewContractModel:
                                              viewContractController
                                                  .viewContractModel,
                                        ));
                                  },
                                  title: Row(
                                    children: [
                                      Text(
                                        "Seller Name: ",
                                        style: AppTextStyle.regularTextStyle
                                            .copyWith(
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        viewContractController.viewContractModel
                                                .data?[index].buyerId?.name ??
                                            "",
                                        style: AppTextStyle.regularTextStyle
                                            .copyWith(
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        "Total Amount: ",
                                        style: AppTextStyle.regularTextStyle
                                            .copyWith(
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        viewContractController.viewContractModel
                                                .data?[index].totalAmount ??
                                            "",
                                        style: AppTextStyle.regularTextStyle
                                            .copyWith(
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  trailing: Container(
                                    width: Sizes.s40.h,
                                    height: Sizes.s40.w,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(Sizes.s25.r)),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.phone,
                                        color: AppColors.whiteColor,
                                      ),
                                      onPressed: () async {
                                        final Uri launchUri = Uri(
                                          scheme: 'tel',
                                          path: viewContractController
                                                  .viewContractModel
                                                  .data?[index]
                                                  .buyerId
                                                  ?.contact ??
                                              "123456789",
                                        );
                                        await launchUrl(launchUri);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
          );
        });
  }

  Widget _buildShimmerContent() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300] ?? Colors.red,
      highlightColor: Colors.grey[100] ?? Colors.red,
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: Sizes.s200.h,
                  color: Colors.white,
                ),
                ScreenUtil().setVerticalSpacing(10),
                Container(
                  width: double.infinity,
                  height: Sizes.s16.h,
                  color: Colors.white,
                ),
                ScreenUtil().setVerticalSpacing(10),
                Container(
                  width: double.infinity,
                  height: Sizes.s16.h,
                  color: Colors.white,
                ),
              ],
            );
          }),
    );
  }
}
