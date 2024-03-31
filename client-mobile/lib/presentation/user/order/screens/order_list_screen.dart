import 'package:cityflat/models/order_model.dart';
import 'package:cityflat/presentation/user/order/widgets/order_card.dart';
import 'package:cityflat/providers/order_provider.dart';
import 'package:cityflat/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utilities/size_config.dart';
import '../../../shared/widgets/custom_appbar_no image.dart';

class OrderListScreen extends StatefulWidget {
  static const routeName = "/orderList";

  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  Future<List<Order>>? orderFuture;

  onGetOrderList() async {
    try {
      final response = OrderService().getAllOrdersByUser();
      orderFuture = response;
    } catch (error) {
      print(error);
    }
  }

  Future<void> _refreshData() async {
    onGetOrderList();
  }

  @override
  void didChangeDependencies() {
    if (orderFuture == null) {
      onGetOrderList();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final onePercentOfHeight = SizeConfig.heightMultiplier;
    final orderProvider = Provider.of<OrderProvider>(context, listen: true);

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
          child: FutureBuilder<List<Order>>(
              future: orderFuture,
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
                              title: "My Ordres :",
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
                                title: "My Ordres :",
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          const Spacer(),
                          Center(
                            child: Text(snapshot.error ==
                                    "No orders found for this user!"
                                ? "No orders"
                                : "error when getting orders."),
                          ),
                          const Spacer(),
                        ],
                      );
                    }

                    if (snapshot.hasData) {
                      orderProvider.setOrders(snapshot.data!);

                      return orderProvider.orders.isNotEmpty
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
                                            "My Ordres (${snapshot.data!.length}) :",
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: orderProvider.orders.length,
                                      itemBuilder: (context, index) {
                                        return OrderCard(
                                            order: orderProvider.orders[index]);
                                      }),
                                ),
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
                                      title: "My Ordres :",
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                const Center(
                                  child: Text("No orders"),
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
                                title: "My Ordres :",
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Center(
                            child: Text("error when getting orders."),
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
