import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/user_model.dart';
import '../../../../providers/user_provider.dart';
import '../../../shared/widgets/custom_back_button.dart';

class ProfileAppbar extends StatefulWidget {
  final String? title;
  final Function()? onPressed;

  const ProfileAppbar({super.key, this.title, this.onPressed});

  @override
  State<ProfileAppbar> createState() => _ProfileAppbarState();
}

class _ProfileAppbarState extends State<ProfileAppbar> {
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
    final curScaleFactor = mediaQuery.textScaler.scale(1);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: CustomBackButton(onPressed: widget.onPressed!)),
              Container(
                margin: const EdgeInsets.only(left: 15.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color.fromRGBO(45, 49, 54, 1),
                    fontFamily: 'TT Commons',
                    fontSize: 24.0 * curScaleFactor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
