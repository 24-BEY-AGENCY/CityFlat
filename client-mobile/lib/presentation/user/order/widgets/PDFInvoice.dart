import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../shared/widgets/custom_icons2.dart';
import '../../../shared/widgets/custom_light_elevated_button.dart';
import '../../../shared/widgets/custom_toast.dart';

class PDFInvoice extends StatefulWidget {
  final dynamic order;

  const PDFInvoice({Key? key, required this.order}) : super(key: key);

  @override
  State<PDFInvoice> createState() => _PDFInvoiceState();
}

class _PDFInvoiceState extends State<PDFInvoice> {
  FToast? fToast;

  Future<void> _showSuccessToast() {
    fToast = FToast();
    fToast!.init(context);
    return Future.delayed(const Duration(milliseconds: 500), () {
      fToast!.showToast(
        child: const CustomToast(
          text: "Your invoice has been downloaded successfully.",
          textColor: Color.fromRGBO(255, 255, 255, 1),
          backgroundColor: Color.fromRGBO(6, 190, 86, 1),
        ),
        toastDuration: const Duration(seconds: 5),
        gravity: ToastGravity.TOP,
      );
    });
  }

  pw.Widget billInfoBuilder(String boldText, String normalText, pw.Font? font,
      List<pw.Font> fontFallback) {
    return pw.RichText(
      text: pw.TextSpan(
        children: [
          pw.TextSpan(
            text: "$boldText : ",
            style: pw.TextStyle(
              color: PdfColors.black,
              fontSize: 16.0,
              fontWeight: pw.FontWeight.normal,
            ),
          ),
          pw.TextSpan(
            text: normalText,
            style: pw.TextStyle(
              color: PdfColors.black,
              fontSize: 16.0,
              fontWeight: pw.FontWeight.normal,
              font: font,
              fontFallback: fontFallback,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget headerTextBuilder(
      String text, pw.Font? font, List<pw.Font> fontFallback) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          color: PdfColors.black,
          fontSize: 14.0,
          fontWeight: pw.FontWeight.normal,
          font: font,
          fontFallback: fontFallback,
        ),
      ),
    );
  }

  pw.Widget tableTextBuilder(
      String text, pw.Font? font, List<pw.Font> fontFallback) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          color: PdfColors.black,
          fontSize: 14.0,
          fontWeight: pw.FontWeight.normal,
          font: font,
          fontFallback: fontFallback,
        ),
      ),
    );
  }

  Future<pw.Document> generatePDF(dynamic order) async {
    final pdf = pw.Document();
    final font =
        await rootBundle.load("assets/fonts/Roboto/Roboto-Regular.ttf");
    final ttfFont = pw.Font.ttf(font);
    final _robotoRegularFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/Roboto/Roboto-Regular.ttf"),
    );

    pdf.addPage(
      pw.Page(
        build: (context) {
          const curScaleFactor = 1.0;
          final onePercentOfWidth = PdfPageFormat.a4.width / 100;

          return pw.Container(
            padding: const pw.EdgeInsets.only(
                top: 50.0, left: 20.0, right: 20.0, bottom: 50.0),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Container(
                  margin: const pw.EdgeInsets.symmetric(vertical: 20.0),
                  child: pw.Text(
                    "INVOICE",
                    style: pw.TextStyle(
                      color: PdfColors.black,
                      fontSize: 38,
                      fontWeight: pw.FontWeight.normal,
                      font: ttfFont,
                      fontFallback: [_robotoRegularFont],
                    ),
                  ),
                ),
                billInfoBuilder(
                    "Bill Date",
                    DateFormat('dd-MM-yyyy').format(order!.updatedAt!),
                    ttfFont,
                    [_robotoRegularFont]),
                billInfoBuilder("Customer", order!.user.name, ttfFont,
                    [_robotoRegularFont]),
                billInfoBuilder(
                    "Email", order!.user.email, ttfFont, [_robotoRegularFont]),
                pw.SizedBox(
                  height: 10.0,
                ),
                pw.Table(
                  columnWidths: {
                    0: pw.FixedColumnWidth(onePercentOfWidth * 40),
                    1: pw.FixedColumnWidth(onePercentOfWidth * 40),
                    2: pw.FixedColumnWidth(onePercentOfWidth * 40),
                    3: pw.FixedColumnWidth(onePercentOfWidth * 40),
                    4: pw.FixedColumnWidth(onePercentOfWidth * 40),
                  },
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Container(
                            child: headerTextBuilder(
                                "Apartments", ttfFont, [_robotoRegularFont])),
                        pw.Container(
                            child: headerTextBuilder(
                                "Check In", ttfFont, [_robotoRegularFont])),
                        pw.Container(
                            child: headerTextBuilder(
                                "Check Out", ttfFont, [_robotoRegularFont])),
                        pw.Container(
                            child: headerTextBuilder("Apartment Fees", ttfFont,
                                [_robotoRegularFont])),
                        pw.Container(
                            child: headerTextBuilder("Services Fees", ttfFont,
                                [_robotoRegularFont])),
                      ],
                    ),
                    pw.TableRow(
                      decoration: pw.BoxDecoration(
                        color: PdfColors.grey200,
                        borderRadius: pw.BorderRadius.circular(15.0),
                      ),
                      children: [
                        pw.Container(
                            child: tableTextBuilder(
                                order!.appartment!.apartmentName,
                                ttfFont,
                                [_robotoRegularFont])),
                        pw.Container(
                            child: tableTextBuilder(
                                DateFormat('dd-MM-yyyy')
                                    .format(order!.startDate!),
                                ttfFont,
                                [_robotoRegularFont])),
                        pw.Container(
                            child: tableTextBuilder(
                                DateFormat('dd-MM-yyyy')
                                    .format(order!.endDate!),
                                ttfFont,
                                [_robotoRegularFont])),
                        pw.Container(
                            child: tableTextBuilder(
                                "${order!.totalPrice! - order!.servicesFee!} €",
                                ttfFont,
                                [_robotoRegularFont])),
                        pw.Container(
                            child: tableTextBuilder("${order!.servicesFee!} €",
                                ttfFont, [_robotoRegularFont])),
                      ],
                    ),
                  ],
                ),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Container(
                    margin: const pw.EdgeInsets.symmetric(vertical: 20.0),
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 30.0),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey200,
                      borderRadius: pw.BorderRadius.circular(15.0),
                    ),
                    child: pw.Text(
                      "total :       ${order!.totalPrice!} €",
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 15.5 * curScaleFactor,
                        fontWeight: pw.FontWeight.normal,
                        font: ttfFont,
                        fontFallback: [_robotoRegularFont],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
    return pdf;
  }

  @override
  void dispose() {
    if (fToast != null) {
      fToast!.removeCustomToast();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);

    return CustomLightElevatedButton(
      buttonText: "DOWNLOAD",
      fontSize: 14 * curScaleFactor,
      shadows: const [
        BoxShadow(
          color: Color.fromRGBO(255, 255, 255, 1),
          blurRadius: 5.2,
          spreadRadius: 0.0,
          offset: Offset(-4.0, -4.0),
        ),
        BoxShadow(
          color: Color.fromRGBO(255, 255, 255, 1),
          blurRadius: 5.2,
          spreadRadius: 0.0,
          offset: Offset(-4.0, -4.0),
        ),
        BoxShadow(
          color: Color.fromRGBO(231, 231, 231, 71),
          blurRadius: 3.5,
          spreadRadius: 0.0,
          offset: Offset(5.0, 4.0),
        ),
      ],
      gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(2, 129, 57, 1),
            Color.fromRGBO(7, 210, 95, 1)
          ]),
      textColor: const Color.fromRGBO(255, 255, 255, 1),
      onPressed: () async {
        try {
          final pdf = await generatePDF(widget.order);

          var downloadsPath =
              await ExternalPath.getExternalStoragePublicDirectory(
                  ExternalPath.DIRECTORY_DOWNLOADS);

          String filePath =
              '$downloadsPath/invoice_${DateFormat('dd-MM-yyyy').format(widget.order!.updatedAt!)}.pdf';
          File file = File(filePath);
          await file.writeAsBytes(await pdf.save());
          print('File path: $filePath');

          if (EasyLoading.isShow) {
            await EasyLoading.dismiss();
          }

          await _showSuccessToast();
          if (EasyLoading.isShow) {
            await EasyLoading.dismiss();
          }
        } catch (e) {
          print('Exception while writing file: $e');
          if (EasyLoading.isShow) {
            await EasyLoading.dismiss();
          }
        }
      },
      condition: true,
      margin: const EdgeInsets.only(left: 5.0, right: 10.0),
      icon: const Icon(
        CustomIcons2.download,
        color: Colors.white,
        size: 15.0,
      ),
    );
  }
}
