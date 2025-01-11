import 'cart_list_response.dart';

class CartResponse {
  CartListData? cart;
  String? message;
  bool? status;

  CartResponse({this.cart, this.message, this.status});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      cart: json['cart'] != null ? CartListData.fromJson(json['cart']) : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.cart != null) {
      data['cart'] = this.cart!.toJson();
    }
    return data;
  }
}
