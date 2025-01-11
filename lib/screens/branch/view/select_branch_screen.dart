import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/components/loader_widget.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/branch/model/branch_response.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../dashboard/component/branch_item_component.dart';
import '../../dashboard/view/dashboard_screen.dart';
import '../branch_repository.dart';
import '../shimmer/select_branch_shimmer.dart';

class SelectBranchScreen extends StatefulWidget {
  final bool isFromDashboard;

  SelectBranchScreen({this.isFromDashboard = false});

  @override
  State<SelectBranchScreen> createState() => _SelectBranchScreenState();
}

class _SelectBranchScreenState extends State<SelectBranchScreen> {
  Future<List<BranchData>>? future;

  List<BranchData> branchList = [];
  BranchData? selectedBranch;

  int page = 1;
  int selectedBranchId = UNSELECTED_BRANCH_ID;

  bool isLastPage = false;

  Position? currentLocation;

  @override
  void initState() {
    selectedBranchId = appStore.branchId;
    init();

    super.initState();

    getLocation();
  }

  void init() {
    future = getBranchList(
      page: page,
      branchList: branchList,
      selectedBranch: selectedBranch,
      lastPageCallBack: (p0) {
        isLastPage = p0;
      },
    );
  }

  Future<void> redirectToDashboard({required List<BranchData> branchList}) async {
    if (branchList.length == 1) {
      await appStore.setBranchId(branchList.first.id.validate(value: UNSELECTED_BRANCH_ID));
      await appStore.setBranchAddress(branchList.first.addressLine1.validate());
      await appStore.setBranchName(branchList.first.name.validate());
      await appStore.setBranchContactNumber(branchList.first.contactNumber.validate());

      DashboardScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
    }
  }

  void getLocation() {
    Geolocator.requestPermission().then((value) {
      if (value == LocationPermission.whileInUse || value == LocationPermission.always) {
        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
          currentLocation = value;
          setState(() {});
        }).catchError(onError);
      }
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(widget.isFromDashboard);
      },
      child: AppScaffold(
        appBarWidget: commonAppBarWidget(
          context,
          title: locale.chooseBranch,
          appBarHeight: 70,
          roundCornerShape: true,
          showLeadingIcon: widget.isFromDashboard ? Navigator.canPop(context) : false,
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
              loadingWidget: SelectBranchShimmer(),
              onSuccess: (list) {
                ///If there is only one Branch in the list
                redirectToDashboard(branchList: list);

                return AnimatedListView(
                  padding: EdgeInsets.only(bottom: selectedBranchId != UNSELECTED_BRANCH_ID ? 80 : 16, left: 16, right: 16, top: 16),
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: list.length,
                  shrinkWrap: true,
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
                  itemBuilder: (context, index) {
                    BranchData branchData = list[index];

                    return BranchItemComponent(
                      branchData: branchData,
                      isFormSignIn: true,
                      selectedBranchId: selectedBranchId,
                      currentBranchIndex: branchData.id,
                      position: currentLocation,
                    ).onTap(() async {
                      if (selectedBranchId == branchData.id) {
                        /// Deselect, If again tap on same branch
                        selectedBranchId = UNSELECTED_BRANCH_ID;
                        selectedBranch = null;
                      } else {
                        selectedBranch = branchData;
                        selectedBranchId = branchData.id!;
                      }
                      setState(() {});
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_right_alt_rounded, color: Colors.white),
          backgroundColor: secondaryColor,
          onPressed: () async {
            if (appStore.branchId != selectedBranchId) {
              showConfirmDialogCustom(
                context,
                positiveText: locale.yes,
                negativeText: locale.no,
                onAccept: (_) async {
                  dashboardResponseCached = null;
                  bookingDetailCached = [];

                  await appStore.setBranchId(selectedBranch!.id.validate(value: UNSELECTED_BRANCH_ID));
                  await appStore.setBranchAddress(selectedBranch!.addressLine1.validate());
                  await appStore.setBranchName(selectedBranch!.name.validate());
                  await appStore.setBranchContactNumber(selectedBranch!.contactNumber.validate());

                  DashboardScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
                },
                title: '${locale.doYouWantExplore} ${selectedBranch!.name}?',
                primaryColor: context.primaryColor,
              );
            } else {
              DashboardScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
            }
          },
        ).visible(branchList.isNotEmpty && selectedBranchId != UNSELECTED_BRANCH_ID),
      ),
    );
  }
}
