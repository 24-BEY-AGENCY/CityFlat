import 'package:cityflat/presentation/user/home/widgets/apartment_filter_dialog.dart';
import 'package:cityflat/presentation/user/home/widgets/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../models/apartment_model.dart';
import '../../../../providers/apartment_provider.dart';
import '../../../../providers/token_provider.dart';
import '../../../../services/apartment_service.dart';
import '../../../../services/connectivity_service.dart';
import '../../../../services/wishlist_service.dart';
import '../../../../utilities/size_config.dart';
import '../../../authentication/screens/login/login_screen.dart';
import '../../../shared/widgets/custom_icon_button.dart';
import '../../../shared/widgets/custom_icons.dart';
import '../../../shared/widgets/custom_light_textformfield.dart';
import '../../../shared/widgets/custom_toast.dart';
import '../widgets/apartment_card.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/userHome";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FToast? fToast;
  Future<List<Apartment>>? apartmentListFuture;
  double min = 0;
  double max = 5000;

  Future<void> onGetApartmentList() async {
    try {
      final response = ApartmentService().getAllAppartWishlisted();
      print(response);
      apartmentListFuture = response;
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    await tokenProvider.clearSecureStorage();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
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
      _errorToast();
    }
  }

  void _showLogoutToast() {
    Future.delayed(Duration.zero, () {
      fToast!.showToast(
        child: const CustomToast(
          text: "Your session has expired. Please login.",
          textColor: Color.fromRGBO(255, 255, 255, 1),
          backgroundColor: Color.fromRGBO(190, 6, 6, 1),
        ),
        toastDuration: const Duration(seconds: 5),
        gravity: ToastGravity.TOP,
      );
    });
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
    ConnectivityService.initConnectivity(context);
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (apartmentListFuture == null) {
      onGetApartmentList();
    }
  }

  @override
  void dispose() {
    fToast!.removeCustomToast();
    super.dispose();
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
              child: Builder(
                  builder: (context) => GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: const HomeAppbar())),
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
                              if (snapshot.error == "jwt expired" ||
                                  snapshot.error == "Authentication failed") {
                                _showLogoutToast();
                                Future.delayed(
                                    const Duration(milliseconds: 500), () {
                                  logout();
                                });
                              }
                              return const Center(
                                  child: Text(
                                      "Error when getting apartment list"));
                            }

                            if (snapshot.hasData) {
                              apartmentProvider.setApartments(snapshot.data!);
                              if (apartmentProvider
                                  .favoriteApartments.isEmpty) {
                                apartmentProvider
                                    .setFavoriteApartments(snapshot.data!);
                              }
                              double smallestPrice = double.infinity;
                              double largestPrice = double.negativeInfinity;

                              if (apartmentProvider.apartments.isEmpty) {
                                smallestPrice = 0;
                                largestPrice = 0;
                              } else if (apartmentProvider.apartments.length ==
                                  1) {
                                smallestPrice = apartmentProvider
                                    .apartments[0].defaultDateAndPrice!.price
                                    .toDouble();
                                largestPrice = 5000;
                              } else {
                                for (var apartment
                                    in apartmentProvider.apartments) {
                                  if (apartment.defaultDateAndPrice!.price <
                                      smallestPrice) {
                                    smallestPrice = apartment
                                        .defaultDateAndPrice!.price
                                        .toDouble();
                                  }

                                  if (apartment.defaultDateAndPrice!.price >
                                      largestPrice) {
                                    largestPrice = apartment
                                        .defaultDateAndPrice!.price
                                        .toDouble();
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
                                            key: UniqueKey(),
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
