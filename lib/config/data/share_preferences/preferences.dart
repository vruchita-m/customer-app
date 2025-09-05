// import 'package:shared_preferences/shared_preferences.dart';

// class Preference {
//   static late SharedPreferences preferences;

//   // Initialize SharedPreferences
//   static Future<void> initialize() async {
//     preferences = await SharedPreferences.getInstance();
//   }

//   // Get a string value by key
//   static String getString(String key) {
//     return preferences.getString(key) ?? "";
//   }

//   // Set a string value by key
//   static Future<void> setString(String key, String value) async {
//     await preferences.setString(key, value);
//   }

//   // Get the Mechanic ID
//   static String? getMechanicId() {
//     return preferences.getString(PrefKeys.userId);
//   }

//   // Set the Mechanic ID
//   static Future<void> setMechanicId(String mechanicId) async {
//     await preferences.setString(PrefKeys.userId, mechanicId);
//   }

//   // static String? getTicketId() {
//   //   return preferences.getString(PrefKeys.ticketId);
//   // }

//   // static Future<void> setTicketId(String ticketId) async {
//   //   await preferences.setString(PrefKeys.ticketId, ticketId);
//   // }

//   // Clear all stored preferences
//   static Future<void> clear() async {
//     await preferences.clear();
//   }
// }

// class PrefKeys {
//   static const token = "token";
//   static const userId = "userId";
//   static const estimateId = "estimateId";
// }

// // Function to clear preferences, typically used during logout
// Future<void> logoutPref() async {
//   await Preference.clear();
// }
