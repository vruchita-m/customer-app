// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginCubit extends Cubit<LoginState> {
//   LoginCubit() : super(LoginState());

//   void login(String email, String password, String confirmPassword) {
//     String? emailError;
//     String? passwordError;

//     if (email.isEmpty) {
//       emailError = "Email is required.";
//     } else if (!RegExp(r"^[a-zA-Z0-9]+@gmail\.com$").hasMatch(email)) {
//       emailError = "Please enter a valid email.";
//     }

//     if (password.isEmpty) {
//       passwordError = "Password is required.";
//     } else if (password.length < 8) {
//       passwordError = "Password should be at least 8 characters.";
//     } else if (password != confirmPassword) {
//       passwordError = "Passwords do not match.";
//     }

//     if (emailError == null && passwordError == null) {
//       emit(state.copyWith(isSuccess: true));
//     } else {
//       emit(
//           state.copyWith(emailError: emailError, passwordError: passwordError));
//     }
//   }
// }

// class LoginState {
//   final String? emailError;
//   final String? passwordError;
//   final bool isSuccess;

//   LoginState({
//     this.emailError,
//     this.passwordError,
//     this.isSuccess = false,
//   });

//   LoginState copyWith({
//     String? emailError,
//     String? passwordError,
//     bool? isSuccess,
//   }) {
//     return LoginState(
//       emailError: emailError ?? this.emailError,
//       passwordError: passwordError ?? this.passwordError,
//       isSuccess: isSuccess ?? this.isSuccess,
//     );
//   }
// }

//*********************** *//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:email_validator/email_validator.dart'; // For email validation

// class LoginCubit extends Cubit<LoginState> {
//   LoginCubit() : super(LoginState());

//   void login(String email, String password, String confirmPassword) {
//     String? emailError;
//     String? passwordError;

//     if (email.isEmpty) {
//       emailError = "Email is required.";
//     } else if (!EmailValidator.validate(email)) {
//       emailError = "Please enter a valid email.";
//     }

//     if (password.isEmpty) {
//       passwordError = "Password is required.";
//     } else if (password.length < 8) {
//       passwordError = "Password should be at least 8 characters.";
//     } else if (password != confirmPassword) {
//       passwordError = "Passwords do not match.";
//     }

//     if (emailError == null && passwordError == null) {
//       emit(state.copyWith(
//           isSuccess: true, emailError: null, passwordError: null));
//     } else {
//       emit(
//           state.copyWith(emailError: emailError, passwordError: passwordError));
//     }
//   }

//   void resetState() {
//     emit(LoginState());
//   }
// }

// class LoginState {
//   final String? emailError;
//   final String? passwordError;
//   final bool isSuccess;

//   LoginState({
//     this.emailError,
//     this.passwordError,
//     this.isSuccess = false,
//   });

//   LoginState copyWith({
//     String? emailError,
//     String? passwordError,
//     bool? isSuccess,
//   }) {
//     return LoginState(
//       emailError: emailError ?? this.emailError,
//       passwordError: passwordError ?? this.passwordError,
//       isSuccess: isSuccess ?? this.isSuccess,
//     );
//   }
// }

//******** *//
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:service_mitra/views/widegts/token_checker.dart';

import '../../../config/colors/colors.dart';
import '../../../config/data/repository/auth/login_repository.dart';
import '../../../config/routes/routes_name.dart';
import '../../../config/share_preferences/preferences.dart'; // For email validation

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;
  LoginCubit(this.loginRepository) : super(LoginState());

  Future<void> login(BuildContext context, String email, String password,
      String confirmPassword, String firebaseToken) async {
    String? emailError;
    String? passwordError;

    // Email Validation
    if (email.isEmpty) {
      emailError = "Email is required.";
    } else if (!EmailValidator.validate(email)) {
      emailError = "Please enter a valid email.";
    }

    // Password Validation
    if (password.isEmpty) {
      passwordError = "Password is required.";
    } else if (password.length < 8) {
      passwordError = "Password should be at least 8 characters.";
    } else if (password != confirmPassword) {
      passwordError = "Passwords do not match.";
    }

    // If there are validation errors, emit them and stop further execution
    if (emailError != null || passwordError != null) {
      emit(
          state.copyWith(emailError: emailError, passwordError: passwordError));
      return; // Stop execution here
    }

    // Start Loading State
    emit(state.copyWith(isLoading: true));

    try {
      final loginmodel = await loginRepository.loginCustomer(
        email: email,
        password: password,
        firebaseToken: firebaseToken,
        context: context,
      );
      // await Preference.setString(PrefKeys.token, '');
      if (loginmodel.status == "success") {
        Preference.setString(PrefKeys.userId, loginmodel.results?.id ?? '');
        Preference.setString(PrefKeys.email, loginmodel.results?.email ?? '');
        await Preference.setString(
            PrefKeys.token, loginmodel.results?.accessToken ?? '');
        debugPrint('Token ==>>>>>>>>  ${Preference.getString(PrefKeys.token)}');
        debugPrint("Login successful");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loginmodel.message!,
                style: const TextStyle(color: AppColors.colblack)),
            backgroundColor: AppColors.colGreen,
          ),
        );
        emit(state.copyWith(isSuccess: true, isLoading: false));
      } else {
        debugPrint("Invalid credentials");
        emit(state.copyWith(isSuccess: false, isLoading: false));
      }
    } catch (e) {
      debugPrint("Login failed: ${e.toString()}");
      emit(state.copyWith(isSuccess: false, isLoading: false));
    }
  }

  void resetState() {
    emit(LoginState());
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password should contain 8 characters';
    }
    return null;
  }
}

class LoginState {
  final String? emailError;
  final String? passwordError;
  final String? apiError;
  final bool isSuccess;
  final bool isLoading;

  LoginState({
    this.emailError,
    this.passwordError,
    this.apiError,
    this.isSuccess = false,
    this.isLoading = false,
  });

  LoginState copyWith({
    String? emailError,
    String? passwordError,
    String? apiError,
    bool? isSuccess,
    bool? isLoading,
  }) {
    return LoginState(
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      apiError: apiError ?? this.apiError,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
