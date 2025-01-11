import 'package:flutter/material.dart';
import 'package:ifloriana/components/dotted_line.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../screens/booking/view/booking_screen.dart';
import '../utils/constants.dart';

PageController customStepperController = PageController(initialPage: 0);

class CustomStepper extends StatefulWidget {
  final List<CustomStep> stepsList;
  final Function(int)? onChange;

  CustomStepper({required this.stepsList, this.onChange});

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int currentPage = 0;
  bool flag = false;

  @override
  void initState() {
    super.initState();
    customStepperController = PageController(initialPage: 0);

    LiveStream().on(LiveStreamKeyConst.LIVESTREAM_CHANGE_STEP, (p0) async {
      log(flag);
      if (!flag) {
        flag = true;
        currentPage = p0 as int;
        setState(() {});

        await 100.milliseconds.delay;
        flag = false;
        log(flag);
      }
    });
  }

  Widget buildStepDivider(int index) {
    return DottedLine(
      dashColor: index < currentPage
          ? appStore.isDarkMode
              ? Colors.white
              : secondaryColor
          : context.dividerColor,
      lineThickness: 1.5,
      dashGapLength: 0,
      lineLength: context.width() * 0.15,
    );
  }

  Widget buildStep(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 14,
              width: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index < currentPage
                    ? Colors.green
                    : index <= currentPage
                        ? secondaryColor
                        : Colors.grey,
                border: Border.all(color: index <= currentPage ? Colors.transparent : context.dividerColor),
              ),
            ),
            Icon(Icons.done, color: index < currentPage ? Colors.white : Colors.transparent, size: 14),
          ],
        ),
        4.height,
        FittedBox(
          clipBehavior: Clip.none,
          fit: BoxFit.none,
          child: Marquee(
            child: Text(
              widget.stepsList[index].title.validate(),
              textAlign: TextAlign.center,
              style: boldTextStyle(size: 12, color: index <= currentPage ? textPrimaryColorGlobal : Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepper(int currentStep) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        widget.stepsList.length,
        (index) {
          if (index < widget.stepsList.length - 1)
            return Row(
              children: [
                buildStep(index),
                16.width,
                buildStepDivider(index),
                16.width,
              ],
            );
          else
            return buildStep(index);
        },
      ),
    ).paddingOnly(left: 18, right: 16).fit();
  }

  @override
  void dispose() {
    LiveStream().dispose(LiveStreamKeyConst.LIVESTREAM_CHANGE_STEP);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: customStepperController,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.stepsList.length,
          itemBuilder: (context, index) => widget.stepsList[index].page,
          onPageChanged: (index) {
            setState(
              () {
                currentPage = index;
                widget.onChange?.call(index);
              },
            );
          },
        ).paddingTop(120),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: context.width(),
                height: 130,
                child: appBarWidget(locale.booking, center: true, color: context.primaryColor, textColor: white).cornerRadiusWithClipRRectOnly(bottomLeft: 20, bottomRight: 20),
              ),
              Positioned(
                bottom: -40,
                left: 18,
                right: 18,
                child: Container(
                  height: 65,
                  alignment: Alignment.center,
                  // padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                  child: _buildStepper(currentPage),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
