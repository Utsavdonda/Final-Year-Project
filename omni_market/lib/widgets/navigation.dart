import 'package:flutter/cupertino.dart';

void navigationPush(BuildContext context, Widget widget) {
  Navigator.of(context).push(CupertinoPageRoute(builder: (context) => widget));
}

void navigationPushAndRemoveUntil(BuildContext context, Widget widget) {
  Navigator.of(context).pushAndRemoveUntil(
    CupertinoPageRoute(builder: (context) => widget),
    (route) => false,
  );
}

void navigationPop(BuildContext context) {
  Navigator.of(context).pop();
}
