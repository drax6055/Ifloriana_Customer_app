import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/screens/experts/component/employee_list_component.dart';
import 'package:ifloriana/screens/experts/view/employee_detail_screen.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../main.dart';
import '../../experts/model/employee_detail_response.dart';
import '../employee_repository.dart';
import '../shimmer/employee_list_shimmer.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  Future<List<EmployeeData>>? future;

  List<EmployeeData> expertList = [];

  int page = 1;

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = getEmployeeList(
      branchId: appStore.branchId,
      orderBy: 'top',
      page: page,
      list: expertList,
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
    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: locale.topExperts,
        appBarHeight: 70,
        roundCornerShape: true,
        showLeadingIcon: Navigator.canPop(context),
      ),
      body: Stack(
        children: [
          SnapHelperWidget<List<EmployeeData>>(
            future: future,
            initialData: employeeListCached,
            loadingWidget: EmployeeListShimmer(),
            onSuccess: (list) {
              if (list.isEmpty) {
                return NoDataWidget(
                  title: locale.noStaffFound,
                  retryText: locale.reload,
                  onRetry: () {
                    page = 1;
                    appStore.setLoading(true);

                    init();
                    setState(() {});
                  },
                );
              }

              return AnimatedScrollView(
                onSwipeRefresh: () async {
                  page = 1;

                  init();
                  setState(() {});

                  return await 2.seconds.delay;
                },
                physics: AlwaysScrollableScrollPhysics(),
                listAnimationType: ListAnimationType.Scale,
                padding: EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
                onNextPage: () {
                  if (!isLastPage) {
                    page++;
                    appStore.setLoading(true);

                    init();
                    setState(() {});
                  }
                },
                children: [
                  AnimatedWrap(
                    runSpacing: 36,
                    spacing: 16,
                    columnCount: 2,
                    itemCount: list.length,
                    listAnimationType: ListAnimationType.Scale,
                    scaleConfiguration: ScaleConfiguration(duration: 300.milliseconds, delay: 50.milliseconds),
                    itemBuilder: (_, i) {
                      EmployeeData data = list[i];

                      return GestureDetector(
                        onTap: () => EmployeeDetailScreen(employeeId: data.id.validate()).launch(context),
                        child: EmployeeListComponent(expertData: data),
                      );
                    },
                  ),
                ],
              );
            },
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                retryText: locale.reload,
                imageWidget: ErrorStateWidget(),
                onRetry: () {
                  page = 1;
                  appStore.setLoading(true);

                  init();
                  setState(() {});
                },
              );
            },
          ),
          Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
