import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// A constant key to access the value in storage.
const String _notificationCountKey = 'notification_count';

class NotificationCountCubit extends Cubit<int> {
  NotificationCountCubit() : super(0);

  /// ✅ Loads the count from local storage.
  /// You should call this method when your app starts.
  Future<void> loadCount() async {
    final prefs = await SharedPreferences.getInstance();
    final count = prefs.getInt(_notificationCountKey) ?? 0;
    emit(count);
  }

  /// ✅ Updates the count and saves the new value to local storage.
  /// ✅ Updates the count and saves the new value to local storage.
  Future<void> updateCount(int count) async {
    emit(count);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_notificationCountKey, count);  // <-- changed from state to count
  }

  /// ✅ Increments the count and saves the new value.
  Future<void> increment() async {
    final newCount = state + 1;
    emit(newCount);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_notificationCountKey, newCount);
  }

  /// ✅ Decrements the count and saves the new value.
  Future<void> decrement() async {
    if (state > 0) {
      final newCount = state - 1;
      emit(newCount);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_notificationCountKey, newCount);
    }
  }

  /// ✅ Resets the count and clears it from storage.
  Future<void> reset() async {
    emit(0);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_notificationCountKey, 0);
  }
}