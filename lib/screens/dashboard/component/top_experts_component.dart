import 'package:flutter/material.dart';
import 'package:ifloriana/components/view_all_label_component.dart';
import 'package:ifloriana/screens/experts/component/employee_list_component.dart';
import 'package:ifloriana/screens/experts/view/employee_list_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../../experts/model/employee_detail_response.dart';
import '../../experts/view/employee_detail_screen.dart';

class TopExpertsComponent extends StatefulWidget {
  final List<EmployeeData>? topExpertList;

  TopExpertsComponent({this.topExpertList});

  @override
  _TopExpertsComponentState createState() => _TopExpertsComponentState();
}

class _TopExpertsComponentState extends State<TopExpertsComponent> {
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
    if (widget.topExpertList.validate().isEmpty) return Offstage();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(
          label: locale.topExperts,
          list: widget.topExpertList,
          onTap: () {
            EmployeeListScreen().launch(context);
          },
        ).paddingSymmetric(vertical: 16, horizontal: 16),
        16.height,
        AnimatedWrap(
          runSpacing: 36,
          spacing: 16,
          columnCount: 2,
          itemCount: widget.topExpertList.validate().take(6).length,
          listAnimationType: ListAnimationType.Scale,
          scaleConfiguration: ScaleConfiguration(duration: 300.milliseconds, delay: 50.milliseconds),
          itemBuilder: (_, i) {
            EmployeeData data = widget.topExpertList.validate()[i];
            return EmployeeListComponent(expertData: data).onTap(() {
              EmployeeDetailScreen(employeeId: data.id.validate()).launch(context);
            }, borderRadius: radius());
          },
        ).paddingSymmetric(horizontal: 16),
        16.height,
      ],
    );
  }
}
