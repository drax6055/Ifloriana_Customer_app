import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/dotted_line.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:ifloriana/utils/common_base.dart';
import 'package:ifloriana/utils/extensions/string_extensions.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../main.dart';
import '../../branch/view/select_branch_screen.dart';
import '../../services/view/view_all_service_screen.dart';
import '../fragment/notification_fragment.dart';

class DashboardAppBarComponent extends StatefulWidget {
  final Widget? innerChild;
  final String? hintText;
  final Widget? positionWidget;
  final double? positionWidgetHeight;
  final VoidCallback? onTapSearch;

  DashboardAppBarComponent({this.innerChild, this.hintText, this.positionWidget, this.positionWidgetHeight, this.onTapSearch});

  @override
  _DashboardAppBarComponentState createState() => _DashboardAppBarComponentState();
}

class _DashboardAppBarComponentState extends State<DashboardAppBarComponent> {
  SpeechToText speech = SpeechToText();
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  void startListening() async {
    bool available = await speech.initialize(onStatus: statusListener, onError: errorListener);

    if (available) {
      speech.listen(onResult: resultListener);

      appStore.setSpeechStatus(true);
      lastWords = '';
      lastError = '';
      speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 30),
        pauseFor: Duration(seconds: 10),
        partialResults: true,
        cancelOnError: true,
        listenMode: ListenMode.deviceDefault,
      );
      setState(() {});
    } else {
      appStore.setSpeechStatus(false);
      toast(locale.theUserHasDeniedSpeechRecognition);
    }
  }

  void stopListening() {
    appStore.setSpeechStatus(false);
    speech.stop();
  }

  void cancelListening() {
    appStore.setSpeechStatus(false);
    speech.cancel();
  }

  void resultListener(SpeechRecognitionResult result) {
    appStore.setSpeechStatus(false);
    if (result.finalResult) {
      lastWords = result.recognizedWords;
      ViewAllServiceScreen(search: lastWords, serviceTitle: locale.searchServices).launch(context);
    }
    log("LastWords: $lastWords");
  }

  void errorListener(SpeechRecognitionError error) {
    appStore.setSpeechStatus(false);
    lastError = '${error.errorMsg} - ${error.permanent}';
    log("lastError: $lastError");
  }

  void statusListener(String status) {
    setState(() {
      lastStatus = '$status';
      log("lastStatus: $lastStatus");
    });

    if (status == 'done') {
      appStore.setSpeechStatus(false);
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    appStore.setSpeechStatus(false);
    speech.stop();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        if (widget.innerChild != null)
          widget.innerChild!
        else
          Container(
            width: context.width(),
            height: 190,
            padding: EdgeInsets.only(left: 21, right: 6, top: context.statusBarHeight),
            decoration: boxDecorationWithRoundedCorners(borderRadius: radiusOnly(bottomLeft: 20, bottomRight: 20), backgroundColor: primaryColor),
            child: Column(
              children: [
                16.height,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Observer(builder: (context) {
                      return Text(
                        appStore.isLoggedIn ? '${locale.hey}, ${userStore.userFullName}' : locale.helloGuest,
                        style: boldTextStyle(size: 18, color: Colors.white),
                      );
                    }),
                    Image.asset(ic_hi, height: 22, fit: BoxFit.cover),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        doIfLoggedIn(context, () {
                          NotificationFragment().launch(context);
                        });
                      },
                      icon: ic_unselected_bell.iconImage(color: Colors.white, size: 20),
                    ),
                  ],
                ),
                10.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(ic_location, height: 16, fit: BoxFit.cover, color: Colors.white),
                    8.width,
                    Marquee(child: Text('${appStore.branchName}, ${appStore.branchAddress}', style: primaryTextStyle(color: Colors.white))).expand(),
                    8.width,
                    Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  ],
                ).paddingOnly(right: 12).onTap(() {
                  SelectBranchScreen(isFromDashboard: true).launch(context);
                }),
                16.height,
                DottedLine(dashColor: secondaryColor, dashGapLength: 0).paddingOnly(right: 10),
              ],
            ),
          ),
        Positioned(
          bottom: -25,
          left: 20,
          right: 20,
          child: Container(
            height: widget.positionWidgetHeight ?? 50,
            width: context.width(),
            decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
            child: widget.positionWidget != null
                ? widget.positionWidget
                : Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      AppTextField(
                        textFieldType: TextFieldType.NAME,
                        onTap: widget.onTapSearch,
                        decoration: inputDecoration(
                          context,
                          label: widget.hintText ?? '',
                          prefixIcon: Icon(Icons.search, color: textSecondaryColorGlobal),
                        ),
                      ),
                      Positioned(
                        left: isRTL ? 16 : null,
                        right: isRTL ? null : 16,
                        child: IconButton(
                          icon: Icon(Icons.mic_none_outlined),
                          color: textSecondaryColorGlobal,
                          onPressed: () async {
                            startListening();
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        )
      ],
    );
  }
}
