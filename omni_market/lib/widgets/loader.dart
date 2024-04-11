import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/image_path.dart';

// double _kLoaderSize = Sizes.s14.h;

class Loader {
  Loader._();

  static Widget activityIndicator({
    String? message,
    double? radius,
    Color? color,
  }) {
    Color primaryColor = AppColors.primaryColor;

    Widget loader = CupertinoActivityIndicator(
      // radius: radius ?? _kLoaderSize,
      color: color ?? primaryColor,
    );

    return message != null
        ? Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                loader,
                // ScreenUtil().setHorizontalSpacing(20),
                Flexible(
                  child: Text(
                    message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1.4,
                      // fontSize: Sizes.s16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          )
        : Center(child: loader);
  }

  static void show(
    BuildContext context, {
    String? message,
    bool fullPageLoader = false,
    Color? backgroundColor,
  }) {
    PopupRoute pageRoute = fullPageLoader
        ? _FullLoaderPage(message: message, backgroundColor: backgroundColor)
        : _LoaderDialog(message: message);

    Navigator.push(context, pageRoute);
  }

  static void dismiss(BuildContext context) {
    Navigator.pop(context);
  }
}

class _LoaderDialog extends PopupRoute {
  final String? message;

  _LoaderDialog({this.message});

  @override
  Color? get barrierColor => Colors.black.withOpacity(0.3);

  @override
  bool get barrierDismissible => !kReleaseMode;

  @override
  String? get barrierLabel => runtimeType.toString();

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          alignment: Alignment.center,
          children: [
            InkWell(
              onTap: barrierDismissible ? () => Navigator.pop(context) : null,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: barrierColor,
              ),
            ),
            message != null
                ? Loader.activityIndicator(message: message)
                : Loader.activityIndicator()
          ],
        ),
      ),
    );
  }
}

class _FullLoaderPage extends PopupRoute {
  final String? message;
  final Color? backgroundColor;

  _FullLoaderPage({this.message, this.backgroundColor});

  @override
  Color? get barrierColor => backgroundColor ?? Colors.black;

  @override
  bool get barrierDismissible => !kReleaseMode;

  @override
  String? get barrierLabel => runtimeType.toString();

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          alignment: Alignment.center,
          children: [
            InkWell(
              onTap: barrierDismissible ? () => Navigator.pop(context) : null,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: barrierColor,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImagePath.loadingAnimation),
                if (message != null) ...[
                  // ScreenUtil().setVerticalSpacing(10),
                  Text(
                    message!,
                    // style: TextStyle(fontSize: Sizes.s14.sp),
                  )
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}
