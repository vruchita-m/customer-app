import 'dart:io';

abstract class ProfilePickState {}

class ProfileInitialState extends ProfilePickState {}

class ProfileImageUpdatedState extends ProfilePickState {
  final File profileImage;

  ProfileImageUpdatedState({required this.profileImage});
}
