import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:service_mitra/bloc/cubit/feddback_cubit/feedback_cubit.dart';
import 'package:service_mitra/bloc/cubit/feddback_cubit/feedback_state.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/data/repository/feedback/feedback_repository.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/views/widegts/custom_appbar.dart';
import 'package:service_mitra/views/widegts/custom_elevated_button.dart';
import 'package:service_mitra/views/widegts/inter_text.dart';

class FeedbackAndReview extends StatefulWidget {
  final String ticketId;
  const FeedbackAndReview({super.key, required this.ticketId});

  @override
  State<FeedbackAndReview> createState() => _FeedbackAndReviewState();
}

class _FeedbackAndReviewState extends State<FeedbackAndReview> {
  double _rating = 5.0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedbackCubit(FeedbackRepository()),
      child: Scaffold(
        backgroundColor: AppColors.textformfieldcol,
        appBar: const CustomAppBar(title: "Feedback & Review"),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 40),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.whitecol,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const InterText(
                        height: 0,
                        text: "Rate your service",
                        fontsize: 20,
                        fontweight: FontWeight.w600,
                      ),
                      const SizedBox(height: 10),
                      RatingBar(
                        initialRating: 5,
                        allowHalfRating: true,
                        minRating: 1,
                        maxRating: 5,
                        itemSize: 35,
                        ratingWidget: RatingWidget(
                          full: const Icon(Icons.star,
                              color: AppColors.colyellow),
                          half: const Icon(Icons.star_half,
                              color: AppColors.colyellow),
                          empty: const Icon(Icons.star_outline,
                              color: AppColors.colyellow),
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      InterText(
                        height: 0,
                        text: "Review",
                        fontsize: 16,
                        fontweight: FontWeight.w500,
                        color: AppColors.lightblackcol.withOpacity(0.8),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _reviewController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Write your review...",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'inter',
                            fontWeight: FontWeight.w400,
                            color: AppColors.lightblackcol.withOpacity(0.8),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color:
                                    AppColors.lightblackcol.withOpacity(0.2)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 40),
          child: BlocConsumer<FeedbackCubit, FeedbackState>(
            listener: (context, state) {
              if (state is FeedbackSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Feedback submitted successfully")),
                );
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  RoutesName.breakdownticketstatus,
                );
              } else if (state is FeedbackError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              return CustomElevatedButton(
                text: state is FeedbackLoading ? "Submitting..." : "Submit",
                onpressed: state is FeedbackLoading
                    ? null
                    : () {
                        context.read<FeedbackCubit>().submitFeedback(_rating,
                            _reviewController.text, widget.ticketId, context);
                      },
              );
            },
          ),
        ),
      ),
    );
  }
}
