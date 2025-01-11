import 'package:ifloriana/models/base_response_model.dart';
import 'package:ifloriana/screens/cart/model/city_list_response.dart';
import 'package:ifloriana/screens/cart/model/country_list_response.dart';
import 'package:ifloriana/screens/cart/model/logistic_zone_response.dart';
import 'package:ifloriana/screens/cart/model/state_list_response.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../network/network_utils.dart';
import '../../utils/api_end_points.dart';
import '../../utils/constants.dart';
import 'model/address_list_response.dart';
import 'model/cart_list_response.dart';
import 'model/cart_response.dart';

Future<CartResponse> addToCart(request) async {
  return CartResponse.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.addToCart, request: request, method: HttpMethodType.POST)));
}

Future<BaseResponseModel> updateCart(request) async {
  return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.updateCart, request: request, method: HttpMethodType.POST)));
}

Future<CartResponse> removeFromCart({required int cartId}) async {
  return CartResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.removeFromCart}?cart_id=$cartId', method: HttpMethodType.GET)));
}

Future<(List<CartListData>, CartListResponse)> getCartList({
  int page = 1,
  var perPage = PER_PAGE_ITEM,
  required (List<CartListData>, CartListResponse) cartList,
  Function(bool)? lastPageCallBack,
}) async {
  try {
    var res = CartListResponse.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.getCartList, method: HttpMethodType.GET)));

    if (page == 1) cartList.$1.clear();
    cartList.$1.addAll(res.data.validate());
    cartList.$2.cartPriceData = res.cartPriceData;

    productStore.setCartItemCount(cartList.$1.length);

    lastPageCallBack?.call(res.data.validate().length != perPage);

    appStore.setLoading(false);

    return cartList;
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
}

Future<List<UserAddress>> getAddressList({
  int page = 1,
  var perPage = PER_PAGE_ITEM,
  required List<UserAddress> addressList,
  Function(bool)? lastPageCallBack,
}) async {
  try {
    var res = AddressListResponse.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.getAddressList + "?per_page=$perPage&page=$page", method: HttpMethodType.GET)));

    if (page == 1) addressList.clear();
    addressList.addAll(res.userAddress.validate());

    lastPageCallBack?.call(res.userAddress.validate().length != perPage);

    appStore.setLoading(false);

    return addressList;
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
}

Future<BaseResponseModel> removeAddress({required int addressId}) async {
  return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.removeAddress}?id=$addressId', method: HttpMethodType.GET)));
}

Future<BaseResponseModel> addEditAddress({required Map request, bool isEdit = false}) async {
  return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(isEdit ? APIEndPoints.editAddress : APIEndPoints.addAddress, request: request, method: HttpMethodType.POST)));
}

Future<List<CountryData>> getCountryList() async {
  var res = CountryListResponse.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.countryList, method: HttpMethodType.GET)));
  appStore.setLoading(false);

  return res.data.validate();
}

Future<List<StateData>> getStateList({required int countryId}) async {
  var res = StateListResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.stateList}?country_id=$countryId', method: HttpMethodType.GET)));
  appStore.setLoading(false);

  return res.data.validate();
}

Future<List<CityData>> getCityList({required int stateId}) async {
  var res = CityListResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.cityList}?state_id=$stateId', method: HttpMethodType.GET)));
  appStore.setLoading(false);

  return res.data.validate();
}

Future<List<LogisticZoneData>> getLogisticZone({required int addressId}) async {
  try {
    var res = LogisticZoneResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.getLogisticZoneList}?address_id=$addressId', method: HttpMethodType.GET)));
    appStore.setLoading(false);

    return res.data.validate();
  } catch (e) {
    appStore.setLoading(false);
    throw e;
  }
}
