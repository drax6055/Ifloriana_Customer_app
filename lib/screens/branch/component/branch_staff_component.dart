import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../main.dart';
import '../../experts/component/employee_list_component.dart';
import '../../experts/model/employee_detail_response.dart';
import '../../experts/view/employee_detail_screen.dart';
import '../branch_repository.dart';
import '../shimmer/branch_staff_shimmer.dart';

class BranchStaffComponent extends StatefulWidget {
  final int branchId;

  BranchStaffComponent({required this.branchId});

  @override
  _BranchStaffComponentState createState() => _BranchStaffComponentState();
}

class _BranchStaffComponentState extends State<BranchStaffComponent> {
  Future<List<EmployeeData>>? future;

  List<EmployeeData> branchEmployeeList = [];

  int page = 1;

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = getBranchEmployeeList(
      branchId: widget.branchId,
      page: page,
      list: branchEmployeeList,
      lastPageCallBack: (p0) {
        isLastPage = p0;
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SnapHelperWidget<List<EmployeeData>>(
          future: future,
          initialData: branchStaffListResponseCached,
          loadingWidget: BranchStaffShimmer(),
          errorBuilder: (error) {
            return SingleChildScrollView(
              child: NoDataWidget(
                title: error,
                retryText: locale.reload,
                imageWidget: ErrorStateWidget(),
                onRetry: () {
                  page = 1;
                  appStore.setLoading(true);

                  init();
                  setState(() {});
                },
              ),
            ).center();
          },
          onSuccess: (list) {
            if (list.isEmpty) {
              return NoDataWidget(
                title: locale.noStaffFound,
                imageWidget: EmptyStateWidget(),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
              child: AnimatedWrap(
                runSpacing: 36,
                spacing: 16,
                columnCount: 2,
                itemCount: list.length,
                listAnimationType: ListAnimationType.FadeIn,
                itemBuilder: (_, i) {
                  EmployeeData data = list[i];

                  return GestureDetector(
                    onTap: () => EmployeeDetailScreen(employeeId: data.id.validate(), branchId: widget.branchId).launch(context),
                    child: EmployeeListComponent(expertData: data),
                  );
                },
              ),
            );
          },
        ),
        Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading)),
      ],
    );
  }
}
