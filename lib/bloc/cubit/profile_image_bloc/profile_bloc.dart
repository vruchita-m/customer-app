import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfilePickBloc extends Bloc<ProfilePickEvent, ProfilePickState> {
  final ImagePicker _picker = ImagePicker();

  ProfilePickBloc() : super(ProfileInitialState()) {
    on<PickImageEvent>(_onPickImage);
  }

  Future<void> _onPickImage(
      PickImageEvent event, Emitter<ProfilePickState> emit) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: event.fromCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        emit(ProfileImageUpdatedState(profileImage: File(pickedFile.path)));
      }
    } catch (e) {
      SnackBar(content: Text('error ==>${e}'));
    }
  }
}
