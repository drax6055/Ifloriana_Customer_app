import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../network/network_utils.dart';
import '../../utils/api_end_points.dart';
import '../../utils/constants.dart';
import '../category/model/category_response.dart';
import 'model/product_dashboard_response.dart';
import 'model/product_detail_response.dart';
import 'model/product_list_response.dart';
import 'model/product_review_data_model.dart';
import 'model/product_wish_list_response.dart';
import 'model/wish_list_response.dart';

Future<ProductDashboardResponse> productDashboard({int? userId}) async {
  String uId = userId != null ? '?user_id=$userId' : '';

  String endPoint = '${APIEndPoints.productDashboard}$uId';

  try {
    productDashboardResponseCached = ProductDashboardResponse.fromJson(await handleResponse(await buildHttpResponse(endPoint, method: HttpMethodType.GET)));

    appStore.setLoading(false);

    return productDashboardResponseCached!;
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
}

Future<List<CategoryData>> getProductCategory({int? categoryId, bool isStoreCached = false, int? page = 1, var perPage = PER_PAGE_ITEM, required List<CategoryData> list, Function(bool)? lastPageCallBack}) async {
  try {
    var res = CategoryResponse.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.getProductCategory, method: HttpMethodType.GET)));

    if (page == 1) list.clear();
    list.addAll(res.category.validate());

    if (isStoreCached) {
      productCategoryListCached = list;
    }

    lastPageCallBack?.call(res.category.validate().length != perPage);

    appStore.setLoading(false);
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }

  return list;
}

Future<ProductDetailResponse> getProductDetail({required int productId, int? userId, Function(ProductDetailResponse)? onResult}) async {
  try {
    ProductDetailResponse res;

    if (userId != null) {
      res = ProductDetailResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.productDetail}?id=$productId&user_id=$userId', method: HttpMethodType.GET)));
    } else {
      res = ProductDetailResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.productDetail}?id=$productId', method: HttpMethodType.GET)));
    }

    if (onResult != null) {
      onResult.call(res);
    }

    appStore.setLoading(false);

    return res;
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
}

Future<List<ProductData>> getProductList({
  String categoryId = '',
  String isFeatured = '',
  String bestSeller = '',
  String bestDiscount = '',
  String search = '',
  int page = 1,
  var perPage = PER_PAGE_ITEM,
  required List<ProductData> products,
  Function(bool)? lastPageCallBack,
}) async {
  try {
    String searchProduct = search.isNotEmpty ? 'search=$search&' : '';
    String categoryIds = categoryId.isNotEmpty ? 'category_id=$categoryId&' : '';
    String uId = appStore.isLoggedIn ? 'user_id=${userStore.userId}&' : '';
    String isFeatures = isFeatured.isNotEmpty ? 'is_featured=$isFeatured&' : '';
    String bestSellers = bestSeller.isNotEmpty ? 'best_seller=$bestSeller&' : '';
    String bestDiscounts = bestDiscount.isNotEmpty ? 'best_discount=$bestDiscount&' : '';

    String perPages = 'per_page=$perPage&';
    String pages = 'page=$page';

    ProductListResponse res = ProductListResponse.fromJson(await handleResponse(
      await buildHttpResponse('${APIEndPoints.getProductList}?$categoryIds$uId$isFeatures$bestSellers$bestDiscounts$searchProduct$perPages$pages', method: HttpMethodType.GET),
    ));

    if (page == 1) products.clear();
    products.addAll(res.data.validate());

    lastPageCallBack?.call(res.data.validate().length != perPage);

    appStore.setLoading(false);

    return products;
  } catch (e) {
    appStore.setLoading(false);

    throw e;
  }
}

Future<WishListResponse> addWishList(request) async {
  return WishListResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.addToWishList}', method: HttpMethodType.POST, request: request)));
}

Future<WishListResponse> removeWishList({int? wishListId, int? productId}) async {
  String wishListIds = wishListId != null ? 'wishlist_id=$wishListId' : '';
  String productIds = productId != null ? 'product_id=$productId' : '';

  return WishListResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.removeWishList}?$wishListIds$productIds', method: HttpMethodType.GET)));
}

Future<ProductReviewLikeDislikeModel> addReviewLikeOrDislike(request) async {
  return ProductReviewLikeDislikeModel.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.reviewLike}', method: HttpMethodType.POST, request: request)));
}

Future<List<ProductData>> getWishList({
  required int userId,
  int page = 1,
  var perPage = PER_PAGE_ITEM,
  required List<ProductData> list,
  Function(bool)? lastPageCallBack,
}) async {
  try {
    ProductWishListResponse res = ProductWishListResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.getWishList}?user_id=$userId', method: HttpMethodType.GET)));

    if (page == 1) list.clear();
    list.addAll(res.data.validate());

    getWishListCached = list;

    lastPageCallBack?.call(res.data.validate().length != perPage);

    appStore.setLoading(false);
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
  return list;
}

Future<List<ProductReviewDataModel>> productAllReviews({
  int productId = 0,
  required int page,
  var perPage = 10,
  required List<ProductReviewDataModel> list,
  Function(bool)? lastPageCallBack,
}) async {
  try {
    String prodId = productId != 0 ? 'product_id=$productId' : '';
    String uId = appStore.isLoggedIn ? '&user_id=${userStore.userId}' : '';

    ProductReviewsResponse res = ProductReviewsResponse.fromJson(await handleResponse(await buildHttpResponse(
      '${APIEndPoints.getProductReviewList}?$prodId$uId&per_page=$perPage&page=$page',
      method: HttpMethodType.GET,
    )));

    if (page == 1) list.clear();
    list.addAll(res.data.validate());

    lastPageCallBack?.call(res.data.validate().length != perPage);

    appStore.setLoading(false);
    return list;
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
}
