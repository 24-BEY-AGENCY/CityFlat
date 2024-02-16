import 'dart:math';

import 'package:cityflat/presentation/user/home/screens/home_screen.dart';
import 'package:cityflat/presentation/user/account/screens/account_screen.dart';
import 'package:cityflat/presentation/user/favorite/screens/favorite_screen.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/user_model.dart';
import '../../../providers/token_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utilities/size_config.dart';
import '../../shared/widgets/custom_icons.dart';

class UserWrapper extends StatefulWidget {
  static const routeName = "/userWrapper";
  const UserWrapper({super.key});

  @override
  State<UserWrapper> createState() => _UserWrapperState();
}

class _UserWrapperState extends State<UserWrapper> {
  int _selectedPageIndex = 0;
  User? userData;

  final List<dynamic>? _pages = [
    FavoriteScreen(),
    HomeScreen(),
    AccountScreen(),
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  setUserData() {
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    tokenProvider.getUserData().then((value) {
      userProvider.setUser(tokenProvider.userData!);
    });
  }

  @override
  void initState() {
    setUserData();

    super.initState();
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
        child: _pages![_selectedPageIndex],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 6.0),
        decoration: BoxDecoration(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 25,
            cornerSmoothing: 1,
          ),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(25, 26, 30, 1),
              Color.fromRGBO(30, 32, 36, 1),
              Color.fromRGBO(67, 70, 72, 1),
            ],
            stops: [0.2, 0.4, 0.8],
            transform: GradientRotation(pi / 0.505),
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: _selectPage,
            currentIndex: _selectedPageIndex,
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            selectedIconTheme: const IconThemeData(size: 27),
            unselectedIconTheme: const IconThemeData(size: 27),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(CustomIcons.favorite),
                label: "Favorite",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15.0),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: SmoothBorderRadius(
                        cornerRadius: 20,
                        cornerSmoothing: 1,
                      ),
                    ),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(2, 129, 57, 1),
                        Color.fromRGBO(7, 210, 95, 1),
                      ],
                      transform: GradientRotation(pi / 0.46),
                      stops: [0.2, 0.8],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color.fromRGBO(47, 52, 60, 74),
                        blurRadius: 4.6,
                        spreadRadius: 0.0,
                        offset: Offset(-6, -7.0),
                      ),
                      BoxShadow(
                        color: Color.fromRGBO(28, 31, 35, 85),
                        blurRadius: 4.5,
                        spreadRadius: 0.0,
                        offset: Offset(6, 7.0),
                      ),
                    ],
                  ),
                  child: const Icon(CustomIcons.home),
                ),
                label: "Home",
              ),
              const BottomNavigationBarItem(
                icon: Icon(CustomIcons.rental),
                label: "Rental",
              ),
            ]),
      ),
    );
  }
}
