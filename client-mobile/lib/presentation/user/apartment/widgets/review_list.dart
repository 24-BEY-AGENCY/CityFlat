import 'package:cityflat/models/review_model.dart';
import 'package:cityflat/presentation/user/apartment/widgets/review_card.dart';
import 'package:cityflat/providers/review_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../services/review_service.dart';

class ReviewList extends StatefulWidget {
  final String? apartmentId;
  const ReviewList({super.key, this.apartmentId});

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  Future<List<Review>>? reviewListFuture;

  Future<void> onGetReviewList() async {
    try {
      final response =
          ReviewService().getAllReviewsForOneApartment(widget.apartmentId!);
      print(response);
      reviewListFuture = response;
    } catch (error) {
      print(error);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (reviewListFuture == null) {
      onGetReviewList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context, listen: true);

    return FutureBuilder<List<Review>>(
        future: reviewListFuture,
        builder: (ctx, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text("error when getting reviews list."),
                );
              }

              if (snapshot.hasData) {
                reviewProvider.setReviews(snapshot.data!);

                return reviewProvider.reviews.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 0.0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: reviewProvider.reviews.length,
                        itemBuilder: (context, index) {
                          return ReviewCard(
                              review: reviewProvider.reviews[index]);
                        })
                    : Container();
              } else {
                return const Center(
                  child: Text("error when getting reviews list."),
                );
              }
          }
        });
  }
}
