import 'package:cityflat/models/apartment_model.dart';
import 'package:cityflat/presentation/shared/widgets/user_drawer.dart';
import 'package:cityflat/presentation/user/apartment/widgets/one_apartment_gallery.dart';
import 'package:cityflat/presentation/user/reservation_calendar/screens/reservation_calendar_screen.dart';
import 'package:cityflat/services/apartment_service.dart';
import 'package:cityflat/services/order_service.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../models/book_date_model.dart';
import '../../../../providers/apartment_provider.dart';
import '../../../../services/connectivity_service.dart';
import '../../../../services/wishlist_service.dart';
import '../../../../utilities/size_config.dart';
import '../../../shared/widgets/custom_appbar.dart';
import '../../../shared/widgets/custom_back_button.dart';
import '../../../shared/widgets/custom_icons.dart';
import '../../../shared/widgets/custom_light_elevated_button.dart';
import '../../../shared/widgets/custom_toast.dart';
import '../widgets/new_review.dart';
import '../widgets/one_apartment_info.dart';
import '../widgets/review_list.dart';

class OneApartmentScreen extends StatefulWidget {
  static const routeName = "/oneApartment";

  const OneApartmentScreen({super.key});

  @override
  State<OneApartmentScreen> createState() => _OneApartmentScreenState();
}

class _OneApartmentScreenState extends State<OneApartmentScreen> {
  Future<Apartment>? apartmentFuture;
  Apartment? apartment;
  String? apartId;
  bool? isRental;
  bool isLoading = false;
  FToast? fToast;

  onGetOneApartment() async {
    try {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      apartId = arguments["apartId"];
      isRental = arguments["isRental"];
      if (isRental != null && isRental!) {
        final response = ApartmentService().getOneRental(apartId!);
        apartmentFuture = response;
      } else {
        final response = ApartmentService().getOneApartment(apartId!);
        apartmentFuture = response;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> onAddToWishlist(String apartmentId) async {
    try {
      await WishlistService().addToWishlist(apartmentId);
    } catch (error) {
      print(error);
      _errorToast();
    }
  }

  Future<void> onRemoveFromWishlist(String apartmentId) async {
    try {
      final response = await WishlistService().removeFromWishlist(apartmentId);
      print(response);
    } catch (error) {
      print(error);
      _errorToast();
    }
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

  Color _getColorForState(String state) {
    switch (state) {
      case 'PENDING':
        return const Color.fromRGBO(222, 194, 95, 1);
      case 'DECLINED':
        return const Color.fromRGBO(190, 6, 6, 1);
      case 'ACCEPTED':
        return const Color.fromRGBO(13, 178, 84, 1);
      default:
        return const Color.fromRGBO(45, 49, 54, 1);
    }
  }

  String _getIconForState(String state) {
    switch (state) {
      case 'PENDING':
        return "assets/icons/svg/waiting.svg";
      case 'DECLINED':
        return "assets/icons/svg/exit.svg";
      case 'ACCEPTED':
        return "assets/icons/svg/valid.svg";
      default:
        return "assets/icons/svg/waiting.svg";
    }
  }

  @override
  void initState() {
    super.initState();
    ConnectivityService.initConnectivity(context);
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  void didChangeDependencies() {
    if (apartmentFuture == null) {
      onGetOneApartment();
    }
    super.didChangeDependencies();
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
    final apartmentProvider =
        Provider.of<ApartmentProvider>(context, listen: true);

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
        child: FutureBuilder<Apartment>(
            future: apartmentFuture,
            builder: (ctx, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                            left: 5.0, right: 20.0, bottom: 20.0),
                        child: CustomBackButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const Spacer(),
                      const Center(child: CircularProgressIndicator()),
                      const Spacer(),
                    ],
                  );
                case ConnectionState.done:
                default:
                  if (snapshot.hasError) {
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                              left: 5.0, right: 20.0, bottom: 20.0),
                          child: CustomBackButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const Spacer(),
                        const Center(
                          child: Text("error when getting apartment."),
                        ),
                        const Spacer(),
                      ],
                    );
                  }

                  if (snapshot.hasData) {
                    apartment = snapshot.data!;
                    List<String> galleryImages = [];
                    if (apartment!.pictures!.length > 1) {
                      List<String> apartmentImgs =
                          apartment!.pictures?.sublist(1) as List<String>;
                      galleryImages.addAll(apartmentImgs);
                    }
                    apartmentProvider.setOneApartment(apartment!);
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 5.0, right: 20.0, bottom: 10.0),
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
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: onePercentOfHeight * 45,
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: SmoothBorderRadius(
                                              cornerRadius: 30,
                                              cornerSmoothing: 1,
                                            ),
                                          ),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                apartment!.pictures![0]),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: onePercentOfHeight * 45,
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
                                      Container(
                                        margin: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: isLoading
                                                  ? Container(
                                                      height: 30,
                                                      width: 30,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10.0,
                                                              top: 8.0),
                                                      child:
                                                          const CircularProgressIndicator(
                                                        color: Color.fromRGBO(
                                                            255, 255, 255, 1),
                                                      ))
                                                  : Container(
                                                      height: 50.0,
                                                      width: 50.0,
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: const Color
                                                            .fromRGBO(
                                                            255, 255, 255, 0.2),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Center(
                                                            child: Container(
                                                              height: 40.0,
                                                              width: 40.0,
                                                              decoration:
                                                                  ShapeDecoration(
                                                                color: const Color
                                                                    .fromRGBO(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    0.2),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      10.0),
                                                              splashColor: Colors
                                                                  .transparent,
                                                              icon: apartment!
                                                                      .isWishlist!
                                                                  ? Container(
                                                                      margin: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              2.0,
                                                                          top:
                                                                              2.0),
                                                                      child: SvgPicture
                                                                          .asset(
                                                                        "assets/icons/svg/favorite_filled.svg",
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            13,
                                                                            178,
                                                                            84,
                                                                            1),
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      height:
                                                                          50.0,
                                                                      width:
                                                                          50.0,
                                                                      margin: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              2.0,
                                                                          left:
                                                                              2.0),
                                                                      child:
                                                                          Icon(
                                                                        CustomIcons
                                                                            .favorite,
                                                                        size: 20 *
                                                                            curScaleFactor,
                                                                        color: const Color
                                                                            .fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            1),
                                                                      ),
                                                                    ),
                                                              onPressed:
                                                                  () async {
                                                                final apartmentId =
                                                                    apartment!
                                                                        .id!;
                                                                if (apartment!
                                                                    .isWishlist!) {
                                                                  setState(() {
                                                                    isLoading =
                                                                        true;
                                                                  });
                                                                  await onRemoveFromWishlist(
                                                                      apartmentId);
                                                                  setState(() {
                                                                    apartment!
                                                                            .isWishlist =
                                                                        !apartment!
                                                                            .isWishlist!;
                                                                    isLoading =
                                                                        false;
                                                                  });
                                                                } else {
                                                                  setState(() {
                                                                    isLoading =
                                                                        true;
                                                                  });
                                                                  await onAddToWishlist(
                                                                      apartmentId);
                                                                  setState(() {
                                                                    apartment!
                                                                            .isWishlist =
                                                                        !apartment!
                                                                            .isWishlist!;
                                                                    isLoading =
                                                                        false;
                                                                  });
                                                                }

                                                                // Removes apart from favorites list if it's there and adds it if it's not.
                                                                setState(() {
                                                                  apartmentProvider
                                                                      .switchWishList(
                                                                          apartmentId);
                                                                  apartmentProvider
                                                                      .switchFavoriteWishList(
                                                                          apartmentId);
                                                                });
                                                              }),
                                                        ],
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (galleryImages.isNotEmpty)
                                        OneApApartmentGallery(
                                            galleryImgs: galleryImages),
                                    ],
                                  ),
                                  OneAapartmentInfo(
                                    apartment: apartment!,
                                    marginTop1: 25.0,
                                    marginbottom: 20.0,
                                    isDescription: true,
                                  ),
                                  if (apartment != null)
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                  if (apartment != null)
                                    const Divider(
                                      color: Color.fromRGBO(188, 188, 188, 0.5),
                                      thickness: 1,
                                    ),
                                  if (apartment != null)
                                    ReviewList(
                                      apartmentId: apartment!.id!,
                                    ),
                                  NewReview(apartmentId: apartment!.id!),
                                  const SizedBox(
                                    height: 20.0,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: onePercentOfWidth * 6),
                          alignment: Alignment.bottomCenter,
                          decoration: const ShapeDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: SmoothBorderRadius.only(
                                topLeft: SmoothRadius(
                                  cornerRadius: 30,
                                  cornerSmoothing: 1,
                                ),
                                topRight: SmoothRadius(
                                  cornerRadius: 30,
                                  cornerSmoothing: 1,
                                ),
                              ),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.17),
                                blurRadius: 22.5,
                                spreadRadius: 0.0,
                                offset: Offset(6, -11.0),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Price :",
                                    style: TextStyle(
                                      fontFamily: 'TT Commons',
                                      fontSize: 15.0 * curScaleFactor,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          const Color.fromRGBO(45, 49, 54, 1),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              '${apartment!.defaultDateAndPrice!.price} €',
                                          style: TextStyle(
                                            fontFamily: 'TT Commons',
                                            fontSize: 30.0 * curScaleFactor,
                                            fontWeight: FontWeight.w700,
                                            color: const Color.fromRGBO(
                                                3, 139, 62, 1),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        WidgetSpan(
                                          alignment:
                                              PlaceholderAlignment.middle,
                                          child: Text(
                                            ' /Night',
                                            style: TextStyle(
                                              fontFamily: 'TT Commons',
                                              fontSize: 13.0 * curScaleFactor,
                                              fontWeight: FontWeight.w700,
                                              color: const Color.fromRGBO(
                                                  105, 119, 111, 1),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: isRental != null && isRental!
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              243, 243, 243, 1),
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          border: Border.all(
                                            color: _getColorForState(
                                                apartment!.orderState!),
                                            width: 1,
                                          ),
                                        ),
                                        child: Neumorphic(
                                          style: NeumorphicStyle(
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                                    BorderRadius.circular(
                                                        50.0)),
                                            depth: 0,
                                            intensity: 0.0,
                                            lightSource: LightSource.topLeft,
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 0.46),
                                          ),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              height: 49,
                                              constraints: const BoxConstraints(
                                                  maxWidth: 200.0,
                                                  minHeight: 50.0),
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    _getIconForState(
                                                        apartment!.orderState!),
                                                    height: 19.0,
                                                    width: 19.0,
                                                    color: _getColorForState(
                                                        apartment!.orderState!),
                                                  ),
                                                  const SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Text(
                                                    apartment!.orderState!,
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize:
                                                          16 * curScaleFactor,
                                                      color: _getColorForState(
                                                          apartment!
                                                              .orderState!),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      )
                                    : CustomLightElevatedButton(
                                        margin:
                                            const EdgeInsets.only(left: 20.0),
                                        buttonText: "RENT NOW",
                                        shadows: const [
                                          BoxShadow(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            blurRadius: 5.2,
                                            spreadRadius: 0.0,
                                            offset: Offset(-4.0, -4.0),
                                          ),
                                          BoxShadow(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            blurRadius: 5.2,
                                            spreadRadius: 0.0,
                                            offset: Offset(-4.0, -4.0),
                                          ),
                                          BoxShadow(
                                            color: Color.fromRGBO(
                                                231, 231, 231, 71),
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
                                        textColor: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        onPressed: () async {
                                          try {
                                            List<BookDate> bookedDates =
                                                await OrderService()
                                                    .getAcceptedBookDates(
                                                        apartment!.id!);

                                            if (!context.mounted) return;
                                            Navigator.of(context).pushNamed(
                                                ReservationCalendarScreen
                                                    .routeName,
                                                arguments: {
                                                  "services":
                                                      apartment!.services!,
                                                  "specialDates":
                                                      apartment!.specialDates!,
                                                  "bookedDates": bookedDates,
                                                  "price": apartment!
                                                      .defaultDateAndPrice!
                                                      .price,
                                                });
                                          } catch (error) {
                                            print(error);
                                          }
                                        },
                                        condition: true,
                                        buttonIcon: false,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                              left: 5.0, right: 20.0, bottom: 20.0),
                          child: CustomBackButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const Spacer(),
                        const Center(
                          child: Text("error when getting apartment."),
                        ),
                        const Spacer(),
                      ],
                    );
                  }
              }
            }),
      ),
    );
  }
}
