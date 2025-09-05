import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/data/repository/auth/forgot_repositry.dart';
import 'package:service_mitra/config/routes/routes_name.dart';

class ForgotCubit extends Cubit<ForgotState>{
  final ForgotRepository forgotRepository;
  ForgotCubit(this.forgotRepository) : super(ForgotState());  

  Future<void> forgotPassword(BuildContext context, String email) async {
    String? emailError;

    // Email Validation
    if (email.isEmpty) {
      emailError = "Email is required.";
    } else if (!EmailValidator.validate(email)) {
      emailError = "Please enter a valid email.";
    }

    // If there are validation errors, emit them and stop further execution
    if (emailError != null) {
      emit(state.copyWith(emailError: emailError));
      return; // Stop execution here
    }

    // Start Loading State
    emit(state.copyWith(isLoading: true));

    try {
      final loginResponse = await forgotRepository.loginCustomer(
        email: email,
        context: context,
      );

      if(loginResponse.isNotEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loginResponse ,
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
    emit(ForgotState());
  }
}

class ForgotState {
  final String? emailError;
  final String? apiError;
  final bool isSuccess;
  final bool isLoading;

  ForgotState({
    this.emailError,
    this.apiError,
    this.isSuccess = false,
    this.isLoading = false,
  });

  ForgotState copyWith({
    String? emailError,
    String? apiError,
    bool? isSuccess,
    bool? isLoading,
  }) {
    return ForgotState(
      emailError: emailError ?? this.emailError,
      apiError: apiError ?? this.apiError,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
