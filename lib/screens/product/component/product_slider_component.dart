import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../configs.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../zoom_image_screen.dart';

class ProductSliderComponent extends StatefulWidget {
  final List<String> productGallaryData;

  ProductSliderComponent({required this.productGallaryData});

  @override
  _ProductSliderComponentState createState() => _ProductSliderComponentState();
}

class _ProductSliderComponentState extends State<ProductSliderComponent> {
  PageController controller = PageController(keepPage: true, initialPage: 0);

  int currentPage = 0;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    if (getBoolAsync(SharedPreferenceConst.AUTO_SLIDER_STATUS, defaultValue: true) && widget.productGallaryData.validate().length >= 2) {
      timer = Timer.periodic(Duration(seconds: DASHBOARD_AUTO_SLIDER_SECOND), (Timer timer) {
        if (currentPage < widget.productGallaryData.validate().length - 1) {
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
    return SizedBox(
      height: 330,
      child: Stack(
        children: [
          PageView.builder(
            controller: controller,
            reverse: false,
            itemCount: widget.productGallaryData.validate().length,
            itemBuilder: (_, i) {
              String productGallaryData = widget.productGallaryData.validate()[i];

              return CachedImageWidget(url: productGallaryData.validate(), height: 330, width: context.width(), fit: BoxFit.cover).onTap(() {
                if (productGallaryData.validate().isNotEmpty)
                  ZoomImageScreen(
                    galleryImages: widget.productGallaryData.validate().map((e) => e.validate()).toList(),
                    index: i,
                  ).launch(context);
              });
            },
          ),
          Positioned(
            bottom: 8,
            right: 0,
            left: 0,
            child: DotIndicator(
              pageController: controller,
              pages: widget.productGallaryData.validate(),
              indicatorColor: indicatorColor,
              unselectedIndicatorColor: lightGray,
              currentBoxShape: BoxShape.rectangle,
              boxShape: BoxShape.rectangle,
              currentBorderRadius: radius(8),
              borderRadius: radius(8),
              currentDotSize: 26,
              currentDotWidth: 6,
              dotSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}
