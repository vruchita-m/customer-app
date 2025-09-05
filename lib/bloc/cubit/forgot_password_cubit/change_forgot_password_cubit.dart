import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/data/repository/auth/change_forgot_password_repositry.dart';
import 'package:service_mitra/config/routes/routes_name.dart';

class ChangeForgotPasswordCubit extends Cubit<ChangeForgotPasswordState>{
  final ChangeForgotPasswordRepositry changeForgotPasswordRepositry;
  ChangeForgotPasswordCubit(this.changeForgotPasswordRepositry) : super(
    ChangeForgotPasswordState(
      confirmPassword: "",
      email: "",
      isValid: false,
      password: ""
    )
  );

  void onPasswordChanged(String password){
    final isValid = validatePassword(password);
    emit(state.copyWith(
      password: password,
      isValid: isValid,
    ));
  }

  bool validatePassword(String password) {
    debugPrint("length : ${password.length}");
    return password.length > 7;  // min password length should be 8
  }

  bool validateConfirmPassword(String password, String confirmPassword) {
    return password == confirmPassword;  // both password should match
  }

  void validate(String password, String confirmPassword) {
    final isValidPassword = validatePassword(password);
    final isValidConfirmPassword = validateConfirmPassword(password,confirmPassword);
    debugPrint("isValidPassword : $isValidPassword");
    debugPrint("isValidConfirmPassword : $isValidConfirmPassword");
    emit(state.copyWith(isValid: (isValidPassword && isValidConfirmPassword)));
  }

  Future<void> changePassword(BuildContext context, String email, String password, String confirmPassword) async {
    emit(state.copyWith(isloading: true));

    try {
      final otpResponse =
          await changeForgotPasswordRepositry.changePassword(email: email, password : password, confirmPassword: confirmPassword, context: context);

      if (otpResponse.isNotEmpty) {
        debugPrint("Password reset successful");

        emit(state.copyWith(success: true, isloading: false));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(otpResponse, style: const TextStyle(color: AppColors.colblack)),
            backgroundColor: AppColors.colGreen,
          ),
        );

        Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false,);
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
    return super.close();
  }

}

class ChangeForgotPasswordState{
  final String email;
  final String password;
  final String confirmPassword;
  final bool isValid;
  final bool success;
  final bool isloading;

  ChangeForgotPasswordState({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.isValid,
    this.isloading = false,
    this.success = false,
  });

  ChangeForgotPasswordState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    bool? isValid,
    bool? success,
    bool? isloading
  }){
    return ChangeForgotPasswordState(
      email: email ?? this.email, 
      password: password ?? this.password, 
      confirmPassword: confirmPassword ?? this.confirmPassword, 
      isValid: isValid ?? this.isValid);
  }
}