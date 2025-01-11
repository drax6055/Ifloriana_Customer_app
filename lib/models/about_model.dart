import 'package:flutter/material.dart';

class AboutModel {
  String? title;
  String? icon;
  VoidCallback? onTap;
  Widget? widget;
  double iconSize;

  AboutModel({
    this.title,
    this.icon,
    this.onTap,
    this.widget,
    this.iconSize = 20,
  });
}
