import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/components/back_widget.dart';
import 'package:ifloriana/components/loader_widget.dart';
import 'package:ifloriana/components/slider_component.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../main.dart';
import '../branch_repository.dart';
import '../component/branch_about_component.dart';
import '../component/branch_gallery_component.dart';
import '../component/branch_review_component.dart';
import '../component/branch_service_component.dart';
import '../component/branch_staff_component.dart';
import '../model/branch_detail_response.dart';
import '../shimmer/branch_detail_shimmer.dart';

class BranchDetailScreen extends StatefulWidget {
  final int branchId;

  BranchDetailScreen({required this.branchId});

  @override
  _BranchDetailScreenState createState() => _BranchDetailScreenState();
}

class _BranchDetailScreenState extends State<BranchDetailScreen> with TickerProviderStateMixin {
  Future<BranchDetailResponse>? future;

  List<String> sectionList = [locale.about, locale.services, locale.reviews, locale.staff, locale.gallery];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
    setStatusBarColor(Colors.transparent);
  }

  void init() async {
    /// Branch Detail Api
    future = getBranchDetail(widget.branchId);
  }

  BranchDetailResponse? getBranchInitialData() {
    if (branchDetailCachedData.any((element) => element.data?.id == widget.branchId)) {
      return BranchDetailResponse(data: branchDetailCachedData.firstWhere((element) => element.data?.id == widget.branchId).data);
    } else {
      return null;
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    dashboardResponseCached = null;
    branchReviewListResponseCached = null;
    branchStaffListResponseCached = null;
    branchGalleryListResponseCached = null;
    branchServiceListResponseCached = null;
    bookingDetailCached = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: false,
      body: Stack(
        children: [
          SnapHelperWidget<BranchDetailResponse>(
            future: future,
            initialData: getBranchInitialData(),
            loadingWidget: BranchDetailShimmer(),
            onSuccess: (snap) {
              if (snap.data == null) {
                return NoDataWidget(
                  title: locale.noDetailsFound,
                  retryText: locale.reload,
                  onRetry: () {
                    appStore.setLoading(true);

                    init();
                    setState(() {});
                  },
                );
              }

              return NestedScrollView(
                headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: 490,
                      floating: false,
                      pinned: true,
                      forceElevated: true,
                      leading: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                        child: Container(
                          child: BackWidget(iconColor: context.iconColor),
                          decoration: boxDecorationDefault(shape: BoxShape.circle, color: context.cardColor.withOpacity(0.6)),
                        ),
                      ).cornerRadiusWithClipRRect(30).paddingLeft(6),
                      titleTextStyle: boldTextStyle(color: whiteColor, size: 20),
                      shape: ContinuousRectangleBorder(borderRadius: radiusOnly(bottomLeft: 20, bottomRight: 20)),
                      title: Text(innerBoxIsScrolled ? '' : ''),
                      centerTitle: true,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: SliderComponent(branchData: snap),
                      ),
                    ),
                  ];
                },
                body: DefaultTabController(
                  length: sectionList.length,
                  initialIndex: selectedIndex,
                  child: Column(
                    children: [
                      Container(
                        color: context.scaffoldBackgroundColor,
                        child: Container(
                          child: TabBar(
                            isScrollable: true,
                            indicatorColor: Colors.transparent,
                            dividerColor: Colors.transparent,
                            labelPadding: EdgeInsets.symmetric(),
                            onTap: (i) {
                              selectedIndex = i;
                              setState(() {});
                            },
                            tabs: sectionList.map((e) {
                              int index = sectionList.indexOf(e);

                              return Tab(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                                  margin: EdgeInsets.only(left: index == 0 ? 16 : 0, right: 16),
                                  decoration: boxDecorationWithRoundedCorners(
                                    backgroundColor: index == selectedIndex ? secondaryColor : context.cardColor,
                                  ),
                                  child: Text(e.toString(), style: boldTextStyle(color: index == selectedIndex ? white : textPrimaryColorGlobal)).center(),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        key: ValueKey(selectedIndex),
                        children: sectionList.map((e) {
                          if (selectedIndex == 0) {
                            return BranchAboutComponent(branchDescription: snap.data!.description.validate(), workingList: snap.data!.workingHourList.validate());
                          } else if (selectedIndex == 1) {
                            return BranchServiceComponent(branchId: widget.branchId);
                          } else if (selectedIndex == 2) {
                            return BranchReviewComponent(branchId: widget.branchId, branchTotalReview: snap.data!.totalReview.validate());
                          } else if (selectedIndex == 3) {
                            return BranchStaffComponent(branchId: widget.branchId);
                          } else if (selectedIndex == 4) {
                            return BranchGalleryComponent(branchId: widget.branchId);
                          } else {
                            return Offstage();
                          }
                        }).toList(),
                      ).expand(),
                    ],
                  ).paddingOnly(top: 16),
                ),
              );
            },
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                retryText: locale.reload,
                imageWidget: ErrorStateWidget(),
                onRetry: () {
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
