import 'dart:ui';

import 'package:cityflat/presentation/shared/widgets/custom_icons.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../models/user_model.dart';
import '../../../providers/token_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utilities/generate_image_url.dart';
import '../../../utilities/size_config.dart';
import '../../authentication/screens/login/login_screen.dart';
import '../../user/favorite/screens/favorite_screen.dart';
import '../../user/order/screens/order_list_screen.dart';
import '../../user/profile/screens/profile_screen.dart';
import '../../user/rental/screens/rental_list_screen.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({super.key});

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  User? userData;

  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userData = userProvider.user;
    super.initState();
  }

  Future<void> logout() async {
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    await tokenProvider.clearSecureStorage();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final mediaQueryHeight = mediaQuery.size.height;
    final bigPhoneCheck = mediaQueryHeight >= 750;
    final onePercentOfWidth = SizeConfig.widthMultiplier;
    final curScaleFactor = mediaQuery.textScaler.scale(1);

    Widget buildListTile({
      IconData? icon,
      Widget? svgIcon,
      String? title,
      VoidCallback? onClicked,
    }) {
      return ListTile(
        dense: true,
        horizontalTitleGap: 0.0,
        minLeadingWidth: 35.0,
        leading: icon != null
            ? Icon(
                icon,
                size: 13 * curScaleFactor,
                color: const Color.fromRGBO(132, 137, 152, 1),
              )
            : svgIcon,
        title: Text(
          title!,
          style: TextStyle(
            fontFamily: 'TT Commons',
            fontSize: 14.0 * curScaleFactor,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(45, 49, 54, 1),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        onTap: onClicked,
      );
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
      child: Drawer(
        width: bigPhoneCheck ? onePercentOfWidth * 60 : onePercentOfWidth * 80,
        shape: const RoundedRectangleBorder(
          borderRadius: SmoothBorderRadius.only(
            topLeft: SmoothRadius(
              cornerRadius: 50,
              cornerSmoothing: 1,
            ),
          ),
        ),
        child: Container(
          decoration: const ShapeDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            shape: RoundedRectangleBorder(
              borderRadius: SmoothBorderRadius.only(
                topLeft: SmoothRadius(
                  cornerRadius: 50,
                  cornerSmoothing: 1,
                ),
              ),
            ),
          ),
          child: Container(
            decoration: const ShapeDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(169, 169, 169, 0.27),
                  Color.fromRGBO(255, 255, 255, 0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.4, 1],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: SmoothBorderRadius.only(
                  topLeft: SmoothRadius(
                    cornerRadius: 50,
                    cornerSmoothing: 1,
                  ),
                  bottomLeft: SmoothRadius(
                    cornerRadius: 50,
                    cornerSmoothing: 1,
                  ),
                ),
              ),
            ),
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        bottom: 20.0, left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color.fromRGBO(255, 255, 255, 81),
                                blurRadius: 5.2,
                                spreadRadius: 0.0,
                                offset: Offset(-4.0, -4.0),
                              ),
                              BoxShadow(
                                color: Color.fromRGBO(231, 231, 231, 71),
                                blurRadius: 3.5,
                                spreadRadius: 0.0,
                                offset: Offset(5.0, 4.0),
                              ),
                            ],
                          ),
                          child: Container(
                            height: 30.0,
                            width: 30.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: userData!.img!.contains("/images")
                                  ? Image.network(
                                      GenerateImageUrl.getImage(userData!.img!),
                                      fit: BoxFit.cover,
                                      height: 50,
                                      width: 50,
                                    )
                                  : SvgPicture.asset(
                                      "assets/images/user_img.svg",
                                      fit: BoxFit.cover,
                                      height: 50,
                                      width: 50,
                                    ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Hello ${userData!.name} !",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: const Color.fromRGBO(45, 49, 54, 1),
                              fontFamily: 'TT Commons',
                              fontSize: 17.0 * curScaleFactor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    thickness: 0.5,
                    indent: 22.0,
                    height: 10.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      children: [
                        buildListTile(
                          icon: CustomIcons.user,
                          title: "My Profile",
                          onClicked: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(
                              ProfileScreen.routeName,
                            );
                          },
                        ),
                        buildListTile(
                          icon: CustomIcons.favorite,
                          title: "My Favorites",
                          onClicked: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(
                              FavoriteScreen.routeName,
                            );
                          },
                        ),
                        buildListTile(
                          svgIcon: SvgPicture.asset(
                            "assets/icons/svg/rental.svg",
                            height: 13,
                            color: const Color.fromRGBO(132, 137, 152, 1),
                          ),
                          title: "My Rentals",
                          onClicked: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(
                              RentalListScreen.routeName,
                            );
                          },
                        ),
                        buildListTile(
                          svgIcon: SvgPicture.asset(
                            "assets/icons/svg/order.svg",
                            height: 13,
                            color: const Color.fromRGBO(132, 137, 152, 1),
                          ),
                          title: "My Ordres",
                          onClicked: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(
                              OrderListScreen.routeName,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    thickness: 0.5,
                    indent: 22.0,
                    height: 10.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        bottom: 20.0, left: 20.0, right: 20.0),
                    child: ListTile(
                      dense: true,
                      horizontalTitleGap: onePercentOfWidth * 20,
                      leading: Text(
                        "Logout",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14.0 * curScaleFactor,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      title: Icon(
                        CustomIcons.logout,
                        size: 18 * curScaleFactor,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                      onTap: () {
                        logout();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
