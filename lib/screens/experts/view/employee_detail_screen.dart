import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/cached_image_widget.dart';
import 'package:ifloriana/screens/experts/component/employee_social_accounts_component.dart';
import 'package:ifloriana/screens/review/component/review_item_component.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:ifloriana/utils/common_base.dart';
import 'package:ifloriana/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/app_scaffold.dart';
import '../../../components/default_user_image_placeholder.dart';
import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../components/view_all_label_component.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../review/view/review_all_screen.dart';
import '../employee_repository.dart';
import '../model/employee_detail_response.dart';
import '../shimmer/employee_detail_shimmer.dart';

class EmployeeDetailScreen extends StatefulWidget {
  final int employeeId;
  final int? branchId;

  EmployeeDetailScreen({required this.employeeId, this.branchId});

  @override
  _EmployeeDetailScreenState createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  Future<EmployeeDetailResponse>? future;

  List<String> icons = [ic_facebook, ic_instagram, ic_twitter, ic_dribble];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = getEmployeeDetail(branchId: widget.branchId ?? appStore.branchId, employeeId: widget.employeeId);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: false,
      body: Stack(
        children: [
          SnapHelperWidget<EmployeeDetailResponse>(
            future: future,
            initialData: employeeDetailCachedData.firstWhere((element) => element?.$1 == widget.employeeId.validate(),orElse: () => null)?.$2,
            loadingWidget: EmployeeDetailShimmer(),
            onSuccess: (snap) {
              EmployeeData employeeData = snap.data!;

              return AnimatedScrollView(
                crossAxisAlignment: CrossAxisAlignment.start,
                listAnimationType: ListAnimationType.FadeIn,
                children: [
                  /// Top UI
                  Container(
                    color: context.cardColor,
                    child: Column(
                      children: [
                        commonAppBarWidget(
                          context,
                          title: '',
                          roundCornerShape: true,
                          appBarHeight: 70,
                          showLeadingIcon: Navigator.canPop(context),
                        ),
                        CachedImageWidget(
                          url: employeeData.profileImage.validate(),
                          height: 98,
                          fit: BoxFit.cover,
                          width: 98,
                          radius: 150,
                          child: DefaultUserImagePlaceholder(),
                        ).paddingTop(16),
                        Column(
                          children: [
                            8.height,
                            Text(employeeData.fullName.validate(), style: boldTextStyle(size: 18)),
                            if (employeeData.expert.validate().isNotEmpty) Text(employeeData.expert!, style: secondaryTextStyle()).paddingTop(4),
                            16.height,
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: boxDecorationWithRoundedCorners(backgroundColor: context.scaffoldBackgroundColor),
                              child: TextIcon(
                                text: employeeData.ratingStar.validate().toStringAsFixed(1).toString(),
                                spacing: 8,
                                textStyle: boldTextStyle(),
                                edgeInsets: EdgeInsets.zero,
                                prefix: Icon(Icons.star, size: 18, color: employeeData.ratingColor),
                              ),
                            ),
                            20.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (employeeData.facebookLink.validate().isNotEmpty)
                                  EmployeeSocialAccountsComponent(
                                    icon: ic_facebook,
                                    onPressed: () {
                                      commonLaunchUrl(employeeData.facebookLink.validate());
                                    },
                                  ),
                                16.width,
                                if (employeeData.instagramLink.validate().isNotEmpty)
                                  EmployeeSocialAccountsComponent(
                                    icon: ic_instagram,
                                    onPressed: () {
                                      commonLaunchUrl(employeeData.instagramLink.validate());
                                    },
                                  ),
                                16.width,
                                if (employeeData.twitterLink.validate().isNotEmpty)
                                  EmployeeSocialAccountsComponent(
                                    icon: ic_twitter,
                                    onPressed: () {
                                      commonLaunchUrl(employeeData.twitterLink.validate());
                                    },
                                  ),
                                16.width,
                                if (employeeData.dribbbleLink.validate().isNotEmpty)
                                  EmployeeSocialAccountsComponent(
                                    icon: ic_dribble,
                                    onPressed: () {
                                      commonLaunchUrl(employeeData.dribbbleLink.validate());
                                    },
                                  ),
                              ],
                            ),
                            if (employeeData.facebookLink.validate().isNotEmpty &&
                                employeeData.instagramLink.validate().isNotEmpty &&
                                employeeData.twitterLink.validate().isNotEmpty &&
                                employeeData.dribbbleLink.validate().isNotEmpty)
                              20.height,
                          ],
                        ),
                      ],
                    ),
                  ),
                  10.height,
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: AnimatedScrollView(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// About Self UI
                        if (employeeData.aboutSelf.validate().isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${locale.about} ${employeeData.firstName.validate()}', style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                              10.height,
                              ReadMoreText(employeeData.aboutSelf!, style: secondaryTextStyle(), textAlign: TextAlign.justify),
                              20.height,
                            ],
                          ),

                        /// Contact Info UI
                        if (employeeData.email.validate().isNotEmpty && employeeData.mobile.validate().isNotEmpty && employeeData.joiningDate.validate().isNotEmpty)
                          Text(locale.contactInfo, style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                        16.height,
                        if (employeeData.email.validate().isNotEmpty)
                          Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: boxDecorationWithRoundedCorners(borderRadius: radius(), backgroundColor: quaternaryButtonColor),
                                    child: CachedImageWidget(url: ic_message, height: 12, width: 12, color: secondaryColor).paddingAll(6),
                                  ),
                                  16.width,
                                  Text(employeeData.email!, style: secondaryTextStyle()).onTap(() {
                                    launchMail(employeeData.email.validate());
                                  }),
                                ],
                              ),
                              16.height,
                            ],
                          ),
                        if (employeeData.mobile.validate().isNotEmpty)
                          Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: boxDecorationWithRoundedCorners(borderRadius: radius(), backgroundColor: quaternaryButtonColor),
                                    child: CachedImageWidget(url: ic_call, height: 12, width: 12, color: secondaryColor).paddingAll(6),
                                  ),
                                  16.width,
                                  Text(employeeData.mobile!, style: secondaryTextStyle()).onTap(() {
                                    launchCall(employeeData.mobile.validate());
                                  }),
                                ],
                              ),
                              16.height,
                            ],
                          ),
                        if (employeeData.joiningDate.validate().isNotEmpty)
                          Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: boxDecorationWithRoundedCorners(borderRadius: radius(), backgroundColor: quaternaryButtonColor),
                                    child: CachedImageWidget(url: ic_business, height: 12, width: 12, color: secondaryColor).paddingAll(6),
                                  ),
                                  16.width,
                                  Text(formatDate(employeeData.joiningDate!, format: DateFormatConst.DATE_FORMAT_2), style: secondaryTextStyle()),
                                ],
                              ),
                              8.height,
                            ],
                          ),

                        /// Reviews UI
                        ViewAllLabel(
                          labelWidget: Row(
                            children: [
                              Text(locale.reviews, style: boldTextStyle(size: LABEL_TEXT_SIZE)),
                              if (employeeData.totalReview.validate() >= 1)
                                Text(
                                  '(${locale.basedOn} ${employeeData.totalReview.validate()} ${locale.review}${employeeData.totalReview.validate() > 1 ? '${locale.s}' : ''})',
                                  style: secondaryTextStyle(),
                                ).paddingLeft(4),
                            ],
                          ),
                          list: employeeData.reviewData.validate(),
                          onTap: () {
                            ReviewAllScreen(employeeId: snap.data!.id).launch(context);
                          },
                        ),
                        if (employeeData.reviewData.validate().isNotEmpty)
                          AnimatedListView(
                            itemCount: employeeData.reviewData!.take(10).length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (_, i) {
                              return ReviewItemComponent(reviewData: employeeData.reviewData![i]);
                            },
                          )
                        else
                          NoDataWidget(
                            subTitle: '${locale.noReviewsYetFor} ${employeeData.firstName}',
                            imageWidget: EmptyStateWidget(),
                          ),
                      ],
                    ),
                  ),
                ],
                onSwipeRefresh: () async {
                  init();
                  setState(() {});

                  return await 2.seconds.delay;
                },
              );
            },
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                imageWidget: ErrorStateWidget(),
                retryText: locale.reload,
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
