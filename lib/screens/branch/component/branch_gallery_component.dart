import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/screens/zoom_image_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../main.dart';
import '../branch_repository.dart';
import '../model/branch_gallery_list_response.dart';
import '../shimmer/branch_gallery_shimmer.dart';

class BranchGalleryComponent extends StatefulWidget {
  final int branchId;

  BranchGalleryComponent({required this.branchId});

  @override
  _BranchGalleryComponentState createState() => _BranchGalleryComponentState();
}

class _BranchGalleryComponentState extends State<BranchGalleryComponent> {
  Future<List<BranchGalleryData>>? future;

  List<BranchGalleryData> branchGalleryList = [];

  int page = 1;

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = getBranchGalleryList(
      branchId: widget.branchId,
      page: page,
      list: branchGalleryList,
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
        SnapHelperWidget<List<BranchGalleryData>>(
          future: future,
          initialData: branchGalleryListResponseCached,
          loadingWidget: BranchGalleryShimmer(),
          onSuccess: (list) {
            if (list.isEmpty) {
              return SingleChildScrollView(
                child: NoDataWidget(
                  title: locale.noGalleryFound,
                  subTitle: locale.galleryWillBeAppearedHere,
                  imageWidget: EmptyStateWidget(),
                ),
              );
            }

            return AnimatedWrap(
              runSpacing: 16,
              spacing: 16,
              itemCount: list.length,
              listAnimationType: ListAnimationType.FadeIn,
              itemBuilder: (_, index) {
                BranchGalleryData galleryData = list[index];

                return GestureDetector(
                  onTap: () {
                    if (galleryData.fullUrl.validate().isNotEmpty) ZoomImageScreen(galleryImages: list.map((e) => e.fullUrl.validate()).toList(), index: index).launch(context);
                  },
                  child: CachedImageWidget(
                    url: galleryData.fullUrl.validate(),
                    height: 100,
                    width: context.width() / 3 - 22,
                    fit: BoxFit.cover,
                  ).cornerRadiusWithClipRRect(defaultRadius),
                );
              },
            ).paddingSymmetric(vertical: 40, horizontal: 16);
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
            ).center();
          },
        ),
        Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading)),
      ],
    );
  }
}
