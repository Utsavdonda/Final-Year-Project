import 'package:flutter/material.dart';
import 'package:omni_market/screens/pannel/seller/bottombar/home/subscription/subscription_plan_details.dart';
import 'package:omni_market/widgets/common/app_bar.dart';
import 'package:omni_market/widgets/navigation.dart';

// ignore: must_be_immutable
class SellerSubscriptionsScreen extends StatelessWidget {
  SellerSubscriptionsScreen({super.key});

  List<Map<String, dynamic>> subscriptionsPlans = [
    {
      "name": "Platinum",
      "price": 10000,
      "time": "12",
      "features": [
        "Direct payment from buyer from app",
        "You can see verified users",
        "Can directly call seller/buyer",
        "Can see buyer and seller without bid and post",
        "Protection from fake users"
      ],
      "description": "Platinum Plan for Omni Market"
    },
    {
      "name": "Gold",
      "price": 5000,
      "time": "6",
      "features": [
        "Can directly call seller/buyer",
        "Can see buyer and seller without bid and post",
        "Protection from fake users"
      ],
      "description": "Gold Plan for Omni Market"
    },
    {
      "name": "Silver",
      "price": 3000,
      "time": "3",
      "features": [
        "Can see buyer and seller without bid and post",
        "Protection from fake users"
      ],
      "description": "Gold Plan for Omni Market"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(
          title: "Subscriptions",
          context: context,
          isBackIcon: true,
          backIconPress: () {
            navigationPop(context);
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: subscriptionsPlans.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(subscriptionsPlans[index]["name"]),
                    leading: const Icon(Icons.wallet),
                    onTap: () {
                      navigationPush(context,
                          SellerSubscriptionDetails(plan: subscriptionsPlans[index]));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
