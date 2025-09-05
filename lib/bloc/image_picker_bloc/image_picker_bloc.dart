// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:service_mitra/bloc/image_picker_bloc/image_picker_event.dart';
// import 'package:service_mitra/bloc/image_picker_bloc/image_picker_state.dart';

// class AddVehicleBloc extends Bloc<AddVehicleEvent, AddVehicleState> {
//   final ImagePicker _picker = ImagePicker();

//   AddVehicleBloc() : super(AddVehicleInitial()) {
//     on<PickImageEvent>((event, emit) async {
//       try {
//         final XFile? pickedFile =
//             await _picker.pickImage(source: ImageSource.gallery);

//         if (pickedFile != null) {
//           emit(ImagePickedState(pickedFile.path));
//         }
//       } catch (e) {
//         print("Error picking image: $e");
//       }
//     });
//   }
// }

// import 'package:bloc/bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;
// import 'package:service_mitra/bloc/image_picker_bloc/image_picker_event.dart';
// import 'package:service_mitra/bloc/image_picker_bloc/image_picker_state.dart';

// class AddVehicleBloc extends Bloc<AddVehicleEvent, AddVehicleState> {
//   final ImagePicker _picker = ImagePicker();

//   AddVehicleBloc() : super(AddVehicleInitial()) {
//     on<PickImageEvent>((event, emit) async {
//       try {
//         final XFile? pickedFile =
//             await _picker.pickImage(source: ImageSource.gallery);

//         if (pickedFile != null) {
//           // Shorten the file path to just the file name
//           String fileName = path.basename(pickedFile.path);

//           // Emit the shortened file name
//           emit(ImagePickedState(fileName));
//         }
//       } catch (e) {
//         print("Error picking image: $e");
//       }
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'image_picker_event.dart';
import 'image_picker_state.dart';

class AddVehicleBloc extends Bloc<AddVehicleEvent, AddVehicleState> {
  final ImagePicker _picker = ImagePicker();

  AddVehicleBloc() : super(AddVehicleInitial()) {
    on<PickImageEvent>((event, emit) async {
      if(event.field.isEmpty){
        emit(ImagePickedState("", "", field: ""));
      } else {
        try {
          final XFile? pickedFile =
              await _picker.pickImage(source: ImageSource.gallery);

          if (pickedFile != null) {
            String fileName = path.basename(pickedFile.path);
            // String fileName = pickedFile.path;
            debugPrint("File Name : $fileName");
            debugPrint("File Path : ${pickedFile.path}");

            if (event.field == 'vehicle_image') {
              emit(ImagePickedState(pickedFile.path,fileName, field: 'vehicle_image'));
            } else if (event.field == 'rc_image') {
              emit(ImagePickedState(pickedFile.path,fileName, field: 'rc_image'));
            } else if (event.field == 'chassis_number') {
              emit(ImagePickedState(pickedFile.path,fileName, field: 'chassis_number'));
            } else {
              emit(ImagePickedState("", "", field: ""));
            }
          } else {
            emit(ImagePickedState("", "", field: ""));
          }
        } catch (e) {
          print("Error picking image: $e");
        }
      }
    });
  }
}
