import 'package:cityflat/presentation/user/favorite/widgets/favorite_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/apartment_provider.dart';
import '../../../../utilities/size_config.dart';
import '../../home/widgets/apartment_card.dart';

class FavoriteScreenTab extends StatelessWidget {
  static const routeName = "/favoriteTab";
  const FavoriteScreenTab({super.key});

  @override
  Widget build(BuildContext context) {
    final onePercentOfHeight = SizeConfig.heightMultiplier;
    final apartmentProvider =
        Provider.of<ApartmentProvider>(context, listen: true);
    print(apartmentProvider.favoriteApartments);

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
                      child: const FavoriteAppbar(
                        title: "Favorites",
                      ))),
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
