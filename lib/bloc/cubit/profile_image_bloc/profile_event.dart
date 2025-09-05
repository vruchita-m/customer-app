abstract class ProfilePickEvent {}

class PickImageEvent extends ProfilePickEvent {
  final bool fromCamera;
  PickImageEvent({required this.fromCamera});
}
