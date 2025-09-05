import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:service_mitra/bloc/notification_bloc/notification_state.dart';
import 'package:service_mitra/config/data/repository/notification_repositry/notification_repositry.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationRepositry notificationRepositry;
  NotificationCubit(this.notificationRepositry) : super(NotificationInitial());

  void loadNotifications(BuildContext context) async {
    emit(NotificationLoading());
    try {
      final notifications =
      await notificationRepositry.fetchNotifications(context);
      emit(NotificationLoaded(notifications));
    } catch (e) {
      emit(NotificationError("Failed to load notifications"));
    }
  }
}
