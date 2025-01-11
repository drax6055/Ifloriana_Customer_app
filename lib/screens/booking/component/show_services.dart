import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/dotted_line.dart';
import '../../../components/price_widget.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../dashboard/dashboard_repository.dart';
import '../../dashboard/models/dashboard_model.dart';
import '../../services/models/service_response.dart';
import '../model/booking_request_model.dart';

class ShowServices extends StatefulWidget {
  final List<ServiceListData> serviceListData;
  final List<String> selectedServiceIds;
  final Function(List<ServiceListData> selectedServices, List<String> selectedServiceIds) onSelectionChanged;

  ShowServices({
    required this.serviceListData,
    required this.selectedServiceIds,
    required this.onSelectionChanged,
  });

  @override
  _ShowServicesState createState() => _ShowServicesState();
}

class _ShowServicesState extends State<ShowServices> {
  List<ServiceListData> selectedService = [];
  List<String> selectedServiceIdList = [];
  BookingRequestModel taxRequest = BookingRequestModel();
  num totalAmount = 0;
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  static const int perPage = 15;
  List<ServiceListData> _serviceListData = [];

  @override
  void initState() {
    super.initState();

    // Initialize selected IDs
    selectedServiceIdList.addAll(widget.selectedServiceIds);

    // Mark services as selected based on the passed IDs
    for (var service in widget.serviceListData) {
      if (selectedServiceIdList.contains(service.id.toString())) {
        service.isServiceChecked = true;
        selectedService.add(service);
      }
    }

    // Attach scroll listener
    _scrollController.addListener(_scrollListener);
    _serviceListData.addAll(widget.serviceListData);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  // Scroll listener for lazy loading
  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      loadMoreData();
    }
  }

  Future<void> loadMoreData() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      int newPerPage = _serviceListData.length + perPage;
      DashboardResponse newData = await userDashboard(
        branchId: appStore.branchId,
        perPage: newPerPage,
      );

      if (newData.data?.service != null) {
        final newServices = newData.data!.service!;

        for (var service in newServices) {
          if (selectedServiceIdList.contains(service.id.validate().toString())) {
            service.isServiceChecked = true;
          } else {
            service.isServiceChecked = false;
          }
        }

        setState(() {
          _serviceListData.addAll(newServices.where((newService) => !_serviceListData.any((existingService) => existingService.id == newService.id)));

          if (newServices.isEmpty || newServices.length < perPage) {
            _scrollController.removeListener(_scrollListener);
          }

          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          _scrollController.removeListener(_scrollListener);
        });
      }
    } catch (e) {
      isLoading = false;
    }
  }

  void _updateTotalAmount() {
    totalAmount = selectedService.fold(0.0, (sum, service) => sum + service.defaultPrice.validate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarServicesWidget(
        context,
        title: locale.allServices,
        appBarHeight: 70,
        showLeadingIcon: true,
        roundCornerShape: true,
        onLeadingIconPressed: () {
          selectedService = _serviceListData.where((service) => service.isServiceChecked).toList();
          Navigator.pop(context, {
            'selectedService': selectedService,
            'selectedServiceIds': selectedServiceIdList,
            'totalAmount': totalAmount,
          });
        },
      ),
      body: _serviceListData.isEmpty
          ? Center(child: Text(locale.noServicesAvailable))
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: _serviceListData.length + (isLoading ? 1 : 0),
                    padding: EdgeInsets.zero,
                    physics: AlwaysScrollableScrollPhysics(),
                    separatorBuilder: (_, i) {
                      return DottedLine(
                        lineThickness: 1,
                        dashLength: 4,
                        dashColor: context.dividerColor,
                      );
                    },
                    itemBuilder: (context, index) {
                      if (isLoading && index == (_serviceListData.length)) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator(color: primaryColor)),
                        );
                      }

                      var serviceData = _serviceListData[index];
                      return serviceListWidget(serviceData: serviceData);
                    },
                  ).paddingAll(12),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        selectedService = _serviceListData.where((service) => service.isServiceChecked).toList();
                        Navigator.pop(context, {
                          'selectedService': selectedService,
                          'selectedServiceIds': selectedServiceIdList,
                          'totalAmount': totalAmount,
                        });
                      },
                      child: Text(
                        locale.confirm,
                        style: boldTextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 6,
                        shadowColor: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Widget serviceListWidget({required ServiceListData serviceData}) {
    return CheckboxListTile(
      value: serviceData.isServiceChecked,
      title: Text(
        '${serviceData.name.validate()}',
        style: boldTextStyle(
          color: appStore.isDarkMode ? textPrimaryColorGlobal : secondaryColor,
          size: 14,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      secondary: PriceWidget(price: serviceData.defaultPrice.validate(), color: context.primaryColor),
      checkboxShape: RoundedRectangleBorder(borderRadius: radius(5)),
      side: BorderSide(color: textSecondaryColorGlobal),
      dense: true,
      activeColor: appStore.isDarkMode ? primaryColor : secondaryColor,
      onChanged: (value) {
        setState(() {
          serviceData.isServiceChecked = value ?? false;

          if (serviceData.isServiceChecked) {
            if (!selectedService.contains(serviceData)) {
              selectedService.add(serviceData);
            }
            if (!selectedServiceIdList.contains(serviceData.id.validate().toString())) {
              selectedServiceIdList.add(serviceData.id.validate().toString());
            }
          } else {
            selectedService.removeWhere((service) => service.id == serviceData.id);
            selectedServiceIdList.remove(serviceData.id.validate().toString());
          }

          widget.onSelectionChanged(selectedService, selectedServiceIdList);

          _updateTotalAmount();
        });
      },
    );
  }
}
