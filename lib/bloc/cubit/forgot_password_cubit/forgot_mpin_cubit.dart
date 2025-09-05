import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:service_mitra/config/data/repository/auth/forgot_mpin_repository.dart';

import '../../../config/colors/colors.dart';
import '../../../config/routes/routes_name.dart';

class ForgotMpinState {
  final String mpin;
  final String confirmMpin;
  final bool isValid;
  final bool isConfirmValid;
  final bool success;
  final bool isloading;
  final TextEditingController controller;
  final TextEditingController confirmController;

  ForgotMpinState({
    required this.mpin,
    required this.confirmMpin,
    required this.isValid,
    required this.isConfirmValid,
    this.success = false,
    this.isloading = false,
    required this.controller,
    required this.confirmController
  });

  ForgotMpinState copyWith({
    String? mpin,
    String? confirmMpin,
    bool? isValid,
    bool? isConfirmValid,
    bool? success,
    bool? isloading,
    TextEditingController? controller,
    TextEditingController? confirmController,
  }) {
    return ForgotMpinState(
      mpin: mpin ?? this.mpin,
      confirmMpin: confirmMpin ?? this.confirmMpin,
      isValid: isValid ?? this.isValid,
      isConfirmValid: isConfirmValid ?? this.isConfirmValid,
      success: success ?? this.success,
      isloading: isloading ?? this.isloading,
      controller: controller ?? this.controller,
      confirmController: confirmController ?? this.confirmController,
    );
  }
}

class ForgotMpinCubit extends Cubit<ForgotMpinState> {
  final ForgotMpinRepository forgotMpinRepository;
  ForgotMpinCubit(this.forgotMpinRepository)
      : super(
          ForgotMpinState(
            mpin: '',
            confirmMpin: '',
            isValid: true,
            isConfirmValid: true,
            controller: TextEditingController(),
            confirmController: TextEditingController(),
          ),
        );

  void onMpinChanged(String mpin) {
    final isValid = validateMpin(mpin);
    emit(state.copyWith(
      mpin: mpin,
      isValid: isValid,
    ));
  }

  void clearMpin() {
    state.controller.clear();
    state.confirmController.clear();
    emit(state.copyWith(isValid: false, mpin: '', confirmMpin: ''));
  }

  void onConfirmMpinChanged(String mpin) {
    final isConfirmValid = validateMpin(mpin);
    emit(state.copyWith(
      confirmMpin: mpin,
      isConfirmValid: isConfirmValid,
    ));
  }

  bool validateMpin(String mpin) {
    return mpin.length == 4;
  }

  void validate() {
    final isValid = validateMpin(state.mpin);
    emit(state.copyWith(isValid: isValid));
  }

  void validateConfirmMpin() {
    final isValid = validateMpin(state.confirmMpin);
    emit(state.copyWith(isConfirmValid: isValid));
  }

  Future<void> submitMPin(BuildContext context, String mpin, String confirmMpin) async {
    emit(state.copyWith(isloading: true));

    try {
      final mPin =
          await forgotMpinRepository.submitMpin(mpin: mpin, confirmMpin: confirmMpin, context: context);

      if (mPin.isNotEmpty) {
        debugPrint("MPIN updated successful");

        emit(state.copyWith(success: true, isloading: false));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(mPin, style: const TextStyle(color: AppColors.colblack)),
            backgroundColor: AppColors.colGreen,
          ),
        );

        Navigator.pushReplacementNamed(context, RoutesName.loginmpin);
      } else {
        debugPrint("Invalid MPIN");
        emit(state.copyWith(success: false, isloading: false));
      }
    } catch (e) {
      debugPrint("MPIN failed: ${e.toString()}");
      emit(state.copyWith(success: false, isloading: false));
    }
  }

  @override
  Future<void> close() {
    state.controller.dispose();
    return super.close();
  }
}
