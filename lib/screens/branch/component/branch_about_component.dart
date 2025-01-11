import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/common_row_text_widget.dart';
import '../../../components/view_all_label_component.dart';
import '../../../main.dart';
import '../../../utils/common_base.dart';
import '../model/branch_response.dart';

class BranchAboutComponent extends StatelessWidget {
  final String branchDescription;
  final List<WorkingHourList> workingList;

  BranchAboutComponent({required this.branchDescription, required this.workingList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 16,right: 16, top: 4,bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (branchDescription.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ViewAllLabel(label: locale.description, isShowAll: false),
                ReadMoreText(branchDescription.validate(), style: secondaryTextStyle()),
                8.height,
              ],
            ),
          if (workingList.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ViewAllLabel(label: locale.workingHours, isShowAll: false),
                10.height,
                Wrap(
                  runSpacing: 8,
                  children: List.generate(workingList.length, (index) {
                    WorkingHourList data = workingList[index];
                    return CommonRowTextWidget(
                      leadingText: data.day.validate().capitalizeFirstLetter(),
                      trailingText: formatOnlyTime(context, startTime: data.startTime, endTime: data.endTime),
                    );
                  }),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
