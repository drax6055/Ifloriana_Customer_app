import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DefaultUserImagePlaceholder extends StatelessWidget {
  final double size;

  const DefaultUserImagePlaceholder({super.key, this.size = 30});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.person_outline_rounded, size: size, color: context.primaryColor);
  }
}
