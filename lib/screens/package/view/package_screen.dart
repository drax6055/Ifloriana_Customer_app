import 'package:flutter/material.dart';
import 'package:ifloriana/components/app_scaffold.dart';
import 'package:ifloriana/components/empty_error_state_widget.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/screens/booking/view/booking_screen.dart';
import 'package:ifloriana/screens/package/component/package_card.dart';
import 'package:ifloriana/screens/package/model/package_list_model.dart';
import 'package:ifloriana/screens/package/package_repository.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:nb_utils/nb_utils.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  int? selectedIndex;
  Future<List<PackageListData>>? future;

  @override
  void initState() {
    super.initState();
    init();
    bookingRequestStore.selectedPackageList.clear();
  }

  Future<void> init() async {
    future = getPackagesList();
  }

  Future<List<PackageListData>> getPackagesList() async {
    List<PackageListData> listData = [];
    appStore.setLoading(true);
    await getUserPackages().then((value) {
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
    return listData;
  }

  @override
  void dispose() {
    appStore.setLoading(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: locale.myPackages,
        appBarHeight: 70,
        roundCornerShape: true,
        showLeadingIcon: Navigator.canPop(context),
      ),
      body: Stack(
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
                shrinkWrap: true,
                itemCount: snap.length,
                padding: EdgeInsets.only(bottom: 60),
                itemBuilder: (context, index) {
                  PackageListData package = snap[index];
                  return PackageCard(
                    package: package,
                    showReclaimButton: true,
                    isSelected: selectedIndex == index,
                    showRemainingQty: true,
                    onPurchase: () {
                      bookingRequestStore.selectedPackageList.clear();
                      bookingRequestStore.selectedPackageList.add(package);
                      bookingRequestStore.setPackagePurchase(true);
                      bookingRequestStore.setPackageReclaim(true);
                      BookingScreen(
                        services: [],
                        packages: bookingRequestStore.selectedPackageList,
                        isPackagePurchase: bookingRequestStore.isPackagePurchase,
                        isPackageReclaim: bookingRequestStore.isPackageReclaim,
                      ).launch(context).then((value) {
                        init().then((_) => setState(() {}));
                      });
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
