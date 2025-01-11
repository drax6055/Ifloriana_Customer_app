import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/view_all_label_component.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';

class FilterRatingComponent extends StatefulWidget {
  @override
  _FilterRatingComponentState createState() => _FilterRatingComponentState();
}

class _FilterRatingComponentState extends State<FilterRatingComponent> {
  bool isRatingChecked = false;

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
        ViewAllLabel(label: locale.rating, labelTextStyle: boldTextStyle(), isShowAll: false).paddingSymmetric(horizontal: 16),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: boxDecorationDefault(color: context.cardColor),
          child: AnimatedListView(
            itemCount: 3,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CheckboxListTile(
                value: isRatingChecked,
                title: RatingBarWidget(
                  onRatingChanged: (rating) {
                    //
                  },
                  disable: true,
                  activeColor: getRatingBarColor(3.5.toInt()),
                  inActiveColor: ratingBarColor,
                  rating: 3.5,
                  size: 16,
                ),
                contentPadding: EdgeInsets.only(left: 6, top: 0, bottom: 0, right: 16),
                controlAffinity: ListTileControlAffinity.leading,
                secondary: Text('18', style: boldTextStyle(color: textSecondaryColorGlobal)),
                checkboxShape: RoundedRectangleBorder(borderRadius: radius(5)),
                side: BorderSide(color: textSecondaryColorGlobal),
                visualDensity: VisualDensity.compact,
                dense: true,
                activeColor: appStore.isDarkMode ? primaryColor : secondaryColor,
                onChanged: (value) {
                  isRatingChecked = !isRatingChecked;
                  setState(() {});
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
