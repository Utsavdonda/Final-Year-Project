import 'package:flutter/material.dart';
import 'package:omni_market/config/app_color.dart';
import 'package:omni_market/config/app_style.dart';

class AnimatedButtonView extends StatefulWidget {
  final Function()? onTap;
  final String? title;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? titleColor;
  final Color? borderColor;
  final double? titleFontSize;
  final double? horizontalPadding;
  final double? verticalPadding;

  const AnimatedButtonView({
    super.key,
    this.onTap,
    this.title,
    this.height,
    this.width,
    this.backgroundColor,
    this.borderRadius,
    this.titleColor,
    this.borderColor,
    this.titleFontSize,
    this.horizontalPadding,
    this.verticalPadding,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedButtonViewState createState() => _AnimatedButtonViewState();
}

class _AnimatedButtonViewState extends State<AnimatedButtonView> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (_) {
          setState(() {
            _isTapped = true;
          });
          // You can add any additional functionality here when the button is tapped down.
        },
        onTapUp: (_) {
          setState(() {
            _isTapped = false;
          });
          // Call the onTap function when the tap is released
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        onTapCancel: () {
          setState(() {
            _isTapped = false;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: MediaQuery.sizeOf(context).height * 0.07,
          width: MediaQuery.sizeOf(context).width * 0.6,

          // height: widget.height ?? 50,
          // width: widget.width ?? double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: AppColors.greyColor.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(3, 3)),
              BoxShadow(
                  color: AppColors.blackColor.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 1)),
            ],
            color: _isTapped
                ? (widget.backgroundColor ?? AppColors.primaryColor)
                    .withOpacity(0.8) // Change opacity when tapped
                : (widget.backgroundColor ?? AppColors.primaryColor),
            borderRadius: BorderRadius.circular(
                MediaQuery.sizeOf(context).height * 0.07 / 2),
            border: Border.all(
              color: widget.borderColor ?? AppColors.transparentColor,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            "${widget.title}",
            style: AppTextStyle.regularTextStyle.copyWith(
              color: widget.titleColor ?? AppColors.whiteColor,
              fontSize: widget.titleFontSize ?? 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ));
  }
}
