import 'package:cityflat/presentation/shared/widgets/custom_icons.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../models/apartment_model.dart';
import '../../../../providers/apartment_provider.dart';
import '../../../../services/wishlist_service.dart';
import '../../apartment/screens/one_apartment_screen.dart';

class ApartmentCard extends StatefulWidget {
  final Apartment? apartmentData;
  final int? index;
  final Key? key;
  final bool? isRental;

  const ApartmentCard(
      {this.apartmentData, this.index, this.key, this.isRental});

  @override
  State<ApartmentCard> createState() => _ApartmentCardState();
}

class _ApartmentCardState extends State<ApartmentCard> {
  bool isLoading = false;
  bool? isFavorite;

  Future<void> onAddToWishlist(String apartmentId) async {
    try {
      await WishlistService().addToWishlist(apartmentId);
    } catch (error) {
      print(error);
    }
  }

  Future<void> onRemoveFromWishlist(String apartmentId) async {
    try {
      final response = await WishlistService().removeFromWishlist(apartmentId);
      print(response);
    } catch (error) {
      print(error);
    }
  }

  visitApartmentScreen(String apartId) {
    Navigator.of(context).pushNamed(OneApartmentScreen.routeName,
        arguments: {"apartId": apartId, "isRental": widget.isRental});
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);
    final apartmentProvider =
        Provider.of<ApartmentProvider>(context, listen: true);

    return GestureDetector(
      key: widget.key,
      onTap: () {
        visitApartmentScreen(widget.apartmentData!.id!);
      },
      child: Stack(
        children: [
          Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: SmoothBorderRadius(
                  cornerRadius: 15,
                  cornerSmoothing: 1,
                ),
              ),
              shadows: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.17),
                  blurRadius: 20.7,
                  spreadRadius: 0.0,
                  offset: Offset(6, 15.0),
                ),
              ],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.apartmentData!.pictures![0]),
              ),
            ),
          ),
          Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: SmoothBorderRadius(
                  cornerRadius: 15,
                  cornerSmoothing: 1,
                ),
              ),
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(0, 0, 0, 0),
                  Color.fromRGBO(19, 20, 21, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: isLoading
                      ? Container(
                          height: 25,
                          width: 25,
                          margin: const EdgeInsets.only(right: 3.0, top: 2.0),
                          child: const CircularProgressIndicator(
                            strokeWidth: 2.0,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ))
                      : Container(
                          height: 35.0,
                          width: 35.0,
                          decoration: ShapeDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  height: 25.0,
                                  width: 25.0,
                                  decoration: ShapeDecoration(
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 0.2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 35.0,
                                width: 35.0,
                                margin: const EdgeInsets.only(right: 5.0),
                              ),
                              IconButton(
                                  padding: const EdgeInsets.all(10.0),
                                  splashColor: Colors.transparent,
                                  icon: isFavorite ??
                                          widget.apartmentData!.isWishlist!
                                      ? SvgPicture.asset(
                                          "assets/icons/svg/favorite_filled.svg",
                                          width: 50,
                                          height: 50,
                                          // fit: BoxFit.fitWidth,
                                          fit: BoxFit.fitWidth,
                                          color: const Color.fromRGBO(
                                              13, 178, 84, 1),
                                        )
                                      : Container(
                                          margin:
                                              const EdgeInsets.only(right: 5.0),
                                          child: Icon(
                                            CustomIcons.favorite,
                                            size: 13 * curScaleFactor,
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 1),
                                          ),
                                        ),
                                  onPressed: () async {
                                    final apartmentId =
                                        widget.apartmentData!.id!;
                                    bool isWishisted = apartmentProvider
                                            .apartments
                                            .firstWhere((apart) =>
                                                apart.id == apartmentId)
                                            .isWishlist ??
                                        false;
                                    if (isWishisted) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await onRemoveFromWishlist(apartmentId);

                                      setState(() {
                                        isLoading = false;
                                        isFavorite = false;
                                      });
                                    } else {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await onAddToWishlist(apartmentId);

                                      setState(() {
                                        isLoading = false;
                                        isFavorite = true;
                                      });
                                    }

                                    setState(() {
                                      apartmentProvider
                                          .switchWishList(apartmentId);
                                      apartmentProvider
                                          .switchFavoriteWishList(apartmentId);
                                    });
                                  }),
                            ],
                          ),
                        ),
                ),
                const Spacer(),
                Text(
                  widget.apartmentData!.apartmentName!,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16.0 * curScaleFactor,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                  child: Row(
                    children: [
                      const Icon(
                        CustomIcons.location,
                        color: Color.fromRGBO(222, 194, 95, 1),
                        size: 10.0,
                      ),
                      Expanded(
                        child: Text(
                          widget.apartmentData!.location!,
                          style: TextStyle(
                            fontFamily: 'TT Commons',
                            fontSize: 10.0 * curScaleFactor,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '${widget.apartmentData!.defaultDateAndPrice!.price} €',
                        style: TextStyle(
                          fontFamily: 'TT Commons',
                          fontSize: 20.5 * curScaleFactor,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(13, 178, 84, 1),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Text(
                          ' /Night',
                          style: TextStyle(
                            fontFamily: 'TT Commons',
                            fontSize: 9.0 * curScaleFactor,
                            fontWeight: FontWeight.w700,
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
