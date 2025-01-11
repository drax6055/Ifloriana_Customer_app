import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/screens/branch/view/branch_detail_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../dashboard/component/branch_item_component.dart';
import '../branch_repository.dart';
import '../model/branch_response.dart';
import '../shimmer/select_branch_shimmer.dart';

class BranchListScreen extends StatefulWidget {
  final Position? position;

  BranchListScreen({this.position});

  @override
  _BranchListScreenState createState() => _BranchListScreenState();
}

class _BranchListScreenState extends State<BranchListScreen> {
  Future<List<BranchData>>? future;

  List<BranchData> branchList = [];

  int page = 1;

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = getBranchList(
      page: page,
      branchList: branchList,
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
        title: locale.nearbyBranches,
        appBarHeight: 70,
        roundCornerShape: true,
        showLeadingIcon: Navigator.canPop(context),
      ),
      body: Stack(
        children: [
          SnapHelperWidget<List<BranchData>>(
            future: future,
            initialData: branchListCached,
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
            loadingWidget: SelectBranchShimmer().paddingAll(16),
            onSuccess: (list) {
              return AnimatedListView(
                itemCount: list.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                emptyWidget: NoDataWidget(
                  title: locale.noBranchFound,
                  imageWidget: EmptyStateWidget(),
                  retryText: locale.reload,
                  onRetry: () {
                    page = 1;
                    appStore.setLoading(true);

                    init();
                    setState(() {});
                  },
                ),
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  BranchData branchData = list[index];

                  return BranchItemComponent(branchData: branchData, position: widget.position).onTap(() {
                    BranchDetailScreen(branchId: branchData.id.validate()).launch(context);
                  }, highlightColor: Colors.transparent, hoverColor: Colors.transparent, splashColor: Colors.transparent);
                },
                onNextPage: () {
                  if (!isLastPage) {
                    page++;
                    appStore.setLoading(true);

                    init();
                    setState(() {});
                  }
                },
                onSwipeRefresh: () async {
                  page = 1;

                  init();
                  setState(() {});

                  return await 2.seconds.delay;
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
