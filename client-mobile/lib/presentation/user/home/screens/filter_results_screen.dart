import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../../../models/apartment_model.dart';
import '../../../../services/connectivity_service.dart';
import '../../../../services/search_service.dart';
import '../../../../utilities/size_config.dart';
import '../../../shared/widgets/custom_appbar.dart';
import '../widgets/apartment_card.dart';

class FilterResultsScreen extends StatefulWidget {
  static const routeName = "/filterResults";
  const FilterResultsScreen({super.key});

  @override
  State<FilterResultsScreen> createState() => _FilterResultsScreenState();
}

class _FilterResultsScreenState extends State<FilterResultsScreen> {
  Future<List<Apartment>?>? filterResults;

  Future<void> onfilterApartmentByPriceRange() async {
    try {
      final arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      RangeValues rangeValues = arguments["rangeValues"];

      filterResults = SerchService()
          .filterApartmentByPriceRange(rangeValues.start, rangeValues.end);
    } catch (error) {
      print(error);
    }
  }

  Future<void> _refreshData() async {
    onfilterApartmentByPriceRange();
  }

  @override
  void initState() {
    super.initState();
    ConnectivityService.initConnectivity(context);
  }

  @override
  void didChangeDependencies() {
    if (filterResults == null) {
      onfilterApartmentByPriceRange();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final onePercentOfHeight = SizeConfig.heightMultiplier;

    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        Navigator.pop(context);
        Navigator.pop(context);
      },
      child: Scaffold(
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
                  margin: const EdgeInsets.only(
                      left: 5.0, right: 20.0, bottom: 20.0),
                  child: CustomAppbar(
                    title: "Filter results",
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      return _refreshData();
                    },
                    child: FutureBuilder<List<Apartment>?>(
                        future: filterResults,
                        builder: (ctx, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return SizedBox(
                                height: onePercentOfHeight * 80,
                                child: const Center(
                                    child: CircularProgressIndicator()),
                              );
                            case ConnectionState.done:
                            default:
                              if (snapshot.hasError) {
                                return SizedBox(
                                  height: onePercentOfHeight * 80,
                                  child: const Center(
                                    child: Text(
                                        "Error when getting filter results."),
                                  ),
                                );
                              }

                              if (snapshot.hasData) {
                                return snapshot.data!.isNotEmpty
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
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          return ApartmentCard(
                                              key: UniqueKey(),
                                              apartmentData:
                                                  snapshot.data![index],
                                              index: index);
                                        },
                                      )
                                    : const Text(
                                        "No apartments available in this filter");
                              } else {
                                return const Text(
                                    "Error when getting filter results.");
                              }
                          }
                        }),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
