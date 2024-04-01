import 'package:cityflat/models/review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../models/user_model.dart';
import '../../../../providers/review_provider.dart';
import '../../../../providers/token_provider.dart';
import '../../../../services/review_service.dart';
import '../../../../utilities/textFormField_validators.dart';
import '../../../shared/widgets/custom_toast.dart';

class NewReview extends StatefulWidget {
  final String? apartmentId;

  const NewReview({super.key, this.apartmentId});

  @override
  State<NewReview> createState() => _NewReviewState();
}

class _NewReviewState extends State<NewReview> {
  FToast? fToast;
  final _formKey = GlobalKey<FormState>();

  final _reviewValidator = TextFormFieldValidators.reviewValidator;
  final _reviewKey = GlobalKey<FormFieldState>();
  final _reviewController = TextEditingController();
  bool? _reviewValid = false;

  double _rating = 0.0;

  Review newReview = Review(
    Rating: 0.0,
    Description: "",
  );

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
  }

  void _showSuccessToast() {
    Future.delayed(const Duration(milliseconds: 500), () {
      fToast!.showToast(
        child: const CustomToast(
          text: "Your review was added successfully.",
          textColor: Color.fromRGBO(255, 255, 255, 1),
          backgroundColor: Color.fromRGBO(6, 190, 86, 1),
        ),
        toastDuration: const Duration(seconds: 5),
        gravity: ToastGravity.TOP,
      );
    });
  }

  void _showFailureToast() {
    Future.delayed(const Duration(milliseconds: 500), () {
      fToast!.showToast(
        child: const CustomToast(
          text: "An error has occurred. Please retry.",
          textColor: Color.fromRGBO(255, 255, 255, 1),
          backgroundColor: Color.fromRGBO(190, 6, 6, 1),
        ),
        toastDuration: const Duration(seconds: 5),
        gravity: ToastGravity.TOP,
      );
    });
  }

  onRatingUpdate(rating) {
    setState(() {
      _rating = rating;
      newReview.Rating = rating;
    });
  }

  onCreateReview() async {
    try {
      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        FocusScope.of(context).unfocus();
        await EasyLoading.show(
          indicator: const CircularProgressIndicator(
            color: Color.fromRGBO(13, 178, 84, 1),
          ),
          maskType: EasyLoadingMaskType.black,
        );
        if (!mounted) return;
        final tokenProvider =
            Provider.of<TokenProvider>(context, listen: false);
        User? user = tokenProvider.userData;
        newReview.User = user!.id!;
        newReview.UserName = user.name!;
        if (newReview.Rating == newReview.Rating!.toInt()) {
          newReview.Rating = newReview.Rating!.toInt();
        }
        await ReviewService().createReview(newReview, widget.apartmentId!);
        if (!mounted) return;
        final reviewProvider =
            Provider.of<ReviewProvider>(context, listen: false);
        reviewProvider.addReview(newReview);

        if (EasyLoading.isShow) {
          await EasyLoading.dismiss();
        }
        setState(() {
          newReview = Review(
            Rating: 0,
            Description: "",
          );
          _reviewController.clear();
          _reviewValid = false;
          onRatingUpdate(0.0);
        });

        _showSuccessToast();
      }
    } catch (error) {
      if (EasyLoading.isShow) {
        await EasyLoading.dismiss();
      }
      _showFailureToast();
    }
  }

  @override
  void dispose() {
    fToast!.removeCustomToast();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);

    return Container(
      margin: const EdgeInsets.only(left: 60.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: TextFormField(
                key: _reviewKey,
                minLines: 4,
                maxLines: 20,
                maxLength: 200,
                validator: _reviewValidator,
                textAlignVertical: TextAlignVertical.top,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.multiline,
                controller: _reviewController,
                cursorColor: const Color.fromRGBO(6, 190, 86, 1),
                style: TextStyle(
                  color: const Color.fromRGBO(26, 26, 26, 1),
                  fontSize: 18.0 * curScaleFactor,
                  fontFamily: 'TT Commons',
                  fontWeight: FontWeight.w500,
                ),
                onChanged: (value) => setState(() {
                  newReview.Description = value;
                  _reviewValid = _reviewController.text.isEmpty
                      ? false
                      : _reviewKey.currentState!.validate();
                }),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(243, 243, 243, 1),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide:
                        const BorderSide(color: Color.fromRGBO(6, 190, 86, 1)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(243, 243, 243, 1),
                      width: 1.0,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15.0, bottom: 20.0),
              child: RatingBar(
                initialRating: _rating,
                direction: Axis.horizontal,
                allowHalfRating: true,
                updateOnDrag: true,
                itemCount: 5,
                itemSize: 35.0,
                ratingWidget: RatingWidget(
                  full: SvgPicture.asset(
                    "assets/icons/svg/star_filled.svg",
                    fit: BoxFit.fitWidth,
                    color: const Color.fromRGBO(222, 194, 95, 1),
                  ),
                  half: SvgPicture.asset(
                    "assets/icons/svg/star_half_filled.svg",
                    fit: BoxFit.fitWidth,
                    color: const Color.fromRGBO(222, 194, 95, 1),
                  ),
                  empty: SvgPicture.asset(
                    "assets/icons/svg/star_border.svg",
                    fit: BoxFit.fitWidth,
                    color: const Color.fromRGBO(0, 0, 0, 0.2),
                  ),
                ),
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: onRatingUpdate,
              ),
            ),
            Container(
              width: 125.0,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              child: MaterialButton(
                onPressed: _reviewValid == true ? onCreateReview : null,
                textColor: _reviewValid!
                    ? const Color.fromRGBO(255, 255, 255, 1)
                    : const Color.fromRGBO(255, 255, 255, 0.7),
                disabledTextColor: const Color.fromRGBO(255, 255, 255, 0.1),
                disabledColor: const Color.fromRGBO(255, 255, 255, 0.1),
                splashColor: const Color.fromRGBO(2, 129, 57, 1),
                highlightColor: const Color.fromRGBO(2, 129, 57, 0.7),
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Ink(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: _reviewValid!
                            ? [
                                const Color.fromRGBO(2, 129, 57, 1),
                                const Color.fromRGBO(7, 210, 95, 1)
                              ]
                            : [
                                const Color.fromRGBO(2, 129, 57, 0.7),
                                const Color.fromRGBO(7, 210, 95, 0.7)
                              ]),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                      height: 45,
                      constraints: const BoxConstraints(
                          maxWidth: 100.0, minHeight: 40.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Send",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0 * curScaleFactor,
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
