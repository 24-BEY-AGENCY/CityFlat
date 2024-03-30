import 'package:cityflat/presentation/shared/widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../models/user_model.dart';
import '../../../providers/user_provider.dart';
import '../../../utilities/generate_image_url.dart';
import 'custom_back_button.dart';

class CustomAppbar extends StatefulWidget {
  final String? title;
  final Function()? onPressed;

  const CustomAppbar({super.key, this.title, this.onPressed});

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  User? userData;

  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userData = userProvider.user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              CustomTitle(
                title: widget.title!,
                fontSize: 26.0,
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
      ],
    );
  }
}
