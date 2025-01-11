import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';

class NoBranchErrorWidget extends StatelessWidget {
  final String errorMessage;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;

  const NoBranchErrorWidget({this.height, this.width, required this.errorMessage, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/lottie/error_lottie.json', repeat: true, height: 300),
          Text(errorMessage, style: boldTextStyle(size: 18), textAlign: TextAlign.center).center(),
          16.height,
          TextButton(
            onPressed: () async {
              if (await isNetworkAvailable()) {
                // onPressed?.call();
                RestartAppWidget.init(context);
              } else {
                toast(locale.yourInternetIsNotWorking);
              }
            },
            child: Text(locale.reload),
          ),
        ],
      ),
    );
  }
}
