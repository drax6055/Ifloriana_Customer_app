import 'package:ifloriana/screens/booking/model/booking_detail_response.dart';
import 'package:nb_utils/nb_utils.dart';

import '../network/network_utils.dart';
import '../utils/api_end_points.dart';
import '../utils/constants.dart';

Future savePay({
  required int bookingId,
  required String externalTransactionId,
  required String transactionType,
  required num discountPercentage,
  required num discountAmount,
  required List<TaxPercentage> taxData,
  required String paymentStatus,
  num? serviceTip,
}) async {
  Map request = {
    "booking_id": bookingId,
    "external_transaction_id": externalTransactionId, //optional,
    "transaction_type": transactionType, //stripe and razorpay
    "discount_percentage": discountPercentage,
    "discount_amount": discountAmount,
    "tax_percentage": taxData,
    "payment_status": paymentStatus == SERVICE_PAYMENT_STATUS_PAID ? 1 : 0,
  };

  if (serviceTip != null) request.putIfAbsent("tip", () => serviceTip.toInt());

  return await handleResponse(await buildHttpResponse(APIEndPoints.savePayment, request: request, method: HttpMethodType.POST));
}
