import 'package:flutter/material.dart';
import 'package:ifloriana/main.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../model/gender_model.dart';

class GenderSelectionComponent extends StatefulWidget {
  final String? type;
  final Function(String value) onTap;

  GenderSelectionComponent({Key? key, this.type, required this.onTap}) : super(key: key);

  @override
  State<GenderSelectionComponent> createState() => _GenderSelectionComponentState();
}

class _GenderSelectionComponentState extends State<GenderSelectionComponent> {
  int selectedGender = -1;
  bool isUpdate = false;

  List<GenderModel> genderList = [
    GenderModel(name: locale.male, value: GenderConst.MALE),
    GenderModel(name: locale.female, value: GenderConst.FEMALE),
    GenderModel(name: locale.other, value: GenderConst.OTHER),
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    isUpdate = widget.type != null;
    if (isUpdate) {
      selectedGender = genderList.indexWhere((element) => element.value == widget.type.validate());
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationDefault(color: context.cardColor),
      padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(locale.gender, style: secondaryTextStyle()),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              genderList.length,
                  (index) {
                bool isSelected = selectedGender == index;
                return Container(
                  width: context.width() / 3 - 32,
                  padding: EdgeInsets.fromLTRB(index == 2 ? 8 : 0, 16, 8, 16),
                  decoration: boxDecorationDefault(borderRadius: radius(defaultRadius), color: context.cardColor),
                  child: Row(
                    children: [
                      Container(
                        padding: isSelected ? EdgeInsets.all(2) : EdgeInsets.all(1),
                        decoration: boxDecorationDefault(
                          shape: BoxShape.circle,
                          border: Border.all(color: isSelected ? primaryColor : appTextSecondaryColor.withOpacity(0.5)),
                          color: Colors.transparent,
                        ),
                        child: Container(
                          height: isSelected ? 12 : 12,
                          width: isSelected ? 12 : 12,
                          decoration: boxDecorationDefault(shape: BoxShape.circle, color: isSelected ? primaryColor : white),
                        ),
                      ),
                      8.width,
                      Marquee(child: Text("${genderList[index].name.validate()}", style: primaryTextStyle(size: 14), textAlign: TextAlign.center)).flexible(),
                    ],
                  ).center(),
                ).onTap(() {
                  if (isSelected) {
                    selectedGender = -1;
                  } else {
                    widget.onTap.call(genderList[index].value.validate());
                    selectedGender = index;
                  }
                  setState(() {});
                }, borderRadius: BorderRadius.circular(defaultRadius)).paddingRight(16);
              },
            ),
          ),
        ],
      ),
    );
  }
}