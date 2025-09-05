import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_mitra/bloc/cubit/profile_cubit/profile_state.dart';
import 'package:service_mitra/config/data/repository/profile_repositry.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;
  ProfileCubit(this.repository) : super(ProfileInitial());

  TextEditingController name = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController gstNo = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController address = TextEditingController();

  TextEditingController stateName = TextEditingController();
  TextEditingController cityName = TextEditingController();
  TextEditingController tahsilName = TextEditingController();
  TextEditingController customerId = TextEditingController();

  // String stateName = "", cityName = "", tahsilName = "";
  final formkey = GlobalKey<FormState>();

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a name";
    }

    return null;
  }

  String? stateNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter state name";
    }

    return null;
  }

  String? cityNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a city name";
    }

    return null;
  }

  String? tehsilNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a tahsil name";
    }

    return null;
  }

  String? mobileNoValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a number";
    }
    if (value.length < 10) {
      return "Please enter valid number";
    }
    return null;
  }

  String? gstNoValidator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.length != 15) {
      return "Please enter valid GST no.";
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter an email address";
    }
    if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? pincodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter Pincode";
    }
    if (value.length < 6) {
      return "Please enter valid Pincode";
    }
    return null;
  }

  String? stateValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select state";
    }

    return null;
  }

  String? cityValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select city";
    }

    return null;
  }

  String? tahsilValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select tahsil";
    }

    return null;
  }

  Future<void> fetchProfile(BuildContext context) async {
    emit(ProfileLoading());
    try {
      final profileData = await repository.getProfile(context);
      emit(ProfileLoaded(profileData));
    } catch (e) {
      emit(ProfileError("Failed to load profile"));
    }
  }

  Future<void> updateProfile(
      BuildContext context, Map<String, String> updatedData) async {
    emit(ProfileLoading());
    try {
      await repository.updateProfile(context, updatedData);
      emit(ProfileUpdated());
    } catch (e) {
      emit(ProfileError("Failed to update profile"));
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    emit(ProfileLoading());
    try {
      await repository.deleteAccount(context);
      emit(ProfileDeleted());
    } catch (e) {
      emit(ProfileError("Failed to delete profile"));
    }
  }
}
