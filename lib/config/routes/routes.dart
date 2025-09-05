import 'package:flutter/material.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/views/screens/blank.dart';
import 'package:service_mitra/views/screens/coming_soon/coming_soon.dart';
import 'package:service_mitra/views/screens/drawer/my_vehicles/add_vehicle.dart';
import 'package:service_mitra/views/screens/drawer/my_vehicles/my_vehicles.dart';
import 'package:service_mitra/views/screens/drawer/my_vehicles/vehicle_details.dart';
import 'package:service_mitra/views/screens/drawer/my_profile/profile.dart';
import 'package:service_mitra/views/screens/estimate/estimate_screen.dart';
import 'package:service_mitra/views/screens/feedbackandreview/feedbackandreview.dart';
import 'package:service_mitra/views/screens/home/home_screen.dart';
import 'package:service_mitra/views/screens/notification/notifications.dart';
import 'package:service_mitra/views/screens/onboarding/change_forgot_password_screen.dart';
import 'package:service_mitra/views/screens/onboarding/forgot_mpin_screen.dart';
import 'package:service_mitra/views/screens/onboarding/forgot_password_otp_screen.dart';
import 'package:service_mitra/views/screens/onboarding/forgot_password_screen.dart';
import 'package:service_mitra/views/screens/onboarding/login_mpin_screen.dart';
import 'package:service_mitra/views/screens/onboarding/login_screen.dart';
import 'package:service_mitra/views/screens/ticket_status/ticket_status.dart';
import 'package:service_mitra/views/screens/transaction/transactions.dart';
import 'package:service_mitra/views/webview_screen.dart';

import '../../views/screens/drawer/breakdown_ticket_status/breakdown_ticket_status.dart';
import '../../views/screens/onboarding/splash.dart';
import '../../views/screens/timeline/timeline.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => const Splash());
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case RoutesName.loginmpin:
        return MaterialPageRoute(
          builder: (context) => const LoginMpinScreen(),
        );
      case RoutesName.homescreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case RoutesName.forgotpassword:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );
      case RoutesName.forgotpasswordOTP:
       final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => ForgotPasswordOtpScreen(arguments: args),
        );
      case RoutesName.changeForgotPassword:
       final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => ChangeForgotPasswordScreen(arguments: args),
        );
      case RoutesName.forgotMpin :
        return MaterialPageRoute(builder: (context) => const ForgotMpinScreen());
      case RoutesName.breakdownticketstatus:
        return MaterialPageRoute(
          builder: (context) => BreakDownTicketStatus(),
        );
      // case RoutesName.opentickets:
      //   return MaterialPageRoute(
      //     builder: (context) => OpenTickets(),
      //   );
      // case RoutesName.closetickets:
      //   return MaterialPageRoute(
      //     builder: (context) => CloseTickets(),
      //   );
      case RoutesName.estimate:
        final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => EstimateScreen(ticketsResults: args['ticketsResults'] ?? '',
          ),
        );
      case RoutesName.myvehicles:
        return MaterialPageRoute(
          builder: (context) => const MyVehicles(),
        );
      case RoutesName.addvehicle:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => AddVehicle(arguments : args),
        );
      case RoutesName.vehicledetails:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => VehicleDetails(vehicle : args['vehicle']),
        );
      case RoutesName.profile:
        return MaterialPageRoute(
          builder: (context) => const Profile(),
        );
      case RoutesName.feedbackandreview:
      final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => FeedbackAndReview(ticketId: args["ticketId"],),
        );
      case RoutesName.transactions:
        return MaterialPageRoute(
          builder: (context) => const Transactions(),
        );
      case RoutesName.ticketstatus:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => TicketStatus(vehicleId : args["vehicle_id"]),
        );
      case RoutesName.webviewScrren:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => WebViewScreen(title : args["title"], url: args["url"],),
        );
      case RoutesName.notification:
        // final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => const Notifications(),
        );
      case RoutesName.comingsoon:
        return MaterialPageRoute(
          builder: (context) => const ComingSoon(),
        );
      case RoutesName.blank:
        return MaterialPageRoute(
          builder: (context) => const Blank(),
        );
      case RoutesName.timeline:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          // builder: (context) => const TimelineCustom(),
          builder: (context) => TimelineCustom(complaintNo: args!['ticketId']),
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
                body: Center(
              child: Text('No Routes Generated'),
            ));
          },
        );
    }
  }
}
