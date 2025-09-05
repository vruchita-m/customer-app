import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_mitra/bloc/password_visibility_event.dart';
import 'package:service_mitra/bloc/password_visibility_state.dart';

class PasswordVisibilityBloc extends Bloc<PasswordVisibilityEvent, PasswordVisibilityState> {
  PasswordVisibilityBloc() : super(PasswordVisibilityState()) {
    on<TogglePasswordVisibilityEvent>((event, emit) {
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
    });
    on<ToggleConfirmPasswordVisibilityEvent>((event, emit) {
      emit(state.copyConfirmWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
    });
  }
}
