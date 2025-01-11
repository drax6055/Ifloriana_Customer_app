import 'package:flutter/material.dart';
import 'package:ifloriana/components/custom_stepper.dart';
import 'package:ifloriana/screens/booking/component/booking_step1_component.dart';
import 'package:ifloriana/screens/booking/component/booking_step3_component.dart';
import 'package:ifloriana/screens/package/model/package_list_model.dart';
import 'package:ifloriana/store/booking_request_store.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../../services/models/service_response.dart';
import '../component/booking_step2_component.dart';

class CustomStep {
  final String? title;
  final Widget? page;

  CustomStep({this.title, this.page});
}

class BookingScreen extends StatefulWidget {
  final List<ServiceListData> services;
  final List<PackageListData>? packages;
  final bool isReschedule;
  final bool isPackagePurchase;
  final bool isPackageReclaim;

  const BookingScreen({super.key, required this.services, this.isPackageReclaim = false, this.packages, this.isPackagePurchase = false, this.isReschedule = false});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  List<CustomStep>? stepsList;
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    init();

    bookingRequestStore = BookingRequestStore();

    bookingRequestStore.setSelectedServiceListInRequest(widget.services, isRescheduleInRequest: widget.isReschedule);
    if (widget.isPackagePurchase) {
      bookingRequestStore.setSelectedPackageListInRequest(widget.packages.validate());
      bookingRequestStore.setPackagePurchase(true);
    }
    if (widget.isPackageReclaim) {
      bookingRequestStore.setPackageReclaim(true);
    }
    if (branchConfigurationCached != null) {
      bookingRequestStore.setTaxPercentageInRequest(branchConfigurationCached!.tax.validate());
    }
  }

  void init() async {
    stepsList = [
      CustomStep(title: locale.staff, page: BookingStep1Component(isReschedule: widget.isReschedule)),
      CustomStep(title: '${locale.date} & ${locale.time}', page: BookingStep2Component(isReschedule: widget.isReschedule)),
      CustomStep(title: locale.payment, page: BookingStep3Component(isReschedule: widget.isReschedule)),
    ];
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
    return WillPopScope(
      onWillPop: () {
        if (currentStep == 0) {
          return Future.value(true);
        } else {
          bookingRequestStore.time = '';
          customStepperController.previousPage(duration: 300.milliseconds, curve: Curves.linear);
          LiveStream().emit(LiveStreamKeyConst.LIVESTREAM_CHANGE_STEP, currentStep);
          return Future.value(false);
        }
      },
      child: Scaffold(
        body: CustomStepper(
          stepsList: stepsList.validate(),
          onChange: (p0) {
            currentStep = p0;
          },
        ),
      ),
    );
  }
}
