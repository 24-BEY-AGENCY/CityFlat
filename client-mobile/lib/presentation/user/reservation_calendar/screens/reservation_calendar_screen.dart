import 'package:cityflat/presentation/user/reservation_calendar/widgets/calendar.dart';
import 'package:cityflat/presentation/user/reservation_calendar/widgets/special_days.dart';
import 'package:cityflat/services/services_service.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../models/apartment_model.dart';
import '../../../../models/book_date_model.dart';
import '../../../../models/service_model.dart';
import '../../../../providers/reservation_provider.dart';
import '../../../../utilities/size_config.dart';
import '../../../shared/widgets/custom_appbar.dart';
import '../../../shared/widgets/custom_icons.dart';
import '../../../shared/widgets/custom_light_elevated_button.dart';
import '../../../shared/widgets/custom_light_neumorphic_elevated_button.dart';
import '../../../shared/widgets/custom_title.dart';
import '../../../shared/widgets/custom_toast.dart';
import '../../../shared/widgets/user_drawer.dart';
import '../../reservation_confirm/screens/reservation_confirm_screen.dart';

class ReservationCalendarScreen extends StatefulWidget {
  static const routeName = "/reservationCalendar";

  const ReservationCalendarScreen({super.key});

  @override
  State<ReservationCalendarScreen> createState() =>
      _ReservationCalendarScreenState();
}

class _ReservationCalendarScreenState extends State<ReservationCalendarScreen> {
  FToast? fToast;
  bool isDataFetched = false;
  bool isDay = true;
  int? price;
  List<String>? apartServices;
  List<SpecialDate>? specialDates;
  List<Service> services = [
    Service(name: 'Parking', icon: CustomIcons.parking, isSelected: false),
    Service(name: 'Food', icon: CustomIcons.burger, isSelected: false),
    Service(name: 'Rent', icon: CustomIcons.car, isSelected: false),
    Service(
        name: 'Laundry', icon: CustomIcons.washing_machine, isSelected: false),
  ];
  List<Service> fetchedServices = [];
  List<BookDate> bookedDates = [];

  Widget serviceCardBuilder(double curScaleFactor, Service service) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 150, minWidth: 80),
      child: GestureDetector(
        onTap: () {
          setState(() {
            service.isSelected = !service.isSelected!;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              width: 1.0,
              color: service.isSelected!
                  ? const Color.fromRGBO(13, 178, 84, 1)
                  : const Color.fromRGBO(222, 222, 222, 1),
            ),
          ),
          child: Neumorphic(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
            style: NeumorphicStyle(
              boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(25.0)),
              depth: -6,
              intensity: 0.6,
              lightSource: LightSource.topLeft,
              color: const Color.fromRGBO(247, 247, 247, 1),
              shadowDarkColorEmboss: const Color.fromRGBO(0, 0, 0, 0.5),
              shadowLightColorEmboss: const Color.fromRGBO(255, 255, 255, 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      right: service.name == 'Rent' ? 15.0 : 0.0),
                  child: Icon(
                    service.icon,
                    size: service.name == 'Rent'
                        ? 20 * curScaleFactor
                        : 30 * curScaleFactor,
                    color: service.isSelected!
                        ? const Color.fromRGBO(13, 178, 84, 1)
                        : const Color.fromRGBO(188, 188, 188, 1),
                  ),
                ),
                Text(
                  service.name!,
                  style: TextStyle(
                    fontFamily: 'TT Commons',
                    fontSize: 13.5 * curScaleFactor,
                    fontWeight: FontWeight.w600,
                    color: service.isSelected!
                        ? const Color.fromRGBO(13, 178, 84, 1)
                        : const Color.fromRGBO(188, 188, 188, 1),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<SpecialDate> generateReservationDatesList(
      DateTime startDate, DateTime endDate, List<SpecialDate> specialDates) {
    List<SpecialDate> allSpecialDates = [];

    for (DateTime date = startDate;
        date.isBefore(endDate) || date.isSameDate(endDate);
        date = date.add(const Duration(days: 1))) {
      bool dateIncluded = false;
      for (var specialDate in specialDates) {
        if ((date.isAtSameMomentAs(specialDate.startDate!) ||
                date.isAfter(specialDate.startDate!)) &&
            (date.isAtSameMomentAs(specialDate.endDate!) ||
                date.isBefore(specialDate.endDate!))) {
          allSpecialDates.add(SpecialDate(
            startDate: date,
            endDate: date,
            price: specialDate.price,
          ));
          dateIncluded = true;
          break;
        }
      }
      if (!dateIncluded) {
        allSpecialDates.add(SpecialDate(
          startDate: date,
          endDate: date,
          price: price,
        ));
      }
    }

    return allSpecialDates;
  }

  void _errorToast() {
    fToast!.showToast(
      child: const CustomToast(
        text: "An error has occurred. Please retry.",
        textColor: Color.fromRGBO(255, 255, 255, 1),
        backgroundColor: Color.fromRGBO(190, 6, 6, 1),
      ),
      toastDuration: const Duration(seconds: 5),
      gravity: ToastGravity.TOP,
    );
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isDataFetched) {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      apartServices = arguments["services"];
      specialDates = arguments["specialDates"];
      bookedDates = arguments["bookedDates"];
      price = arguments["price"];

      for (var service in services) {
        if (apartServices!.contains(service.name!.toLowerCase())) {
          fetchedServices.add(service);
        }
      }
      isDataFetched = true;
    }
  }

  @override
  void dispose() {
    fToast!.removeCustomToast();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);
    final onePercentOfHeight = SizeConfig.heightMultiplier;
    final onePercentOfWidth = SizeConfig.widthMultiplier;

    final reservationProvider =
        Provider.of<ReservationProvider>(context, listen: true);

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
                    title: "Calendar",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 41,
                    child: CustomLightNeumrphicElevatedButton(
                      buttonText: "Day",
                      fontSize: 14 * curScaleFactor,
                      border: Border.all(
                        color: isDay
                            ? const Color.fromRGBO(13, 178, 84, 1)
                            : const Color.fromRGBO(188, 188, 188, 1),
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
                      textColor: isDay
                          ? const Color.fromRGBO(13, 178, 84, 1)
                          : const Color.fromRGBO(188, 188, 188, 1),
                      onPressed: () {
                        setState(() {
                          isDay = true;
                        });
                      },
                      condition: true,
                      margin: const EdgeInsets.only(left: 10.0, right: 5.0),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 41,
                    child: CustomLightNeumrphicElevatedButton(
                      buttonText: "Month",
                      fontSize: 14 * curScaleFactor,
                      border: Border.all(
                        color: isDay
                            ? const Color.fromRGBO(188, 188, 188, 1)
                            : const Color.fromRGBO(13, 178, 84, 1),
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
                      textColor: isDay
                          ? const Color.fromRGBO(188, 188, 188, 1)
                          : const Color.fromRGBO(13, 178, 84, 1),
                      onPressed: () async {
                        setState(() {
                          isDay = false;
                        });
                      },
                      condition: true,
                      margin: const EdgeInsets.only(left: 10.0, right: 5.0),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  if (isDay)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Calendar(
                          bookedDates: bookedDates,
                          specialDates: specialDates!),
                    ),
                  if (!isDay)
                    SizedBox(
                      height: onePercentOfHeight * 20,
                      child: Center(
                        child: Text(
                          "Please contact the owner",
                          style: TextStyle(
                            color: const Color.fromRGBO(45, 49, 54, 1),
                            fontSize: 22 * curScaleFactor,
                            fontFamily: 'TT Commons',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  if (specialDates!.isNotEmpty)
                    const CustomTitle(
                      title: "Special days :",
                      fontSize: 20.0,
                    ),
                  if (specialDates!.isNotEmpty)
                    SpecialDays(
                      specialDates: specialDates,
                    ),
                  const CustomTitle(
                    title: "Choose your services :",
                    fontSize: 26.0,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: fetchedServices.map((service) {
                        if (fetchedServices.length > 3) {
                          return Container(
                            width: onePercentOfWidth *
                                100 /
                                fetchedServices.length,
                            child: serviceCardBuilder(curScaleFactor, service),
                          );
                        } else {
                          return Container(
                            width: fetchedServices.length == 3
                                ? onePercentOfWidth * 27
                                : onePercentOfWidth * 25,
                            child: serviceCardBuilder(curScaleFactor, service),
                          );
                        }
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Center(
                    child: SizedBox(
                      width: 200,
                      child: CustomLightElevatedButton(
                        buttonText: "CONTINUE",
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
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors:
                                reservationProvider.rangeStartDate != null &&
                                        reservationProvider.rangeEndDate != null
                                    ? [
                                        const Color.fromRGBO(2, 129, 57, 1),
                                        const Color.fromRGBO(7, 210, 95, 1)
                                      ]
                                    : [
                                        const Color.fromRGBO(2, 129, 57, 0.5),
                                        const Color.fromRGBO(7, 210, 95, 0.5)
                                      ]),
                        textColor: const Color.fromRGBO(255, 255, 255, 1),
                        onPressed: () async {
                          try {
                            reservationProvider.rangeStartDate;
                            reservationProvider.rangeEndDate;
                            List<Service> selectedServices = [];

                            selectedServices = fetchedServices
                                .where((service) => service.isSelected!)
                                .toList();

                            List<SpecialDate> reservationDates =
                                generateReservationDatesList(
                                    reservationProvider.rangeStartDate!,
                                    reservationProvider.rangeEndDate!,
                                    specialDates!);
                            List<Service> services = [];
                            if (selectedServices.isNotEmpty) {
                              services =
                                  await ServicesService().getAllServices();

                              for (var service in selectedServices) {
                                var fetchedService = services.firstWhere((s) {
                                  print(s.name);
                                  if (s.name == "Car") {
                                    return service.name == "Rent";
                                  } else {
                                    return s.name == service.name;
                                  }
                                });

                                service.pricePerNight =
                                    fetchedService.pricePerNight;
                              }
                            }
                            if (!context.mounted) return;
                            Navigator.of(context).pushNamed(
                                ReservationConfirmScreen.routeName,
                                arguments: {
                                  "services": selectedServices,
                                  "dates": reservationDates,
                                });
                          } catch (error) {
                            print(error);
                            _errorToast();
                          }
                        },
                        condition: reservationProvider.rangeStartDate != null &&
                                reservationProvider.rangeEndDate != null
                            ? true
                            : false,
                        buttonIcon: false,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
