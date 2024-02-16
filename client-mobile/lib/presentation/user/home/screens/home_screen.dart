import 'package:cityflat/presentation/user/home/widgets/apartment_filter_dialog.dart';
import 'package:cityflat/presentation/user/home/widgets/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/apartment_model.dart';
import '../../../../providers/apartment_provider.dart';
import '../../../../providers/user_provider.dart';
import '../../../../services/apartment_service.dart';
import '../../../../services/connectivity_service.dart';
import '../../../../services/wishlist_service.dart';
import '../../../../utilities/size_config.dart';
import '../../../shared/widgets/custom_icon_button.dart';
import '../../../shared/widgets/custom_icons.dart';
import '../../../shared/widgets/custom_light_textformfield.dart';
import '../widgets/apartment_card.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/userHome";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Future<User>? userFuture;
  Future<List<Apartment>>? apartmentListFuture;
  bool userFetched = false;
  double min = 0;
  double max = 5000;

  Future<void> onGetApartmentList() async {
    try {
      final response = ApartmentService().getAllAppartWishlisted();
      apartmentListFuture = response;
    } catch (error) {
      print(error);
    }
  }

  Future<void> _refreshData() async {
    onGetApartmentList();
  }

  onFilter() async {
    final apartmentProvider =
        Provider.of<ApartmentProvider>(context, listen: false);
    Map<String, double> priceMap = {
      'min': min,
      'max': max,
    };
    apartmentProvider.setFilterValues(priceMap);

    await showDialog(
      context: context,
      barrierColor: const Color.fromRGBO(98, 100, 112, 0.2),
      builder: (context) => ApartmentFilterDialog(),
    );
  }

  Future<void> onAddToWishlist(String apartmentId) async {
    try {
      final response = await WishlistService().addToWishlist(apartmentId);
      print(response);
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    ConnectivityService.initConnectivity(context);
    onGetApartmentList();
  }

  @override
  Widget build(BuildContext context) {
    final onePercentOfHeight = SizeConfig.heightMultiplier;
    final apartmentProvider =
        Provider.of<ApartmentProvider>(context, listen: true);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          children: [
            Container(
              margin:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: const HomeAppbar(),
            ),
            CustomLightTextFormField(
              customTextInputAction: TextInputAction.next,
              customKeyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.none,
              readOnly: true,
              noFocus: true,
              customHintText: "Filter...",
              suffixIcon: Container(
                height: 20.0,
                width: 20.0,
                margin: const EdgeInsets.only(right: 10.0),
                child: CustomIconButton(
                  icon: CustomIcons.filter,
                  width: 35.0,
                  height: 35.0,
                  iconSize: 20.0,
                  gradientColors: const [
                    Color.fromRGBO(2, 129, 57, 1),
                    Color.fromRGBO(7, 210, 95, 1)
                  ],
                  onPressed: () async {
                    onFilter();
                  },
                ),
              ),
              onChanged: (value) => setState(() {}),
              onTap: () async {
                onFilter();
              },
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: RefreshIndicator(
                  onRefresh: () {
                    return _refreshData();
                  },
                  child: FutureBuilder<List<Apartment>>(
                      future: apartmentListFuture,
                      builder: (ctx, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const Center(
                                child: CircularProgressIndicator());
                          case ConnectionState.done:
                          default:
                            if (snapshot.hasError) {
                              return const Center(
                                  child: Text(
                                      "Error when getting apartment list"));
                            }

                            if (snapshot.hasData) {
                              apartmentProvider.setApartments(snapshot.data!);
                              double smallestPrice = double.infinity;
                              double largestPrice = double.negativeInfinity;

                              if (apartmentProvider.apartments.isEmpty) {
                                smallestPrice = 0;
                                largestPrice = 0;
                              } else if (apartmentProvider.apartments.length ==
                                  1) {
                                smallestPrice = apartmentProvider
                                    .apartments[0].defaultPrice!
                                    .toDouble();
                                largestPrice = 5000;
                              } else {
                                for (var apartment
                                    in apartmentProvider.apartments) {
                                  if (apartment.defaultPrice! < smallestPrice) {
                                    smallestPrice =
                                        apartment.defaultPrice!.toDouble();
                                  }

                                  if (apartment.defaultPrice! > largestPrice) {
                                    largestPrice =
                                        apartment.defaultPrice!.toDouble();
                                  }
                                }
                              }
                              min = smallestPrice;
                              max = largestPrice;

                              return apartmentProvider.apartments.isNotEmpty
                                  ? GridView.builder(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: onePercentOfHeight * 2),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 20.0,
                                        crossAxisSpacing: 25.0,
                                        childAspectRatio: 0.8,
                                      ),
                                      itemCount:
                                          apartmentProvider.apartments.length,
                                      itemBuilder: (context, index) {
                                        return ApartmentCard(
                                            apartmentData: apartmentProvider
                                                .apartments[index],
                                            index: index);
                                      },
                                    )
                                  : const Text("No apartments available");
                            } else {
                              return const Text(
                                  "error when getting apartment list");
                            }
                        }
                      }),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: onePercentOfHeight * 20,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 0, 0, 0),
                Color.fromRGBO(19, 20, 21, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}
