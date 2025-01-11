import 'package:flutter/material.dart';
import 'package:ifloriana/main.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/view_all_label_component.dart';
import '../../../utils/colors.dart';

class FilterWeightComponent extends StatefulWidget {
  @override
  _FilterWeightComponentState createState() => _FilterWeightComponentState();
}

class _FilterWeightComponentState extends State<FilterWeightComponent> {
  List weightList = ["150gm", "240gm", "350gm", "160gm", "410gm"];

  int weightSelectIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(label: locale.weight, labelTextStyle: boldTextStyle(), isShowAll: false).paddingSymmetric(horizontal: 16),
        HorizontalList(
          spacing: 16,
          itemCount: weightList.length,
          padding: EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: radius(),
              onTap: () {
                weightSelectIndex = index;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: boxDecorationDefault(color: weightSelectIndex == index ? indicatorColor : context.cardColor),
                child: Text('${weightList[index]}', style: boldTextStyle(color: weightSelectIndex == index ? Colors.black : textSecondaryColorGlobal, size: 12)),
              ),
            );
          },
        ),
      ],
    );
  }
}
