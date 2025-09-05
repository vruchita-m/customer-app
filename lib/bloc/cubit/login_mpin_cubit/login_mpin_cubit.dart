import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:service_mitra/config/share_preferences/preferences.dart';

import '../../../config/colors/colors.dart';
import '../../../config/data/repository/auth/login_mpin_repository.dart';
import '../../../config/routes/routes_name.dart';

class MpinState {
  final String mpin;
  final bool isValid;
  final bool success;
  final bool isloading;
  final TextEditingController controller;

  MpinState({
    required this.mpin,
    required this.isValid,
    this.success = false,
    this.isloading = false,
    required this.controller,
  });

  MpinState copyWith({
    String? mpin,
    bool? isValid,
    bool? success,
    bool? isloading,
    TextEditingController? controller,
  }) {
    return MpinState(
      mpin: mpin ?? this.mpin,
      isValid: isValid ?? this.isValid,
      success: success ?? this.success,
      isloading: isloading ?? this.isloading,
      controller: controller ?? this.controller,
    );
  }
}

class MpinCubit extends Cubit<MpinState> {
  final LoginMpinRepository loginMpinRepository;
  MpinCubit(this.loginMpinRepository)
      : super(
          MpinState(
            mpin: '',
            isValid: true,
            controller: TextEditingController(),
          ),
        );

  void onMpinChanged(String mpin) {
    final isValid = validateMpin(mpin);
    emit(state.copyWith(
      mpin: mpin,
      isValid: isValid,
    ));
  }

  bool validateMpin(String mpin) {
    return mpin.length == 4;
  }

  void validate() {
    final isValid = validateMpin(state.mpin);
    emit(state.copyWith(isValid: isValid));
  }

  Future<void> submitMpin(BuildContext context) async {
    emit(state.copyWith(isloading: true));

    try {
      final mPin = await loginMpinRepository.mPin(mpin: state.mpin, context: context);

      if (mPin.isNotEmpty) {
        debugPrint("MPIN successful");

        emit(state.copyWith(success: true, isloading: false));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(mPin, style: const TextStyle(color: AppColors.colblack)),
            backgroundColor: AppColors.colGreen,
          ),
        );

        Navigator.pushReplacementNamed(context, RoutesName.homescreen);
      } else {
        debugPrint("Invalid MPIN");
        emit(state.copyWith(success: false, isloading: false));
      }
    } catch (e) {
      debugPrint("MPIN failed: ${e.toString()}");
      emit(state.copyWith(success: false, isloading: false));
    }
  }

  Future<void> requestMpinOTP(BuildContext context) async {
    emit(state.copyWith(isloading: true));
    final email = Preference.getString(PrefKeys.email);

    try {
      final mPin =
          await loginMpinRepository.requestMpinOTP(context: context, email: email);

      if (mPin.isNotEmpty) {
        debugPrint("MPIN successful");

        emit(state.copyWith(success: true, isloading: false));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(mPin, style: const TextStyle(color: AppColors.colblack)),
            backgroundColor: AppColors.colGreen,
          ),
        );

        Navigator.pushReplacementNamed(context, RoutesName.forgotpasswordOTP, arguments: {'email' : email, 'from' : 'mPin'});
      } else {
        debugPrint("Invalid Email");
        emit(state.copyWith(success: false, isloading: false));
      }
    } catch (e) {
      debugPrint("MPIN OTP failed: ${e.toString()}");
      emit(state.copyWith(success: false, isloading: false));
    }
  }

  @override
  Future<void> close() {
    state.controller.dispose();
    return super.close();
  }
}
