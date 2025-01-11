import 'package:flutter/material.dart';
import 'package:ifloriana/components/price_widget.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/common_base.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../main.dart';
import '../models/service_response.dart';

class ServicesInfoListComponent extends StatefulWidget {
  final ServiceListData serviceInfo;
  final Function() onPressed;

  ServicesInfoListComponent({required this.serviceInfo, required this.onPressed});

  @override
  _ServicesInfoListComponentState createState() => _ServicesInfoListComponentState();
}

class _ServicesInfoListComponentState extends State<ServicesInfoListComponent> {
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
    return GestureDetector(
      onTap: () {
        widget.onPressed.call();
      },
      child: Container(
        decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor, borderRadius: radius()),
        padding: EdgeInsets.only(left: 16, right: 8, top: 16, bottom: 16),
        margin: EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedImageWidget(
                  url: widget.serviceInfo.serviceImage.validate(),
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                  radius: defaultRadius,
                ),
                8.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Marquee(child: Text('${widget.serviceInfo.name.validate()}', style: boldTextStyle())),
                    Marquee(child: Text('${durationToString(widget.serviceInfo.durationMin.validate())}', style: secondaryTextStyle())),
                  ],
                ).expand(),
              ],
            ).expand(),
            16.width,
            Row(
              children: [
                PriceWidget(price: widget.serviceInfo.defaultPrice.validate()),
                Checkbox(
                  value: widget.serviceInfo.isServiceChecked,
                  shape: RoundedRectangleBorder(borderRadius: radius(5)),
                  visualDensity: VisualDensity.compact,
                  activeColor: appStore.isDarkMode ? territoryButtonColor : secondaryColor,
                  side: BorderSide(color: textSecondaryColorGlobal),
                  checkColor: appStore.isDarkMode ? Colors.black : Colors.white,
                  onChanged: (value) {
                    widget.onPressed.call();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
