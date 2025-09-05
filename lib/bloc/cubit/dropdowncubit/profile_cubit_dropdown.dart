import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDropdownState {
  final String? state;
  final String? city;
  final String? tahsil;

  ProfileDropdownState({this.state, this.city, this.tahsil});

  ProfileDropdownState copyWith({String? state, String? city, String? tahsil}) {
    return ProfileDropdownState(
      state: state ?? this.state,
      city: city ?? this.city,
      tahsil: tahsil ?? this.tahsil,
    );
  }
}

class ProfileCubitDropdown extends Cubit<ProfileDropdownState> {
  ProfileCubitDropdown() : super(ProfileDropdownState());

  void selectCity(String city) {
    debugPrint("City : $city");
    emit(state.copyWith(city: city));
  } 
  void selectTahsil(String tahsil) => emit(state.copyWith(tahsil: tahsil));
  void selectState(String stateName) => emit(state.copyWith(state: stateName));
}
