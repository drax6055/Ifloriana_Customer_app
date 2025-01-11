import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/components/common_bottom_price_widget.dart';
import 'package:ifloriana/components/custom_stepper.dart';
import 'package:ifloriana/components/view_all_label_component.dart';
import 'package:ifloriana/screens/experts/component/employee_list_component.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../main.dart';
import '../../experts/employee_repository.dart';
import '../../experts/model/employee_detail_response.dart';
import '../shimmer/booking_step1_shimmer.dart';

class BookingStep1Component extends StatefulWidget {
  final bool isReschedule;

  BookingStep1Component({this.isReschedule = false});

  @override
  _BookingStep1ComponentState createState() => _BookingStep1ComponentState();
}

class _BookingStep1ComponentState extends State<BookingStep1Component> {
  Future<List<EmployeeData>>? future;

  List<EmployeeData> expertList = [];

  int page = 1;
  int selectedIndex = -1;
  int? employeeId;

  String serviceIds = '';

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    if (widget.isReschedule) {
      serviceIds = bookingRequestStore.selectedServiceList.validate().map((e) => e.serviceId.validate()).toList().join(',');
    } else {
      serviceIds = bookingRequestStore.selectedServiceList.validate().map((e) => e.id.validate()).toList().join(',');
    }

    future = getEmployeeList(
        branchId: appStore.branchId,
        serviceIds: serviceIds,
        page: page,
        list: expertList,
        lastPageCallBack: (p0) {
          isLastPage = p0;
        });
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
          SnapHelperWidget<List<EmployeeData>>(
            future: future,
            loadingWidget: BookingStep1Shimmer(),
            onSuccess: (list) {
              if (list.isEmpty) {
                return NoDataWidget(
                  title: locale.noStaffFound,
                  imageWidget: EmptyStateWidget(),
                  subTitle: '${locale.noStaffAvailableForBranchMessage}\n${locale.tryToChangeYourService}',
                  retryText: locale.goBack,
                  onRetry: () {
                    finish(context);
                  },
                );
              }

              return Stack(
                fit: StackFit.expand,
                children: [
                  AnimatedScrollView(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 100),
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ViewAllLabel(label: locale.chooseYourExpert, isShowAll: false),
                          40.height,
                          AnimatedWrap(
                            runSpacing: 36,
                            spacing: 16,
                            columnCount: 2,
                            itemCount: list.length,
                            listAnimationType: ListAnimationType.Scale,
                            scaleConfiguration: ScaleConfiguration(duration: 300.milliseconds, delay: 50.milliseconds),
                            itemBuilder: (_, i) {
                              EmployeeData data = list[i];

                              return GestureDetector(
                                onTap: () {
                                  selectedIndex = i;
                                  if (selectedIndex == i) {
                                    employeeId = data.id.validate();
                                  }

                                  setState(() {});
                                },
                                child: EmployeeListComponent(
                                  expertData: data,
                                  width: context.width() / 2 - 30,
                                  decoration: boxDecorationWithRoundedCorners(backgroundColor: selectedIndex == i ? indicatorColor : context.cardColor),
                                  expertNameTextColor: selectedIndex == i ? Colors.black : null,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                    onSwipeRefresh: () async {
                      page = 1;

                      init();
                      setState(() {});

                      return await 2.seconds.delay;
                    },
                    onNextPage: () {
                      if (!isLastPage) {
                        page++;
                        appStore.setLoading(true);

                        init();
                        setState(() {});
                      }
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: CommonBottomPriceWidget(
                      //title:,
                      title: bookingRequestStore.selectedServiceList.map((e) => widget.isReschedule ? e.serviceName.validate() : e.name.validate()).toList().join(', '),
                      price: bookingRequestStore.totalAmount,
                      buttonText: locale.next,
                      onTap: () {
                        if (employeeId != null) {
                          Fluttertoast.cancel();
                          bookingRequestStore.setEmployeeIdInRequest(employeeId.validate());
                          /*log(bookingRequestStore.toJson());*/
                          customStepperController.nextPage(duration: 200.milliseconds, curve: Curves.easeOut);
                        } else {
                          toast(locale.pleaseChooseYourExpert);
                        }
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: CommonBottomPriceWidget(
                      //title:,
                      title: bookingRequestStore.selectedServiceList.map((e) => widget.isReschedule ? e.serviceName.validate() : e.name.validate()).toList().join(', '),
                      price: bookingRequestStore.totalAmount,
                      buttonText: locale.next,
                      onTap: () {
                        if (employeeId != null) {
                          Fluttertoast.cancel();
                          bookingRequestStore.setEmployeeIdInRequest(employeeId.validate());
                          /*log(bookingRequestStore.toJson());*/
                          customStepperController.nextPage(duration: 200.milliseconds, curve: Curves.easeOut);
                        } else {
                          toast(locale.pleaseChooseYourExpert);
                        }
                      },
                    ),
                  ),
                ],
              );
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
              );
            },
          ),
          Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
