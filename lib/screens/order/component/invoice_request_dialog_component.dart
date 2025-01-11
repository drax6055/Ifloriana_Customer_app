import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ifloriana/configs.dart';
import 'package:ifloriana/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../main.dart';

class InvoiceRequestDialogComponent extends StatefulWidget {
  final int? bookingId;

  InvoiceRequestDialogComponent({required this.bookingId});

  @override
  State<InvoiceRequestDialogComponent> createState() => _InvoiceRequestDialogComponentState();
}

class _InvoiceRequestDialogComponentState extends State<InvoiceRequestDialogComponent> {
  bool isLoading = false; // Track loading state


// Function to request storage permissions
  Future<bool> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<void> downloadPdf() async {
    try {
      setState(() {
        isLoading = true; // Set loading state to true
      });

      // Request storage permission
      bool hasPermission = await requestStoragePermission();
      if (!hasPermission) {
        toast("Storage permission is required to download the invoice.");
        return;
      }

      // API URL
      final url = '$DOMAIN_URL/api/order-invoice-download?id=${widget.bookingId}';

      // Fetch the response
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Use the InvoiceResponse model to parse the response
        InvoiceResponse invoiceResponse = InvoiceResponse.fromJson(jsonResponse);

        if (invoiceResponse.status && invoiceResponse.link.isNotEmpty) {
          // Download the PDF
          final pdfResponse = await http.get(Uri.parse(invoiceResponse.link));

          // Get the "Downloads" directory
          Directory? directory = await getExternalStorageDirectory();
          if (directory != null) {
            // Construct path to Downloads folder
            String downloadPath = "/storage/emulated/0/Download/invoice_${widget.bookingId}.pdf";

            // Use the correct "Download" folder path
            File file = File(downloadPath);
            await file.writeAsBytes(pdfResponse.bodyBytes);

            // Open the PDF using open_file package
            OpenFile.open(downloadPath);
          } else {
            toast(locale.failedToAccessExternalStorage);
          }
        } else {
          toast(locale.invalidResponseOrLinkNotFound);
        }
      } else {
        toast(locale.failedToFetchInvoiceDetails);
      }
    } catch (e) {
      print(e);
      toast('${locale.error}: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  // Function to download the PDF
  // Future<void> downloadPdf() async {
  //   try {
  //     setState(() {
  //       isLoading = true; // Set loading state to true
  //     });
  //
  //     // API URL
  //     final url = '$DOMAIN_URL/api/order-invoice-download?id=${widget.bookingId}';
  //
  //     // Fetch the response
  //     final response = await http.get(Uri.parse(url));
  //
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  //
  //       // Use the InvoiceResponse model to parse the response
  //       InvoiceResponse invoiceResponse = InvoiceResponse.fromJson(jsonResponse);
  //
  //       if (invoiceResponse.status && invoiceResponse.link.isNotEmpty) {
  //         // Download the PDF
  //         final pdfResponse = await http.get(Uri.parse(invoiceResponse.link));
  //
  //         // Get the "Downloads" directory
  //         Directory? directory = await getExternalStorageDirectory();
  //         if (directory != null) {
  //           // Construct path to Downloads folder
  //           String downloadPath = "/storage/emulated/0/Download/invoice_${widget.bookingId}.pdf";
  //
  //           // Use the correct "Download" folder path
  //           File file = File(downloadPath);
  //           await file.writeAsBytes(pdfResponse.bodyBytes);
  //
  //           // Open the PDF using open_file package
  //           OpenFile.open(downloadPath);
  //         } else {
  //           toast(locale.failedToAccessExternalStorage);
  //         }
  //       } else {
  //         toast(locale.invalidResponseOrLinkNotFound);
  //       }
  //     } else {
  //       toast(locale.failedToFetchInvoiceDetails);
  //     }
  //   } catch (e) {
  //     print(e);
  //     toast('${locale.error}: $e');
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          title: Text(locale.downloadInvoice),
          content: Text(locale.wouldYouLikeToDownloadTheInvoice),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: primaryColor,
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(locale.cancel),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    await downloadPdf();
                  },
                  child: Text(locale.download),
                ),
              ],
            ),
          ],
          // Stack allows overlaying the loading indicator on top of the AlertDialog
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.all(20),
        ),
        // Overlay the CircularProgressIndicator when loading
        Positioned(
          child: isLoading
              ? Center(
                  child: Container(
                    color: Colors.black.withOpacity(0.5), // Dim the background
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : Container(),
        ),
      ],
    );
  }
}

class InvoiceResponse {
  final bool status;
  final String link;

  InvoiceResponse({required this.status, required this.link});

  // Factory method to create an instance from JSON
  factory InvoiceResponse.fromJson(Map<String, dynamic> json) {
    return InvoiceResponse(
      status: json['status'],
      link: json['link'],
    );
  }
}
