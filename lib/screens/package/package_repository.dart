import 'package:ifloriana/main.dart';
import 'package:ifloriana/network/network_utils.dart';
import 'package:ifloriana/screens/package/model/package_list_model.dart';
import 'package:ifloriana/utils/api_end_points.dart';
import 'package:nb_utils/nb_utils.dart';

Future<PackageListModel> getPackages() async {
  String endPoint = '${APIEndPoints.getPackageList}';
  return PackageListModel.fromJson(await handleResponse(await buildHttpResponse(endPoint, method: HttpMethodType.GET)));
}

Future<PackageListModel> getUserPackages() async {
  String endPoint = '${APIEndPoints.getPackageList}?user_id=${userStore.userId}';
  return PackageListModel.fromJson(await handleResponse(await buildHttpResponse(endPoint, method: HttpMethodType.GET)));
}

Future<PackageListModel> getExpiringPackages() async {
  String endPoint = '${APIEndPoints.getPackageList}?expiry&&user_id=${userStore.userId}';
  return PackageListModel.fromJson(await handleResponse(await buildHttpResponse(endPoint, method: HttpMethodType.GET)));
}

Future<PackageListModel> getPackagesFilter({List<num>? serviceID}) async {
  String services = serviceID == null && serviceID!.isEmpty ? "" : "?service_id=${serviceID.join(",")}";
  String endPoint = '${APIEndPoints.getPackageList}${services}';
  return PackageListModel.fromJson(await handleResponse(await buildHttpResponse(endPoint, method: HttpMethodType.GET)));
}
