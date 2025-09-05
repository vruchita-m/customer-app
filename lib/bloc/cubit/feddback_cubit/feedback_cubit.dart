import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:service_mitra/bloc/cubit/feddback_cubit/feedback_state.dart';
import 'package:service_mitra/config/data/repository/feedback/feedback_repository.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  final FeedbackRepository feedbackRepository;

  FeedbackCubit(this.feedbackRepository) : super(FeedbackInitial());

  void submitFeedback(num rating, String review, String ticketId, BuildContext context) async {
    if (review.isEmpty) {
      emit(FeedbackError("Review cannot be empty"));
      return;
    }

    emit(FeedbackLoading());

    try {
      await feedbackRepository.sendFeedback(context: context, review: review, ticketId: ticketId, rate: rating);
      emit(FeedbackSuccess());
    } catch (e) {
      emit(FeedbackError(e.toString()));
    }
  }
}
