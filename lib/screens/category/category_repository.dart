import 'package:ifloriana/network/network_utils.dart';
import 'package:ifloriana/screens/category/model/category_response.dart';
import 'package:ifloriana/utils/api_end_points.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../utils/constants.dart';

Future<List<CategoryData>> getCategoryList({int? categoryId, bool isStoreCached = false, int? page = 1, var perPage = PER_PAGE_ITEM, required List<CategoryData> list, Function(bool)? lastPageCallBack}) async {
  try {
    CategoryResponse res;

    if (categoryId != null) {
      res = CategoryResponse.fromJson(
          await handleResponse(await buildHttpResponse('${APIEndPoints.categoryList}?category_id=$categoryId&per_page=$perPage&page=$page', method: HttpMethodType.GET)));
    } else {
      res = CategoryResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.categoryList}?per_page=$perPage&page=$page', method: HttpMethodType.GET)));
    }

    if (page == 1) list.clear();
    list.addAll(res.category.validate());

    if (isStoreCached) {
      categoryListCached = list;
    }

    lastPageCallBack?.call(res.category.validate().length != perPage);

    appStore.setLoading(false);
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
  return list;
}
