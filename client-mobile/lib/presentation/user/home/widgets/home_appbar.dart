import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../providers/token_provider.dart';
import '../../../../providers/user_provider.dart';
import '../../../../utilities/generate_image_url.dart';

class HomeAppbar extends StatefulWidget {
  const HomeAppbar({super.key});

  @override
  State<HomeAppbar> createState() => _HomeAppbarState();
}

class _HomeAppbarState extends State<HomeAppbar> {
  Future<void> setUserData() async {
    try {
      final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await tokenProvider.getUserData();
      userProvider.setUser(tokenProvider.userData!);
    } catch (error) {
      print('Error fetching user data: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);

    return FutureBuilder<void>(
      future: setUserData(),
      builder: (ctx, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError) {
              return const Center(child: Text("Error when getting user data"));
            }

            return Consumer<UserProvider>(
              builder: (ctx, userProvider, _) {
                final userData = userProvider.user;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Hello ${userData.name} !",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: const Color.fromRGBO(45, 49, 54, 1),
                                fontFamily: 'TT Commons',
                                fontSize: 23.0 * curScaleFactor,
                                fontWeight: FontWeight.w700,
                                height: 1,
                              ),
                            ),
                          ),
                          Text(
                            "Welcome to our application",
                            style: TextStyle(
                              color: const Color.fromRGBO(45, 49, 54, 1),
                              fontFamily: 'Montserrat',
                              fontSize: 14.0 * curScaleFactor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                        height: 38.0,
                        width: 38.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: userData.img!.contains("/images")
                              ? Image.network(
                                  GenerateImageUrl.getImage(userData.img!),
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
                  ],
                );
              },
            );
          default:
            return const Text("Error when getting user data");
        }
      },
    );
  }
}
