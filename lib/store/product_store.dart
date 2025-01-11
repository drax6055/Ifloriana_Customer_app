import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../screens/cart/model/address_list_response.dart';
import '../screens/cart/model/cart_list_response.dart';
import '../screens/cart/model/logistic_zone_response.dart';
import '../screens/product/model/product_list_response.dart';

part 'product_store.g.dart';

class ProductStore = _ProductStore with _$ProductStore;

abstract class _ProductStore with Store {
  @observable
  int qty = 1;

  @observable
  List<ProductData> inWishListIds = ObservableList();

  @observable
  int isWishList = 0;

  @observable
  int cartItemCount = 0;

  @observable
  String fullName = '';

  @observable
  String customerEmail = '';

  @observable
  String contactNumber = '';

  @observable
  String alternateContactNumber = '';

  @observable
  VariationData selectedVariationData = VariationData();

  @observable
  CartPriceData cartPriceData = CartPriceData();

  @observable
  UserAddress addressData = UserAddress();

  @observable
  LogisticZoneData logisticZoneData = LogisticZoneData();

  @observable
  List<CartListData> productCartListData = ObservableList();

  @observable
  List<String> selectedOrderStatusList = ObservableList();

  @computed
  num get totalAmount => cartPriceData.totalPayableAmount.validate() + logisticZoneData.standardDeliveryCharge.validate();

  @action
  void setSelectedOrderStatusList(List<String> selectedOrderStatusListRequest) {
    selectedOrderStatusList = ObservableList.of(selectedOrderStatusListRequest);
  }

  @action
  void setProductQuantity(int val) {
    qty = val;
  }

  @action
  void setToWishList(List<ProductData> val) {
    inWishListIds = ObservableList.of(val);
  }

  @action
  void setWishList(int val) {
    isWishList = val;
  }

  @action
  void setCartItemCount(int val) {
    cartItemCount = val;
  }

  @action
  Future<void> setCustomerFullName(String val) async {
    fullName = val;
  }

  @action
  Future<void> setCustomerEmail(String val) async {
    customerEmail = val;
  }

  @action
  Future<void> setCustomerContactNumber(String val) async {
    contactNumber = val;
  }

  @action
  Future<void> setCustomerAlternateContactNumber(String val) async {
    alternateContactNumber = val;
  }

  @action
  void setSelectedVariationData(VariationData data) {
    selectedVariationData = data;
  }

  @action
  void setCartPriceData(CartPriceData data) {
    cartPriceData = data;
  }

  @action
  void setSelectedAddressData(UserAddress data) {
    addressData = data;
  }

  @action
  void setLogisticZoneData(LogisticZoneData data) {
    logisticZoneData = data;
  }

  @action
  void setCartListData(List<CartListData> cartListData) {
    productCartListData = ObservableList.of(cartListData);
  }
}