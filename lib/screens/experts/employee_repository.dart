import 'package:ifloriana/screens/experts/model/employee_detail_response.dart';
import 'package:ifloriana/screens/experts/model/employee_response.dart';
import 'package:ifloriana/utils/api_end_points.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../network/network_utils.dart';
import '../../utils/constants.dart';

Future<List<EmployeeData>> getEmployeeList({
  int? branchId,
  String serviceIds = '',
  String orderBy = '',
  int page = 1,
  var perPage = PER_PAGE_ITEM,
  required List<EmployeeData> list,
  Function(bool)? lastPageCallBack,
}) async {
  try {
    String order = orderBy.isNotEmpty ? '&order_by=$orderBy' : '';
    String services = serviceIds.isNotEmpty ? '&service_ids=$serviceIds' : '';

    EmployeeResponse res = EmployeeResponse.fromJson(await handleResponse(await buildHttpResponse(
      '${APIEndPoints.employeeList}?branch_id=$branchId$order$services&per_page=$perPage&page=$page',
      method: HttpMethodType.GET,
    )));

    if (page == 1) list.clear();
    list.addAll(res.topExperts.validate());

    employeeListCached = list;

    lastPageCallBack?.call(res.topExperts.validate().length != perPage);

    appStore.setLoading(false);
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
  return list;
}

Future<EmployeeDetailResponse> getEmployeeDetail({required int branchId, required int employeeId}) async {
  try {
    var res = EmployeeDetailResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.employeeDetail}?branch_id=$branchId&employee_id=$employeeId', method: HttpMethodType.GET)));

    if (!employeeDetailCachedData.any((element) => element?.$1 == employeeId)) {
      employeeDetailCachedData.add((employeeId, res));
    } else {
      int index = employeeDetailCachedData.indexWhere((element) => element?.$1 == employeeId);
      employeeDetailCachedData[index] = (employeeId, res);
    }

    appStore.setLoading(false);

    return res;
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
}
