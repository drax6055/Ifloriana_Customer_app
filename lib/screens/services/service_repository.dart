import 'package:ifloriana/screens/services/models/service_response.dart';
import 'package:ifloriana/utils/api_end_points.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../network/network_utils.dart';
import '../../utils/constants.dart';

Future<List<ServiceListData>> getServiceList({
  int? branchId,
  String categoryId = '',
  String subCategoryId = '',
  String search = '',
  int page = 1,
  var perPage = PER_PAGE_ITEM,
  required List<ServiceListData> list,
  Function(bool)? lastPageCallBack,
}) async {
  try {
    String req;

    String searchPara = search.isNotEmpty ? '&search=$search' : '';

    if (subCategoryId.isNotEmpty) {
      req = subCategoryId != "-1" ? '&subcategory_id=$subCategoryId' : '';
    } else {
      req = categoryId.isNotEmpty ? '&category_id=$categoryId' : '';
    }

    ServiceResponse res = ServiceResponse.fromJson(await handleResponse(await buildHttpResponse(
      '${APIEndPoints.serviceList}?branch_id=$branchId$req$searchPara&per_page=$perPage&page=$page',
      method: HttpMethodType.GET,
    )));
    if (page == 1) list.clear();
    list.addAll(res.data.validate());

    lastPageCallBack?.call(res.data.validate().length != perPage);

    appStore.setLoading(false);
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
  return list;
}
