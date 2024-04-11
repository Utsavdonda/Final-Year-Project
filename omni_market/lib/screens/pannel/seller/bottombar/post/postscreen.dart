import 'package:flutter/material.dart';
import 'package:omni_market/widgets/common/app_bar.dart';

class SellerPostScreen extends StatefulWidget {
  const SellerPostScreen({
    super.key,
  });

  @override
  State<SellerPostScreen> createState() => _SellerPostScreenState();
}

class _SellerPostScreenState extends State<SellerPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
          context: context,
            title: "Your Propsals",
            elevation: 0,
            isBackIcon: false,
            icon: Icons.wallet_outlined));
  }
}
