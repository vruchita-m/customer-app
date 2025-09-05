abstract class AddVehicleState {}

class AddVehicleInitial extends AddVehicleState {}

class ImagePickedState extends AddVehicleState {
  final String imagePath;
  final String imageName;
  final String field;

  ImagePickedState(this.imagePath, this.imageName, {required this.field});
}
