import 'package:flutter/material.dart';
import 'package:omni_market/config/local_storage.dart';
import 'package:omni_market/repository/services/add_subscription.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  final String type;
  final String contact;
  final int amount;
  final String email;

  PaymentService(
      {required this.email,
      required this.type,
      required this.contact,
      required this.amount});
  Future<void> razorPayService(BuildContext context) async {
    Razorpay razorpay = Razorpay();
    var options = {
      // 'key': 'rzp_test_J2At7yvYLkugJD',
      // 'key': 'rzp_test_xvlZZBGCo0SzL0',
      'key': 'rzp_test_ybh4VqV9G66xlg',
      // 'key': 'rzp_test_OKQE9SQTkSx5Wb',
      'amount': amount * 100,
      'send_sms_hash': true,
      'method': {
        'upi': true,
      },
      'prefill': {'name': 'Utsav', 'contact': contact, 'email': email},
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    // razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      handlePaymentSuccessResponse(response, context);
    });

    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  void handlePaymentErrorResponse(
      PaymentFailureResponse response, BuildContext context) {
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(
    PaymentSuccessResponse response,
    BuildContext context,
  ) {
    AddSubcriptionImplementation().addSubscription(context, {
      "id": LocalStorage.sharedPreferences.getString(LocalStorage.userId),
      "subscription_type": type,
    });
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(
      ExternalWalletResponse response, BuildContext context) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
