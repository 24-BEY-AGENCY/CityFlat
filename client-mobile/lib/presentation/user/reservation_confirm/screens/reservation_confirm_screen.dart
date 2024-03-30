import 'package:cityflat/models/order_model.dart';
import 'package:cityflat/presentation/user/reservation_confirm/widgets/reservation_details_calendar.dart';
import 'package:cityflat/presentation/user/reservation_confirm/widgets/reservation_details_services.dart';
import 'package:cityflat/presentation/user/reservation_confirm/widgets/reservation_reviewed_dialog.dart';
import 'package:cityflat/services/order_service.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../models/apartment_model.dart';
import '../../../../models/service_model.dart';
import '../../../../providers/apartment_provider.dart';
import '../../../../providers/reservation_provider.dart';
import '../../../../utilities/size_config.dart';
import '../../../shared/widgets/custom_appbar.dart';
import '../../../shared/widgets/custom_light_elevated_button.dart';
import '../../../shared/widgets/custom_light_neumorphic_elevated_button.dart';
import '../../../shared/widgets/custom_title.dart';
import '../../../shared/widgets/custom_toast.dart';
import '../../../shared/widgets/user_drawer.dart';
import '../../apartment/widgets/one_apartment_info.dart';

class ReservationConfirmScreen extends StatefulWidget {
  static const routeName = "/reservationConfirm";

  const ReservationConfirmScreen({
    super.key,
  });

  @override
  State<ReservationConfirmScreen> createState() =>
      _ReservationConfirmScreenState();
}

class _ReservationConfirmScreenState extends State<ReservationConfirmScreen> {
  FToast? fToast;
  bool isDataFetched = false;

  List<Service>? services;
  List<SpecialDate>? dates;
  Map<int, int> priceCount = {};
  List<String> dateStrings = [];
  int totalPrice = 0;
  num totalServices = 0;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  void _showFailureToast() {
    Future.delayed(const Duration(milliseconds: 500), () {
      fToast!.showToast(
        child: const CustomToast(
          text: "An error has occurred. Please retry.",
          textColor: Color.fromRGBO(255, 255, 255, 1),
          backgroundColor: Color.fromRGBO(190, 6, 6, 1),
        ),
        toastDuration: const Duration(seconds: 5),
        gravity: ToastGravity.TOP,
      );
    });
  }

  createOrder() async {
    try {
      final apartmentProvider =
          Provider.of<ApartmentProvider>(context, listen: false);
      final reservationProvider =
          Provider.of<ReservationProvider>(context, listen: false);
      await EasyLoading.show(
        indicator: const CircularProgressIndicator(
          color: Color.fromRGBO(13, 178, 84, 1),
        ),
        maskType: EasyLoadingMaskType.black,
      );

      List<Map<String, dynamic>> serviceList = [];
      if (services!.isNotEmpty) {
        serviceList = services!.map((service) {
          return {
            'name': service.name,
            'price': service.pricePerNight,
          };
        }).toList();
      }

      Order newOrder = Order(
        appartment: apartmentProvider.oneApartment!.id,
        totalPrice: totalPrice + totalServices,
        startDate: reservationProvider.rangeStartDate,
        endDate: reservationProvider.rangeEndDate,
        servicesFee: totalServices,
        services: serviceList,
      );
      final result = await OrderService().createOrder(newOrder);
      if (EasyLoading.isShow) {
        await EasyLoading.dismiss();
      }
      if (!mounted) return;
      await showDialog(
        context: context,
        barrierColor: const Color.fromRGBO(98, 100, 112, 0.2),
        builder: (context) => const ReservationReviewedDialog(),
      );
      print(result);
    } catch (error) {
      if (EasyLoading.isShow) {
        await EasyLoading.dismiss();
      }
      _showFailureToast();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isDataFetched) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      services = arguments["services"];
      dates = arguments["dates"];
      for (var date in dates!) {
        priceCount[date.price!] = (priceCount[date.price] ?? 0) + 1;
        totalPrice += date.price!;
      }

      priceCount.forEach((price, count) {
        dateStrings.add('$count * $price €');
      });
      if (services!.isNotEmpty) {
        for (var service in services!) {
          totalServices += service.pricePerNight!;
        }
      }
      isDataFetched = true;
    }
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
    final onePercentOfHeight = SizeConfig.heightMultiplier;
    final onePercentOfWidth = SizeConfig.widthMultiplier;
    final apartmentProvider =
        Provider.of<ApartmentProvider>(context, listen: false);
    final apartment = apartmentProvider.oneApartment;

    Widget textBuilder(
        {String? text, double? fontSize, FontWeight? fontWeight}) {
      return Text(
        text!,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: const Color.fromRGBO(45, 49, 54, 1),
          fontFamily: 'TT Commons',
          fontSize: fontSize! * curScaleFactor,
          fontWeight: fontWeight,
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      extendBody: true,
      endDrawer: const UserDrawer(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(top: onePercentOfHeight * 6),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(169, 169, 169, 0.148),
              Color.fromRGBO(255, 255, 255, 0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin:
                  const EdgeInsets.only(left: 5.0, right: 20.0, bottom: 10.0),
              child: Builder(
                builder: (context) => GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: CustomAppbar(
                    title: apartment!.apartmentName!,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: onePercentOfHeight * 18,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: SmoothBorderRadius(
                                  cornerRadius: 30,
                                  cornerSmoothing: 1,
                                ),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(apartment!.pictures![0]),
                              ),
                            ),
                          ),
                          Container(
                            height: onePercentOfHeight * 18,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: SmoothBorderRadius(
                                  cornerRadius: 30,
                                  cornerSmoothing: 1,
                                ),
                              ),
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromRGBO(0, 0, 0, 0),
                                  Color.fromRGBO(19, 20, 21, 0.5),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ],
                      ),
                      OneAapartmentInfo(
                        apartment: apartment,
                        marginTop1: 5.0,
                        marginbottom: 0.0,
                        isDescription: false,
                      ),
                      const CustomTitle(
                        title: "Reservation Details :",
                        fontSize: 26.0,
                        margin: EdgeInsets.all(0.0),
                      ),
                      ReservationDetailsCalendar(dates: dates),
                      if (services!.isNotEmpty)
                        const SizedBox(
                          height: 10.0,
                        ),
                      if (services!.isNotEmpty)
                        ReservationDetailsServices(services: services),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const CustomTitle(
                        title: "Payment Details :",
                        fontSize: 26.0,
                        margin: EdgeInsets.all(0.0),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textBuilder(
                              text: "Nights fees :",
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          SizedBox(
                            width: (onePercentOfWidth * 16 - 20.0),
                          ),
                          SizedBox(
                            child: Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textBuilder(
                                      text: "$totalPrice €",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                  for (var dateString in dateStrings)
                                    textBuilder(
                                        text: dateString,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (services!.isNotEmpty)
                        SizedBox(
                          height: 5.0,
                        ),
                      if (services!.isNotEmpty)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textBuilder(
                                text: "Services fees :",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            SizedBox(
                              width: (onePercentOfWidth * 16 - 40.0),
                            ),
                            SizedBox(
                              child: Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                        left: 5.0,
                                      ),
                                      child: textBuilder(
                                          text: "$totalServices €",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    for (var service in services!)
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 2.0,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 5.0,
                                              ),
                                              child: Icon(
                                                service.icon,
                                                color: const Color.fromRGBO(
                                                    188, 188, 188, 1),
                                                size: service.name == "Rent"
                                                    ? 9.0
                                                    : 15.0,
                                              ),
                                            ),
                                            SizedBox(
                                              width: service.name == "Rent"
                                                  ? 14.0
                                                  : 8.0,
                                            ),
                                            textBuilder(
                                                text:
                                                    "${service.pricePerNight} €",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textBuilder(
                              text: "Total price :",
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          SizedBox(
                            width: (onePercentOfWidth * 16 - 20.0),
                          ),
                          SizedBox(
                            child: Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  textBuilder(
                                      text: "${totalPrice + totalServices} €",
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomLightNeumrphicElevatedButton(
                              buttonText: "CANCEL",
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
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
                            ),
                          ),
                          Expanded(
                            child: CustomLightElevatedButton(
                              buttonText: "RENT",
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
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
                                await createOrder();
                              },
                              condition: true,
                              buttonIcon: false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
