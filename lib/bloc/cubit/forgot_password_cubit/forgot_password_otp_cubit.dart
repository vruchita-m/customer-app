import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:service_mitra/config/data/repository/auth/forgot_password_otp_repositry.dart';

import '../../../config/colors/colors.dart';
import '../../../config/routes/routes_name.dart';

class ForgotPasswordOTPState {
    final String email;
    final String otp;
    final bool isValid;
    final bool success;
    final bool isloading;
  final TextEditingController controller;

  ForgotPasswordOTPState({
    required this.email,
    required this.otp,
    required this.isValid,
    this.success = false,
    this.isloading = false,
    required this.controller,
  });

  ForgotPasswordOTPState copyWith({
    String? email,
    String? otp,
    bool? isValid,
    bool? success,
    bool? isloading,
    TextEditingController? controller,
  }) {
    return ForgotPasswordOTPState(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      isValid: isValid ?? this.isValid,
      success: success ?? this.success,
      isloading: isloading ?? this.isloading,
      controller: controller ?? this.controller,
    );
  }
}

class ForgotPasswordOTPCubit extends Cubit<ForgotPasswordOTPState> {
  final ForgotPasswordOtpRepositry forgotPasswordOtpRepositry;
  ForgotPasswordOTPCubit(this.forgotPasswordOtpRepositry)
      : super(
          ForgotPasswordOTPState(
            email: '',
            otp: '',
            isValid: true,
            controller: TextEditingController(),
          ),
        );

  void onEmailChanged(String email) {
    final isValid = validateEmail(email);
    emit(state.copyWith(
      email: email,
      isValid: isValid,
    ));
  }

  void clearOTP() {
    state.controller.clear();
    emit(state.copyWith(otp: '', isValid: false));
  }

  bool validateEmail(String email) {
    return EmailValidator.validate(email);
  }

  void onOTPChanged(String otp) {
    final isValid = validateOTP(otp);
    emit(state.copyWith(
      otp: otp,
      isValid: isValid,
    ));
  }

  bool validateOTP(String otp) {
    return otp.length == 4;
  }

  void validate() {
    final isValidOTP = validateOTP(state.otp);
    emit(state.copyWith(isValid: (isValidOTP)));
  }

  void resetState(){
    
  }

  Future<void> submitOTP(BuildContext context, String email, String from) async {
    emit(state.copyWith(isloading: true));

    try {
      final otpResponse =
          await forgotPasswordOtpRepositry.submitOTP(email: email, otp : state.otp, context: context);

      if (otpResponse.isNotEmpty) {
        debugPrint("OTP matched successful");

        emit(state.copyWith(success: true, isloading: false));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(otpResponse, style: const TextStyle(color: AppColors.colblack)),
            backgroundColor: AppColors.colGreen,
          ),
        );

        if(from == "mPin") {
          Navigator.pushReplacementNamed(context, RoutesName.forgotMpin, arguments: {'email' : email}).then((value) {
            clearOTP();
          },);
        } else {
          Navigator.pushReplacementNamed(context, RoutesName.changeForgotPassword, arguments: {'email' : email}).then((value) => clearOTP(),);
        }
      } else {
        debugPrint("Invalid OTP");
        emit(state.copyWith(success: false, isloading: false));
      }
    } catch (e) {
      debugPrint("OTP failed: ${e.toString()}");
      emit(state.copyWith(success: false, isloading: false));
    }
  }

  @override
  Future<void> close() {
    state.controller.dispose();
    return super.close();
  }
}
