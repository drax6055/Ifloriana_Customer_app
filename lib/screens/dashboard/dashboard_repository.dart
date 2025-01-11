import 'package:ifloriana/screens/package/model/package_list_model.dart';
import 'package:ifloriana/screens/package/package_repository.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../network/network_utils.dart';
import '../../utils/api_end_points.dart';
import 'models/dashboard_model.dart';

Future<DashboardResponse> userDashboard({required int branchId}) async {
  /// If any below condition not satisfied, call this
  String endPoint = '${APIEndPoints.dashboardDetail}?branch_id=$branchId';

  try {
    dashboardResponseCached = DashboardResponse.fromJson(await handleResponse(await buildHttpResponse(endPoint, method: HttpMethodType.GET)));
    dashboardResponseCached!.expiringPackagesList = await getExpiredPackages();
    await getPackagesList().then(
          (value) async {
        if (value.isNotEmpty) {
          await getUserPackagesList().then(
                (val) {
              if (val.isNotEmpty) {
                val.forEachIndexed(
                      (packageData, index) {
                    if (packageData.userPackage.isNotEmpty) {
                      if (value.any((e) => e.id == packageData.id)) {
                        int index = value.validate().indexWhere((e) => e.id == packageData.id);
                        if (index > -1) {
                          value[index] = packageData;
                        }
                      } else {
                        value.validate().add(packageData);
                      }
                      dashboardResponseCached!.packagesList = value;
                    }
                  },
                );
              } else {
                dashboardResponseCached!.packagesList = value;
              }
            },
          );
        }
      },
    );

    appStore.setLoading(false);

    return dashboardResponseCached!;
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
}

Future<List<PackageListData>> getExpiredPackages() async {
  List<PackageListData> expiringPackagesList = [];
  await getExpiringPackages().then((value) {
    if (value.packageListData != null && value.packageListData!.isNotEmpty) {
      expiringPackagesList = value.packageListData.validate();
      return expiringPackagesList;
    }
  }).catchError((e) {
    toast(e.toString(), print: true);
    throw e;
  });
  return expiringPackagesList;
}

Future<List<PackageListData>> getPackagesList() async {
  List<PackageListData> packageList = [];
  await getPackages().then((value) {
    if (value.packageListData.isNotEmpty) {
      packageList = value.packageListData;
      return packageList;
    }
  }).catchError((e) {
    toast(e.toString(), print: true);
    throw e;
  });
  return packageList;
}

Future<List<PackageListData>> getUserPackagesList() async {
  List<PackageListData> userPackagesList = [];
  await getUserPackages().then((value) {
    if (value.packageListData.isNotEmpty) {
      userPackagesList.addAll(value.packageListData.validate());
      return userPackagesList;
    }
  }).catchError((e) {
    toast(e.toString(), print: true);
    throw e;
  });
  return userPackagesList;
}
