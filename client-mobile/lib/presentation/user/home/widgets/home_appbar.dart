import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/user_model.dart';
import '../../../../providers/user_provider.dart';

class HomeAppbar extends StatefulWidget {
  const HomeAppbar({super.key});

  @override
  State<HomeAppbar> createState() => _HomeAppbarState();
}

class _HomeAppbarState extends State<HomeAppbar> {
  User? userData;

  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userData = userProvider.user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaleFactor;

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
                  "Hello ${userData!.name} !",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color.fromRGBO(45, 49, 54, 1),
                    fontFamily: 'TT Commons',
                    fontSize: 23.0 * curScaleFactor,
                    fontWeight: FontWeight.w700,
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
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  userData!.img!,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
