import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/view_all_label_component.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../auth/model/gender_model.dart';

class FilterGenderComponent extends StatefulWidget {
  @override
  _FilterGenderComponentState createState() => _FilterGenderComponentState();
}

class _FilterGenderComponentState extends State<FilterGenderComponent> {
  List<GenderModel> genderList = [
    GenderModel(name: locale.male, value: GenderConst.MALE),
    GenderModel(name: locale.female, value: GenderConst.FEMALE),
    GenderModel(name: locale.other, value: GenderConst.OTHER),
  ];

  int genderSelectIndex = -1;

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
        ViewAllLabel(label: '${locale.gender}', labelTextStyle: boldTextStyle(), isShowAll: false).paddingSymmetric(horizontal: 16),
        HorizontalList(
          spacing: 16,
          itemCount: genderList.length,
          padding: EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: radius(),
              onTap: () {
                genderSelectIndex = index;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: boxDecorationDefault(color: genderSelectIndex == index ? indicatorColor : context.cardColor),
                child: Text('${genderList[index].name}', style: boldTextStyle(color: genderSelectIndex == index ? Colors.black : textSecondaryColorGlobal, size: 12)),
              ),
            );
          },
        ),
      ],
    );
  }
}
