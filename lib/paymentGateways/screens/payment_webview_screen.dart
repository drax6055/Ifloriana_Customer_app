import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ifloriana/components/back_widget.dart';
import 'package:ifloriana/components/loader_widget.dart';
import 'package:ifloriana/main.dart';
import 'package:ifloriana/network/network_utils.dart';
import 'package:ifloriana/utils/app_common.dart';
import 'package:ifloriana/utils/constants.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String? url;
  final String? accessToken;

  PaymentWebViewScreen({required this.url, this.accessToken});

  @override
  _PaymentWebViewScreenState createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late WebViewController controller;

  bool isInvoiceNumberFound = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    controller = WebViewController();
    controller.loadRequest(Uri.parse('${getStringAsync(PaymentKeys.SADAD_DOMAIN)}/${widget.url}'));
    controller.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (url) {
        log('Start: $url');
      },
      onPageFinished: (url) {
        log('End: $url');
        if (url.contains('https://sadadqa.com/invoicedetail')) getHtmlBody(url);
      },
      onProgress: (progress) {
        //
      },
      onNavigationRequest: (request) {
        return NavigationDecision.navigate;
      },
    ));

    log('URL: ${getStringAsync(PaymentKeys.SADAD_DOMAIN)}/${widget.url}');
  }

  void getHtmlBody(String url) {
    get(Uri.parse(url)).then((value) {
      log(value.body);

      String txnId = parseHtmlString(value.body).removeAllWhiteSpace().splitBetween('TransactionNo:', 'InvoiceInformation').trim();

      if (txnId.isNotEmpty && txnId.startsWith('#SD')) {
        isInvoiceNumberFound = true;

        getSingleTrans(txnId.validate().replaceAll('#', ''));
      } else {
        toast(locale.lblInvalidTransaction);
      }
    }).catchError(onError);
  }

  Future<void> getSingleTrans(String? txnId) async {
    var request = Request(
      'GET',
      Uri.parse('${getStringAsync(PaymentKeys.SADAD_DOMAIN)}/api/transactions/getTransaction'),
    )..headers.addAll(buildHeaderForSadad(sadadToken: widget.accessToken.validate()));
    var params = {
      "transactionno": txnId,
    };
    request.body = jsonEncode(params);

    log(request.url);
    log(request.body);

    appStore.setLoading(true);
    StreamedResponse response = await request.send();
    appStore.setLoading(false);

    print(response.statusCode);

    if (response.statusCode.isSuccessful()) {
      String body = await response.stream.bytesToString();
      Map res = jsonDecode(body);

      if (res['invoice']['invoicestatus']['name'] == 'Paid') {
        finish(context, txnId.validate());
      } else {
        finish(context, '');
      }
    } else {
      toast(errorSomethingWentWrong);
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        locale.payment,
        color: context.primaryColor,
        textColor: Colors.white,
        backWidget: BackWidget(),
        textSize: 18,
      ),
      body: SizedBox(
        height: context.height(),
        width: context.width(),
        child: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
            Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading)),
          ],
        ),
      ),
    );
  }
}
