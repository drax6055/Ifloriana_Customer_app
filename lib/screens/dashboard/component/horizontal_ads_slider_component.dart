import 'package:ifloriana/components/cached_image_widget.dart';
import 'package:ifloriana/components/price_widget.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HorizontalAdsSliderComponent extends StatefulWidget {
  @override
  _HorizontalAdsSliderComponentState createState() => _HorizontalAdsSliderComponentState();
}

class _HorizontalAdsSliderComponentState extends State<HorizontalAdsSliderComponent> {
  PageController controller = PageController(keepPage: true, initialPage: 0);

  List<int> sliderList = [1, 2, 3, 4];

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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 210,
          width: context.width(),
          padding: EdgeInsets.symmetric(vertical: 16),
          margin: EdgeInsets.only(top: 16),
          decoration: boxDecorationDefault(color: context.cardColor, borderRadius: radius(0)),
          child: PageView.builder(
            controller: controller,
            reverse: false,
            itemCount: sliderList.length,
            itemBuilder: (_, i) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: boxDecorationWithRoundedCorners(backgroundColor: context.primaryColor, borderRadius: radius(defaultRadius)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Marquee(child: Text('Stone Spa For Women', style: boldTextStyle(color: white, size: 20))),
                        8.height,
                        Row(
                          children: [
                            Text('Starting At ', style: boldTextStyle(color: white, size: 20)),
                            PriceWidget(price: 29, color: Colors.white, size: 20),
                          ],
                        ),
                        16.height,
                        AppButton(
                          color: Colors.white,
                          child: Text('Book Now', style: boldTextStyle(size: 14, color: secondaryColor)),
                          padding: EdgeInsets.zero,
                          onTap: () {},
                        ),
                      ],
                    ).paddingOnly(left: 16, top: 16, right: 8, bottom: 16).expand(),
                    CachedImageWidget(
                      url: Slider_img2,
                      height: 200,
                      width: 100,
                      fit: BoxFit.cover,
                    ).cornerRadiusWithClipRRectOnly(topRight: defaultRadius.toInt(), bottomRight: defaultRadius.toInt()),
                  ],
                ),
              );
            },
          ),
        ),
        16.height,
        DotIndicator(
          pageController: controller,
          pages: sliderList,
          indicatorColor: secondaryColor,
          unselectedIndicatorColor: lightGray,
          currentDotSize: 10,
          dotSize: 8,
        ),
      ],
    );
  }
}
