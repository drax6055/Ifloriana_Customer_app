import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ifloriana/components/cached_image_widget.dart';
import 'package:ifloriana/screens/dashboard/models/slider_data.dart';
import 'package:ifloriana/screens/services/view/view_all_service_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../configs.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

class HorizontalSliderComponent extends StatefulWidget {
  final List<SliderData> sliderList;

  HorizontalSliderComponent({required this.sliderList});

  @override
  _HorizontalSliderComponentState createState() => _HorizontalSliderComponentState();
}

class _HorizontalSliderComponentState extends State<HorizontalSliderComponent> {
  PageController controller = PageController(keepPage: true, initialPage: 0);
  int currentPage = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    if (getBoolAsync(SharedPreferenceConst.AUTO_SLIDER_STATUS, defaultValue: true) && widget.sliderList.length >= 2) {
      timer = Timer.periodic(Duration(seconds: DASHBOARD_AUTO_SLIDER_SECOND), (Timer timer) {
        if (currentPage < widget.sliderList.length - 1) {
          currentPage++;
        } else {
          currentPage = 0;
        }
        controller.animateToPage(currentPage, duration: Duration(milliseconds: 950), curve: Curves.easeOutQuart);
      });

      controller.addListener(() {
        currentPage = controller.page!.toInt();
      });
    }
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sliderList.isEmpty) return Offstage();

    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PageView.builder(
            controller: controller,
            reverse: false,
            itemCount: widget.sliderList.length,
            itemBuilder: (_, i) {
              SliderData data = widget.sliderList[i];

              return CachedImageWidget(url: data.sliderImage.validate(), height: 200, width: context.width(), fit: BoxFit.cover, radius: defaultRadius).onTap(() {
                if (data.type == SLIDER_TYPE_CATEGORY) {
                  ViewAllServiceScreen(serviceTitle: data.name.validate(), categoryId: data.linkId).launch(context);
                } else if (data.type == SLIDER_TYPE_SERVICE) {
                  ViewAllServiceScreen(serviceTitle: data.name.validate()).launch(context);
                }
              }).paddingOnly(left: 16, right: 16, top: 16);
            },
          ),
          Positioned(
            bottom: 8,
            right: 0,
            left: 0,
            child: DotIndicator(
              pageController: controller,
              pages: widget.sliderList,
              indicatorColor: indicatorColor,
              unselectedIndicatorColor: lightGray,
              currentDotSize: 10,
              dotSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}
