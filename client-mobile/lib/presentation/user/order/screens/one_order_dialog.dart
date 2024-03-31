import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

import '../../../../models/order_model.dart';
import '../../../../utilities/size_config.dart';
import '../../../shared/widgets/custom_alert_dialog.dart';
import '../../../shared/widgets/custom_light_neumorphic_elevated_button.dart';
import '../widgets/PDFInvoice.dart';

class OneOrderDialog extends StatelessWidget {
  final Order? order;

  const OneOrderDialog({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);
    final onePercentOfWidth = SizeConfig.widthMultiplier;

    Widget billInfoBuilder(String boldText, String normalText) {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$boldText : ",
              style: TextStyle(
                color: const Color.fromRGBO(26, 27, 26, 1),
                fontSize: 13.5 * curScaleFactor,
                fontWeight: FontWeight.w700,
                fontFamily: 'Montserrat',
              ),
            ),
            TextSpan(
              text: normalText,
              style: TextStyle(
                color: const Color.fromRGBO(26, 27, 26, 1),
                fontSize: 13.5 * curScaleFactor,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      );
    }

    Widget headerTextBuilder(String text) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: const Color.fromRGBO(45, 49, 54, 1),
              fontSize: 12.0 * curScaleFactor,
              fontWeight: FontWeight.w700,
              overflow: TextOverflow.visible,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      );
    }

    Widget tableTextBuilder(String text) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: const Color.fromRGBO(45, 49, 54, 1),
              fontSize: 12.0 * curScaleFactor,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.visible,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: CustomAlertDialog(
          isNotGradient: true,
          contentPadding: EdgeInsets.zero,
          content: Container(
              padding: const EdgeInsets.only(
                  top: 50.0, left: 20.0, right: 20.0, bottom: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "INVOICE",
                      style: TextStyle(
                        color: const Color.fromRGBO(26, 27, 26, 1),
                        fontSize: 38 * curScaleFactor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  billInfoBuilder("Bill Date",
                      DateFormat('dd-MM-yyyy').format(order!.updatedAt!)),
                  billInfoBuilder("Customer", order!.user.name),
                  billInfoBuilder("Email", order!.user.email),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Table(
                    border: TableBorder.all(
                      color: Colors.transparent,
                      width: 0,
                    ),
                    columnWidths: {
                      0: FixedColumnWidth(onePercentOfWidth * 40),
                      1: FixedColumnWidth(onePercentOfWidth * 40),
                      2: FixedColumnWidth(onePercentOfWidth * 40),
                      3: FixedColumnWidth(onePercentOfWidth * 40),
                      4: FixedColumnWidth(onePercentOfWidth * 40),
                    },
                    children: [
                      TableRow(
                        children: [
                          TableCell(child: headerTextBuilder("Apartements")),
                          TableCell(child: headerTextBuilder("Check In")),
                          TableCell(child: headerTextBuilder("Check Out")),
                          TableCell(child: headerTextBuilder("Apartment Fees")),
                          TableCell(child: headerTextBuilder("Services Fees")),
                        ],
                      ),
                      TableRow(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(243, 243, 243, 1),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        children: [
                          TableCell(
                              child: tableTextBuilder(
                                  order!.appartment!.apartmentName)),
                          TableCell(
                              child: tableTextBuilder(DateFormat('dd-MM-yyyy')
                                  .format(order!.startDate!))),
                          TableCell(
                              child: tableTextBuilder(DateFormat('dd-MM-yyyy')
                                  .format(order!.endDate!))),
                          TableCell(
                              child: tableTextBuilder(
                                  "${order!.totalPrice! - order!.servicesFee!} €")),
                          TableCell(
                              child:
                                  tableTextBuilder("${order!.servicesFee!} €")),
                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(243, 243, 243, 1),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Text(
                        "total :       ${order!.totalPrice!} €",
                        style: TextStyle(
                          color: const Color.fromRGBO(45, 49, 54, 1),
                          fontSize: 15.5 * curScaleFactor,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                        width: onePercentOfWidth * 50,
                        child: CustomLightNeumrphicElevatedButton(
                          buttonText: "CANCEL",
                          fontSize: 14 * curScaleFactor,
                          border: Border.all(
                            color: const Color.fromRGBO(13, 178, 84, 1),
                            width: 1,
                          ),
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
                              color: Color.fromRGBO(231, 231, 231, 0.71),
                              blurRadius: 3.5,
                              spreadRadius: 0.0,
                              offset: Offset(5.0, 4.0),
                            ),
                          ],
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          textColor: const Color.fromRGBO(13, 178, 84, 1),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          condition: true,
                          margin: const EdgeInsets.only(left: 10.0, right: 5.0),
                        ),
                      ),
                      SizedBox(
                        width: onePercentOfWidth * 50,
                        child: PDFInvoice(order: order),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
