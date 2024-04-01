import 'package:cityflat/models/review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utilities/generate_image_url.dart';
import '../../../../utilities/size_config.dart';

class ReviewCard extends StatelessWidget {
  final Review? review;
  const ReviewCard({super.key, this.review});

  Widget ratingBuilder(double rating) {
    int ratingFloor = rating.floor();
    double ratingFraction = rating - ratingFloor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < ratingFloor) {
          // Display a filled star
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            child: SvgPicture.asset(
              "assets/icons/svg/star_filled.svg",
              height: 14.0,
              width: 14.0,
              color: const Color.fromRGBO(222, 194, 95, 1),
            ),
          );
        } else if (index == ratingFloor && ratingFraction > 0) {
          // Display a half-filled star
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            child: SvgPicture.asset(
              "assets/icons/svg/star_half_filled.svg",
              height: 14.0,
              width: 14.0,
              color: const Color.fromRGBO(222, 194, 95, 1),
            ),
          );
        } else {
          // Display a border star
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            child: SvgPicture.asset(
              "assets/icons/svg/star_border.svg",
              height: 14.0,
              width: 14.0,
              color: const Color.fromRGBO(0, 0, 0, 0.2),
            ),
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);
    final onePercentOfWidth = SizeConfig.widthMultiplier;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
              color: const Color.fromRGBO(13, 178, 84, 1),
              width: 2.37,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: review!.img!.contains("/images")
                ? Image.network(
                    GenerateImageUrl.getImage(review!.img!),
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
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 1.5),
                child: Text(
                  review!.UserName!,
                  style: TextStyle(
                    fontFamily: 'Helvetica Neue',
                    fontSize: 18.0 * curScaleFactor,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              ratingBuilder(review!.Rating!.toDouble()),
              Container(
                margin: const EdgeInsets.only(top: 8.0),
                width: onePercentOfWidth * 70,
                child: Text(
                  review!.Description!,
                  style: TextStyle(
                    fontFamily: 'TT Commons',
                    fontSize: 18.0 * curScaleFactor,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                    color: const Color.fromRGBO(132, 137, 152, 1),
                    height: 1.05,
                  ),
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Divider(
                color: Color.fromRGBO(188, 188, 188, 0.2),
                thickness: 1,
                endIndent: 10.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
