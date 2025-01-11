import 'package:ifloriana/models/review_data.dart';
import 'package:ifloriana/screens/review/model/employee_review_model.dart';
import 'package:ifloriana/utils/api_end_points.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../models/base_response_model.dart';
import '../../network/network_utils.dart';

Future<BaseResponseModel> updateReview(Map request) async {
  return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.saveRating, request: request, method: HttpMethodType.POST)));
}

Future<BaseResponseModel> deleteReview({required int id}) async {
  return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.deleteRating, request: {"id": id}, method: HttpMethodType.POST)));
}

Future<List<ReviewData>> employeeReviews({
  int empId = 0,
  int branId = 0,
  required int page,
  var perPage = 10,
  required List<ReviewData> list,
  Function(bool)? lastPageCallBack,
}) async {
  try {
    String employeeId = empId != 0 ? '&employee_id=$empId' : '';
    String branchId = branId != 0 ? 'branch_id=$branId' : '';

    EmployeeReviewResponse res = EmployeeReviewResponse.fromJson(await handleResponse(await buildHttpResponse(
      '${APIEndPoints.getRating}?$branchId$employeeId&per_page=$perPage&page=$page',
      method: HttpMethodType.GET,
    )));

    if (page == 1) list.clear();
    list.addAll(res.reviewData.validate());

    lastPageCallBack?.call(res.reviewData.validate().length != perPage);

    appStore.setLoading(false);
    return list;
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
}
