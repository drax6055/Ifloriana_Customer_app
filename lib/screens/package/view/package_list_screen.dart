import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/components/empty_error_state_widget.dart';
import 'package:ifloriana/components/loader_widget.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/dashboard/dashboard_repository.dart';
import 'package:ifloriana/screens/package/component/package_card.dart';
import 'package:ifloriana/screens/package/model/package_list_model.dart';
import 'package:ifloriana/screens/package/package_repository.dart';
import 'package:ifloriana/screens/services/models/service_response.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../booking/view/booking_screen.dart';

class PackageListScreen extends StatefulWidget {
  final List<PackageListData>? filterListData;
  final List<ServiceListData>? services;

  PackageListScreen({super.key, this.filterListData, this.services});

  @override
  State<PackageListScreen> createState() => _PackageListScreenState();
}

class _PackageListScreenState extends State<PackageListScreen> {
  int? selectedIndex;
  Future<List<PackageListData>>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    bookingRequestStore.selectedPackageList.clear();
    future = getPackagesList().then(
          (value) async {
        if (value.isNotEmpty) {
          await getUserPackagesList().then((val) {
            if (val.isNotEmpty) {
              for (var packageData in val) {
                if (packageData.userPackage.isNotEmpty) {
                  if (value.any((e) => e.id == packageData.id)) {
                    int index = value.indexWhere((e) => e.id == packageData.id);
                    if (index > -1) {
                      value[index] = packageData;
                    }
                  } else {
                    value.add(packageData);
                  }
                  dashboardResponseCached!.packagesList = value;
                }
              }
            } else {
              dashboardResponseCached!.packagesList = value;
            }
          });
        }
        // Return non-nullable value, default to an empty list if null
        return dashboardResponseCached?.packagesList ?? <PackageListData>[];
      },
    );

  }

  Future<List<PackageListData>> getPackagesList() async {
    List<PackageListData> listData = [];
    if (widget.filterListData != null) {
      listData = widget.filterListData!;
    } else {
      appStore.setLoading(true);
      await getPackages().then((value) {
        if (value.packageListData.isNotEmpty) {
          value.packageListData.forEach((element) {
            listData.add(element);
          });
          appStore.setLoading(false);
          return listData;
        }
        appStore.setLoading(false);
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString(), print: true);
        throw e;
      });
    }

    return listData;
  }

  @override
  void dispose() {
    super.dispose();
    appStore.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: locale.packages,
        appBarHeight: 70,
        roundCornerShape: true,
        showLeadingIcon: Navigator.canPop(context),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SnapHelperWidget<List<PackageListData>>(
            future: future,
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                retryText: locale.reload,
                imageWidget: ErrorStateWidget(),
                onRetry: () {
                  appStore.setLoading(true);
                  init().then((value) => setState(() {}));
                },
              );
            },
            loadingWidget: Offstage(),
            onSuccess: (snap) {
              if (snap.isEmpty) {
                return NoDataWidget(
                  title: locale.noPackagesFound,
                  retryText: locale.reload,
                  imageWidget: ErrorStateWidget(),
                  onRetry: () {
                    appStore.setLoading(true);
                    init().then((value) => setState(() {}));
                  },
                );
              }
              return AnimatedListView(
                padding: EdgeInsets.only(bottom: 170),
                shrinkWrap: true,
                itemCount: snap.length,
                itemBuilder: (context, index) {
                  PackageListData package = snap[index];
                   if (package.branchId == appStore.branchId) {
                    return Observer(builder: (context) {
                    return PackageCard(
                      package: package,
                      isSelected: bookingRequestStore.selectedPackageList.contains(package),
                      isPurchased: package.userPackage.isNotEmpty,
                      showPurchaseButton:  package.userPackage.isEmpty,
                      showReclaimButton:  package.userPackage.isNotEmpty,
                      onPurchase: () {
                        bookingRequestStore.selectedPackageList.clear();
                        bookingRequestStore.selectedPackageList.add(package);
                        bookingRequestStore.setPackagePurchase(true);
                        BookingScreen(services: widget.services.validate(), packages: bookingRequestStore.selectedPackageList, isPackagePurchase: true)
                            .launch(context)
                            .then((value) => setState(() {}));
                      },
                    );
                  });
                  }else{
                     return Offstage();
                   }
                },
              );
            },
          ),
          Observer(builder: (context) => LoaderWidget().center().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
