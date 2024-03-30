import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../models/apartment_model.dart';
import '../../../../services/apartment_service.dart';
import '../../../../services/wishlist_service.dart';
import '../../../../utilities/size_config.dart';
import '../../../shared/widgets/custom_appbar_no image.dart';
import '../../../shared/widgets/custom_toast.dart';
import '../../home/widgets/apartment_card.dart';

class RentalListScreen extends StatefulWidget {
  static const routeName = "/RentalList";

  const RentalListScreen({super.key});

  @override
  State<RentalListScreen> createState() => _RentalListScreenState();
}

class _RentalListScreenState extends State<RentalListScreen> {
  Future<List<Apartment>>? rentalFuture;
  FToast? fToast;

  onGetRentalsList() async {
    try {
      final response = ApartmentService().getAllRentalsWishlisted();
      rentalFuture = response;
    } catch (error) {
      print(error);
    }
  }

  Future<void> _refreshData() async {
    onGetRentalsList();
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

  Future<void> onAddToWishlist(String apartmentId) async {
    try {
      final response = await WishlistService().addToWishlist(apartmentId);
      print(response);
    } catch (error) {
      _errorToast();
    }
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  @override
  void didChangeDependencies() {
    if (rentalFuture == null) {
      onGetRentalsList();
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
    final onePercentOfHeight = SizeConfig.heightMultiplier;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      extendBody: true,
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
        child: RefreshIndicator(
          onRefresh: () {
            return _refreshData();
          },
          child: FutureBuilder<List<Apartment>>(
              future: rentalFuture,
              builder: (ctx, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                              left: 5.0, right: 20.0, bottom: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              Scaffold.of(context).openEndDrawer();
                            },
                            child: CustomAppbarNoImage(
                              title: "My Rentals :",
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
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
                            child: GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                              child: CustomAppbarNoImage(
                                title: "My Rentals :",
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          const Spacer(),
                          Center(
                            child: Text("error when getting rentals."),
                          ),
                          const Spacer(),
                        ],
                      );
                    }

                    if (snapshot.hasData) {
                      return snapshot.data!.isNotEmpty
                          ? Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 5.0, right: 20.0, bottom: 10.0),
                                  child: Builder(
                                    builder: (context) => GestureDetector(
                                      onTap: () {
                                        Scaffold.of(context).openEndDrawer();
                                      },
                                      child: CustomAppbarNoImage(
                                        title:
                                            "My Rentals (${snapshot.data!.length}) :",
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: GridView.builder(
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
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return ApartmentCard(
                                      key: UniqueKey(),
                                      apartmentData: snapshot.data![index],
                                      index: index,
                                      isRental: true,
                                    );
                                  },
                                )),
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(
                                      left: 5.0, right: 20.0, bottom: 20.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Scaffold.of(context).openEndDrawer();
                                    },
                                    child: CustomAppbarNoImage(
                                      title: "My Rentals :",
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                const Center(
                                  child: Text("No rentals"),
                                ),
                                const Spacer(),
                              ],
                            );
                    } else {
                      return Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(
                                left: 5.0, right: 20.0, bottom: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                              child: CustomAppbarNoImage(
                                title: "My Rentals :",
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Center(
                            child: Text("error when getting rentals."),
                          ),
                          const Spacer(),
                        ],
                      );
                    }
                }
              }),
        ),
      ),
    );
  }
}
