import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/apartment_provider.dart';
import '../../../../utilities/size_config.dart';
import '../../../shared/widgets/custom_appbar_no image.dart';
import '../../home/widgets/apartment_card.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = "/favorite";
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onePercentOfHeight = SizeConfig.heightMultiplier;
    final apartmentProvider =
        Provider.of<ApartmentProvider>(context, listen: true);

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
                  child: CustomAppbarNoImage(
                    title: "Favorites",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: apartmentProvider.favoriteApartments.isNotEmpty
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
                        itemCount: apartmentProvider.favoriteApartments.length,
                        itemBuilder: (context, index) {
                          return ApartmentCard(
                              key: UniqueKey(),
                              apartmentData:
                                  apartmentProvider.favoriteApartments[index],
                              index: index);
                        },
                      )
                    : const Text("No apartments are favorites"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
