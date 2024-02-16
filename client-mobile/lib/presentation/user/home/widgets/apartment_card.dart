import 'package:cityflat/presentation/shared/widgets/custom_icons.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/apartment_model.dart';
import '../../../../providers/apartment_provider.dart';
import '../../../../services/wishlist_service.dart';
import '../../apartment/screens/one_apartment_screen.dart';

class ApartmentCard extends StatefulWidget {
  final Apartment? apartmentData;
  final int? index;
  const ApartmentCard({super.key, this.apartmentData, this.index});

  @override
  State<ApartmentCard> createState() => _ApartmentCardState();
}

class _ApartmentCardState extends State<ApartmentCard> {
  Future<void> onAddToWishlist(String apartmentId) async {
    try {
      final response = await WishlistService().addToWishlist(apartmentId);
      print(response);
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
    Navigator.of(context).pushNamed(OneApartmentScreen.routeName, arguments: {
      "apartId": apartId,
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaleFactor;
    final apartmentProvider =
        Provider.of<ApartmentProvider>(context, listen: true);

    return GestureDetector(
      onTap: () {
        visitApartmentScreen(apartmentProvider.apartments[widget.index!].id!);
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
                image: NetworkImage(widget.apartmentData!.img![0]),
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
                  child: Container(
                    // margin: EdgeInsets.only(top: 10.0, right: 10.0),
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
                              color: const Color.fromRGBO(255, 255, 255, 0.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 35.0,
                          width: 20.0,
                          child: IconButton(
                              padding: const EdgeInsets.all(10.0),
                              splashColor: Colors.transparent,
                              icon: Icon(
                                CustomIcons.favorite,
                                size: 13 * curScaleFactor,
                                color: apartmentProvider
                                        .apartments[widget.index!].isWishlist!
                                    ? const Color.fromRGBO(13, 178, 84, 1)
                                    : const Color.fromRGBO(255, 255, 255, 1),
                              ),
                              onPressed: () async {
                                final apartmentId = apartmentProvider
                                    .apartments[widget.index!].id!;
                                if (apartmentProvider
                                    .apartments[widget.index!].isWishlist!) {
                                  await onRemoveFromWishlist(apartmentId);
                                } else {
                                  await onAddToWishlist(apartmentId);
                                }

                                setState(() {
                                  apartmentProvider.switchWishList(apartmentId);
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  widget.apartmentData!.name!,
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
                        // Wrap with Expanded
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
                        text: '${widget.apartmentData!.defaultPrice!} €',
                        style: TextStyle(
                          fontFamily: 'TT Commons',
                          fontSize: 19.0 * curScaleFactor,
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
