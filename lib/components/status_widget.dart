import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class StatusWidget extends StatelessWidget {
  final String? text;
  final Color? color;

  StatusWidget({required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: Alignment.center,
      decoration: boxDecorationDefault(
        color: color != null ? color!.withAlpha(20) : null,
        boxShadow: [BoxShadow(color: Colors.transparent)],
      ),
      child: Text(text ?? '', style: boldTextStyle(color: color ?? null, size: 14)),
    );
  }
}
