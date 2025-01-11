import 'package:ifloriana/configs.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../../branch/view/select_branch_screen.dart';
import '../model/walk_through_model.dart';

class WalkThroughScreen extends StatefulWidget {
  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  List<WalkThroughModel> pages = [];

  int currentPosition = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(primaryColor);
    pages.add(WalkThroughModel(title: locale.findYourNearestSalon, subTitle: locale.walkThrough1subTitle, img: walk_img1));
    pages.add(WalkThroughModel(title: locale.pickAService, subTitle: locale.walkThrough2subTitle, img: walk_img2));
    pages.add(WalkThroughModel(title: locale.quickBooking, subTitle: '${locale.walkThrough3subTitle} $APP_NAME', img: walk_img3));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 16),
        child: Stack(
          children: [
            Container(
              height: 180,
              width: context.width(),
              decoration: boxDecorationWithRoundedCorners(
                backgroundColor: primaryColor,
                borderRadius: radiusOnly(bottomLeft: 20, bottomRight: 20),
                decorationImage: DecorationImage(image: AssetImage(bg_pattern), fit: BoxFit.cover),
              ),
            ),
            Column(
              children: [
                24.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Text(APP_NAME, style: boldTextStyle(size: 20, color: white)).expand(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () async {
                          await setValue(SharedPreferenceConst.IS_FIRST_TIME, false);
                          SelectBranchScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
                        },
                        child: Text(locale.skip, style: boldTextStyle(color: white)),
                      ),
                    )
                  ],
                ),
                8.height,
                SizedBox(
                  height: context.height() * 0.5,
                  width: context.width(),
                  child: PageView(
                    controller: pageController,
                    children: pages.map((e) {
                      return Image.asset(pages[currentPosition].img.validate(), height: context.height() * 0.5, fit: BoxFit.cover).cornerRadiusWithClipRRect(defaultRadius).paddingSymmetric(horizontal: 16);
                    }).toList(),
                    onPageChanged: (i) {
                      currentPosition = i;
                      setState(() {});
                    },
                  ),
                ),
                38.height,
                Text(pages[currentPosition].title.validate(), style: boldTextStyle(size: LABEL_TEXT_SIZE)).paddingSymmetric(horizontal: 16),
                16.height,
                Text(pages[currentPosition].subTitle.validate(), style: secondaryTextStyle(), textAlign: TextAlign.center).paddingSymmetric(horizontal: 16),
                24.height,
                AppButton(
                  child: Text(currentPosition == 2 ? locale.getStarted : locale.next, style: boldTextStyle(color: white)),
                  width: 230,
                  elevation: 0,
                  color: secondaryColor,
                  onTap: () async {
                    if (currentPosition == 2) {
                      await setValue(SharedPreferenceConst.IS_FIRST_TIME, false);
                      SelectBranchScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
                    } else {
                      pageController.nextPage(duration: 500.milliseconds, curve: Curves.linearToEaseOut);
                    }
                  },
                ),
                16.height,
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 40,
        child: Column(
          children: [
            DotIndicator(
              pageController: pageController,
              pages: pages,
              indicatorColor: indicatorColor,
              unselectedIndicatorColor: lightGray,
              currentBoxShape: BoxShape.rectangle,
              boxShape: BoxShape.circle,
              currentDotSize: 26,
              currentDotWidth: 6,
              dotSize: 6,
            ),
            16.height,
          ],
        ),
      ),
    );
  }
}
