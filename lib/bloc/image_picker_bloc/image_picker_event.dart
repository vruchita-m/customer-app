abstract class AddVehicleEvent {}

class PickImageEvent extends AddVehicleEvent {
  final String field;
  PickImageEvent(this.field);
}
