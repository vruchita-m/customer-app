import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // Naya import
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/add_vehicle_cubit.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/emission_norms_cubit.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/fuel_type_cubit.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/tyres_cubit.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/vehicle_make_cubit.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/vehicle_category_cubit.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/vehicle_modal_cubit.dart';
import 'package:service_mitra/bloc/cubit/dropdowncubit/profile_cubit_dropdown.dart';
import 'package:service_mitra/bloc/cubit/dropdowncubit/transaction_cubit.dart';
import 'package:service_mitra/bloc/cubit/forgot_password_cubit/change_forgot_password_cubit.dart';
import 'package:service_mitra/bloc/cubit/forgot_password_cubit/forgot_cubit.dart';
import 'package:service_mitra/bloc/cubit/forgot_password_cubit/forgot_mpin_cubit.dart';
import 'package:service_mitra/bloc/cubit/forgot_password_cubit/forgot_password_otp_cubit.dart';
import 'package:service_mitra/bloc/cubit/login_cubit/login_cubit.dart';
import 'package:service_mitra/bloc/cubit/login_mpin_cubit/login_mpin_cubit.dart';
import 'package:service_mitra/bloc/cubit/profile_cubit/profile_cubit.dart';
import 'package:service_mitra/bloc/estimate/estimate_bloc.dart';
import 'package:service_mitra/bloc/image_picker_bloc/image_picker_bloc.dart';
import 'package:service_mitra/bloc/notification_bloc/notification_cubit.dart';
import 'package:service_mitra/bloc/password_visiblity_bloc.dart';
import 'package:service_mitra/config/data/repository/auth/change_forgot_password_repositry.dart';
import 'package:service_mitra/config/data/repository/auth/forgot_mpin_repository.dart';
import 'package:service_mitra/config/data/repository/auth/forgot_password_otp_repositry.dart';
import 'package:service_mitra/config/data/repository/auth/forgot_repositry.dart';
import 'package:service_mitra/config/data/repository/auth/login_mpin_repository.dart';
import 'package:service_mitra/config/data/repository/estimate/estimation_repository.dart';
import 'package:service_mitra/config/data/repository/notification_repositry/notification_repositry.dart';
import 'package:service_mitra/config/data/repository/profile_repositry.dart';
import 'package:service_mitra/config/data/repository/vehicle/my_vehicle_repositry.dart';
import 'package:service_mitra/config/routes/routes.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/utlis/firebase.dart';
import 'package:service_mitra/utlis/firebase_options.dart';
import 'package:service_mitra/views/screens/onboarding/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/cubit/dropdowncubit/add_vehicle_cubit_dropdown.dart';
import 'bloc/cubit/profile_image_bloc/profile_bloc.dart';
import 'bloc/notification_bloc/notification_count_cubit.dart';
import 'config/data/repository/auth/login_repository.dart';
import 'config/share_preferences/preferences.dart';
import 'package:permission_handler/permission_handler.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Preference.preferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.getInitialMessage();

  await requestNotificationPermission();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}

Future<void> requestNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && navigatorKey.currentContext != null) {
        final context = navigatorKey.currentContext!;

        FirebaseUtils().firebaseInit(
          onNotificationReceived: () {

            debugPrint("New notification received! Refreshing notification list...");

            context.read<NotificationCubit>().loadNotifications(context);
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NotificationCountCubit()..loadCount(), // loadCount() app start hote hi purana count load kar lega
          ),
          BlocProvider(
            create: (context) => VehicleCubitDropdown(),
          ),
          BlocProvider(
            create: (context) => ProfileCubitDropdown(),
          ),
          BlocProvider(create: (context) => TransactionCubitDropdown()),
          BlocProvider(
            create: (context) => LoginCubit(LoginRepository()),
          ),
          BlocProvider(create: (context) => PasswordVisibilityBloc()),
          BlocProvider(
            create: (context) => MpinCubit(LoginMpinRepository()),
          ),
          BlocProvider(
            create: (context) => ForgotCubit(ForgotRepository()),
          ),
          BlocProvider(
            create: (context) =>
                ForgotPasswordOTPCubit(ForgotPasswordOtpRepositry()),
          ),
          BlocProvider(
            create: (context) =>
                ChangeForgotPasswordCubit(ChangeForgotPasswordRepositry()),
          ),
          BlocProvider(
            create: (context) => ForgotMpinCubit(ForgotMpinRepository()),
          ),
          BlocProvider(
            create: (context) => AddVehicleCubit(MyVehicleRepositry()),
          ),
          BlocProvider(
            create: (context) => VehicleMakeCubit(MyVehicleRepositry()),
          ),
          BlocProvider(
            create: (context) => EmissionNormsCubit(MyVehicleRepositry()),
          ),
          BlocProvider(
            create: (context) => NotificationCubit(NotificationRepositry()),
          ),
          BlocProvider(
            create: (context) => FuelTypeCubit(MyVehicleRepositry()),
          ),
          BlocProvider(
            create: (context) => VehicleModalCubit(MyVehicleRepositry()),
          ),
          BlocProvider(
            create: (context) => VehicleCategoryCubit(MyVehicleRepositry()),
          ),
          BlocProvider(
            create: (context) => TyresCubit(MyVehicleRepositry()),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(ProfileRepository()),
          ),
          BlocProvider(
            create: (context) => AddVehicleBloc(),
          ),
          BlocProvider(
            create: (context) => EstimateBloc(EstimationRepository()),
          ),
          BlocProvider(create: (context) => ProfilePickBloc()),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          home: const Splash(),
          debugShowCheckedModeBanner: false,
          title: 'Truk Mitra',
          initialRoute: RoutesName.splash,
          onGenerateRoute: Routes.generateRoute,
        ));
  }
}