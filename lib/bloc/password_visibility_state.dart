class PasswordVisibilityState {
  final bool isPasswordVisible,isConfirmPasswordVisible;

  PasswordVisibilityState({this.isPasswordVisible = false, this.isConfirmPasswordVisible = false});

  PasswordVisibilityState copyWith({bool? isPasswordVisible}) {
    return PasswordVisibilityState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }

  PasswordVisibilityState copyConfirmWith({bool? isConfirmPasswordVisible}) {
    return PasswordVisibilityState(
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
    );
  }
}
