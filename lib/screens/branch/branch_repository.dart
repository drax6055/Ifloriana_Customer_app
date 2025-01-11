import 'package:ifloriana/main.dart';
import 'package:ifloriana/network/network_utils.dart';
import 'package:ifloriana/screens/branch/model/branch_configuration_response.dart';
import 'package:ifloriana/screens/branch/model/branch_detail_response.dart';
import 'package:ifloriana/screens/branch/model/branch_gallery_list_response.dart';
import 'package:ifloriana/screens/branch/model/branch_response.dart';
import 'package:ifloriana/utils/api_end_points.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../models/review_data.dart';
import '../dashboard/view/dashboard_screen.dart';
import '../experts/model/employee_detail_response.dart';
import '../services/models/service_response.dart';
import 'model/branch_employee_list_response.dart';
import 'model/branch_review_list_response.dart';

Future<List<BranchData>> getBranchList({
  int page = 1,
  var perPage = PER_PAGE_ITEM,
  required List<BranchData> branchList,
  Function(bool)? lastPageCallBack,
  BranchData? selectedBranch,
}) async {
  try {
    BranchResponse res = BranchResponse.fromJson(await handleResponse(await buildHttpResponse(
      '${APIEndPoints.branchList}?per_page=$perPage&page=$page',
      method: HttpMethodType.GET,
    )));
    if (page == 1) {
      branchListCached = branchList;

      branchList.clear();
    }
    branchList.addAll(res.data.validate());

    lastPageCallBack?.call(res.data.validate().length != perPage);

    appStore.setLoading(false);
    return branchList;
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
}

Future<void> setBranchAndRedirectToDashboard(BranchData branchData) async {
  await appStore.setBranchId(branchData.id.validate(value: UNSELECTED_BRANCH_ID));
  await appStore.setBranchAddress(branchData.addressLine1.validate());
  await appStore.setBranchName(branchData.name.validate());
  await appStore.setBranchContactNumber(branchData.contactNumber.validate());

  push(DashboardScreen(), isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
}

Future<BranchDetailResponse> getBranchDetail(int branchId) async {
  try {
    var res = BranchDetailResponse.fromJson(await handleResponse(await buildHttpResponse(
      '${APIEndPoints.branchDetail}?branch_id=$branchId',
      method: HttpMethodType.GET,
    )));

    if (!branchDetailCachedData.any((element) => element.data?.id == branchId)) {
      branchDetailCachedData.add(res);
    } else {
      int index = branchDetailCachedData.indexWhere((element) => element.data?.id == branchId);
      branchDetailCachedData[index] = res;
    }

    appStore.setLoading(false);

    return res;
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
}

Future<List<EmployeeData>> getBranchEmployeeList({int? branchId, int page = 1, var perPage = PER_PAGE_ITEM, required List<EmployeeData> list, Function(bool)? lastPageCallBack}) async {
  try {
    BranchEmployeeListResponse res = BranchEmployeeListResponse.fromJson(await handleResponse(await buildHttpResponse(
      '${APIEndPoints.branchEmployee}?branch_id=$branchId&per_page=$perPage&page=$page',
      method: HttpMethodType.GET,
    )));
    if (page == 1) list.clear();
    list.addAll(res.data.validate());

    branchStaffListResponseCached = list;

    lastPageCallBack?.call(res.data.validate().length != perPage);

    appStore.setLoading(false);
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
  return list;
}

Future<List<BranchGalleryData>> getBranchGalleryList({int? branchId, int page = 1, var perPage = PER_PAGE_ITEM, required List<BranchGalleryData> list, Function(bool)? lastPageCallBack}) async {
  try {
    BranchGalleryListResponse res = BranchGalleryListResponse.fromJson(await handleResponse(await buildHttpResponse(
      '${APIEndPoints.branchGallery}?branch_id=$branchId&per_page=$perPage&page=$page',
      method: HttpMethodType.GET,
    )));
    if (page == 1) list.clear();
    list.addAll(res.data.validate());

    branchGalleryListResponseCached = list;

    lastPageCallBack?.call(res.data.validate().length != perPage);

    appStore.setLoading(false);
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
  return list;
}

Future<List<ReviewData>> getBranchReviewList({int? branchId, int page = 1, var perPage = PER_PAGE_ITEM, required List<ReviewData> list, Function(bool)? lastPageCallBack}) async {
  try {
    BranchReviewListResponse res = BranchReviewListResponse.fromJson(await handleResponse(await buildHttpResponse(
      '${APIEndPoints.branchReview}?branch_id=$branchId&per_page=$perPage&page=$page',
      method: HttpMethodType.GET,
    )));
    if (page == 1) list.clear();
    list.addAll(res.data.validate());

    branchReviewListResponseCached = list;

    lastPageCallBack?.call(res.data.validate().length != perPage);

    appStore.setLoading(false);
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
  return list;
}

Future<List<ServiceListData>> getBranchServiceList({int? branchId, int page = 1, var perPage = PER_PAGE_ITEM, required List<ServiceListData> list, Function(bool)? lastPageCallBack}) async {
  try {
    ServiceResponse res = ServiceResponse.fromJson(await handleResponse(await buildHttpResponse(
      '${APIEndPoints.branchService}?branch_id=$branchId&per_page=$perPage&page=$page',
      method: HttpMethodType.GET,
    )));
    if (page == 1) list.clear();
    list.addAll(res.data.validate());

    branchServiceListResponseCached = list;

    lastPageCallBack?.call(res.data.validate().length != perPage);

    appStore.setLoading(false);
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
  return list;
}

Future<BranchConfigurationResponse> getBranchConfiguration(int branchId) async {
  try {
    var res = BranchConfigurationResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.branchConfiguration}?branch_id=$branchId', method: HttpMethodType.GET)));
    appStore.setLoading(false);
    
    bookingRequestStore.setTaxPercentageInRequest(res.data!.tax!);

    branchConfigurationCached = res.data;

    return res;
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
}
