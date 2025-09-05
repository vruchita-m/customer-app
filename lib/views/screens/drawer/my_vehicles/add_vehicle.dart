import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/add_vehicle_cubit.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/emission_norms_cubit.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/emission_norms_state.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/fuel_type_cubit.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/fuel_type_state.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/tyres_cubit.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/tyres_state.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/vehicle_make_cubit.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/vehicle_category_cubit.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/vehicle_category_state.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/vehicle_make_state.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/vehicle_modal_cubit.dart';
import 'package:service_mitra/bloc/cubit/add_vehicle_cubit/vehicle_modal_state.dart';
import 'package:service_mitra/bloc/image_picker_bloc/image_picker_event.dart';
import 'package:service_mitra/bloc/image_picker_bloc/image_picker_state.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/data/model/vehicles/my_vehicles_model.dart';
import 'package:service_mitra/config/data/repository/vehicle/my_vehicle_repositry.dart';
import 'package:service_mitra/config/images/app_images.dart';
import 'package:service_mitra/utlis/sizes.dart';
import 'package:service_mitra/views/widegts/custom_appbar.dart';
import 'package:service_mitra/views/widegts/custom_dropdown.dart';
import 'package:service_mitra/views/widegts/custom_elevated_button.dart';
import 'package:service_mitra/views/widegts/custom_textformfield2.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../bloc/cubit/dropdowncubit/add_vehicle_cubit_dropdown.dart';
import '../../../../bloc/image_picker_bloc/image_picker_bloc.dart';

class AddVehicle extends StatefulWidget {
  final Map<String, dynamic> arguments;
  const AddVehicle({super.key, required this.arguments});

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  List<String> yearAr = [],
      makeAr = [],
      emissionNormsAr = [],
      fuelTypeAr = [],
      vehicleCategoryAr = [],
      vehicleModalAr = [],
      tyresAr = [];
  MyVehiclesResults? vehicleData;
  String type = "";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddVehicleCubit>(context).resetState();
    int currentYear = DateTime.now().year;
    yearAr = [
      for (int year = 2000; year <= currentYear; year++) year.toString()
    ];

    type = widget.arguments["type"];
    if (widget.arguments["type"] == "Edit") {
      vehicleData = widget.arguments["vehicle"];
    }
  }

  @override
  Widget build(BuildContext context) {
    final addVehicleCubit = BlocProvider.of<AddVehicleCubit>(context);
    if (type == "Edit") {
      addVehicleCubit.vehicleNo.text = vehicleData?.vehicleNumber ?? "";
      addVehicleCubit.chessisNo.text = vehicleData?.chassisNumber ?? "";
      addVehicleCubit.vehicleImage.text = vehicleData?.vehiclePic ?? "";
      addVehicleCubit.rcNo.text = vehicleData?.rcNumber ?? "";
      addVehicleCubit.kmReading.text = vehicleData?.kmReading ?? "";
      addVehicleCubit.make = vehicleData?.make ?? "";

      Timer(
        const Duration(seconds: 1),
        () {
          context
              .read<VehicleCubitDropdown>()
              .selectMake(vehicleData?.make ?? "TATA");
          context
              .read<VehicleCubitDropdown>()
              .selectEmission(vehicleData?.emissionNorm ?? "");
          context
              .read<VehicleCubitDropdown>()
              .selectFuel(vehicleData?.fuelType ?? "");
          context
              .read<VehicleCubitDropdown>()
              .selectCategory(vehicleData?.category ?? "");
          context
              .read<VehicleCubitDropdown>()
              .selectModal(vehicleData?.model ?? "");
          context
              .read<VehicleCubitDropdown>()
              .selectYear(vehicleData?.year.toString() ?? "");
          context
              .read<VehicleCubitDropdown>()
              .selectTyres(vehicleData?.numberOfTyres.toString() ?? "");
        },
      );
    }
    return Scaffold(
      backgroundColor: AppColors.textformfieldcol,
      appBar: CustomAppBar(
          title: (type == "Edit") ? "Edit Vehicle" : "Add Vehicle"),
      body: PopScope(
        onPopInvoked: (didPop) {
          addVehicleCubit.resetState();
          BlocProvider.of<AddVehicleBloc>(context).add(PickImageEvent(''));
           context.read<VehicleCubitDropdown>().selectMake("");
           context.read<VehicleCubitDropdown>().selectEmission("");
           context.read<VehicleCubitDropdown>().selectFuel("");
           context.read<VehicleCubitDropdown>().selectCategory("");
           context.read<VehicleCubitDropdown>().selectModal("");
           context.read<VehicleCubitDropdown>().selectYear("");
           context.read<VehicleCubitDropdown>().selectTyres("");
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 37),
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 40),
                decoration: BoxDecoration(
                    color: AppColors.whitecol,
                    borderRadius: BorderRadius.circular(22)),
                child: Form(
                  key: addVehicleCubit.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: CustomTextFormField2(
                            controller: addVehicleCubit.vehicleNo,
                            validator: addVehicleCubit.vehicleNoValidator,
                            readonly: false,
                            maxLines: 1,
                            hintText: "Vehicle No.",
                            startext: "*",
                            capChars: true,
                            keyboardType: TextInputType.text),
                      ),
                      BlocBuilder<AddVehicleBloc, AddVehicleState>(
                        builder: (context, state) {
                          if (state is ImagePickedState) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              debugPrint("state.field : ${state.field}");
                              if (state.field == 'chassis_number') {
                                addVehicleCubit.chessisNo.text =
                                    state.imageName;
                                addVehicleCubit.chassisFilePath =
                                    state.imagePath;
                              } else if (state.field == 'vehicle_image') {
                                addVehicleCubit.vehicleImage.text =
                                    state.imageName;
                                addVehicleCubit.vehicleFilePath =
                                    state.imagePath;
                              } else if (state.field == 'rc_image') {
                                addVehicleCubit.rcNo.text = state.imageName;
                                addVehicleCubit.rcFilePath = state.imagePath;
                              }
                            });
                          }

                          return Column(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  BlocProvider.of<AddVehicleBloc>(context)
                                      .add(PickImageEvent('chassis_number'));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: IgnorePointer(
                                    child: CustomTextFormField2(
                                      validator:
                                          addVehicleCubit.chessisNoValidator,
                                      controller: addVehicleCubit.chessisNo,
                                      readonly: true,
                                      SuffixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: SvgPicture.asset(
                                            AppImages.uploadImage),
                                      ),
                                      maxLines: 1,
                                      hintText: "Chassis Number",
                                      startext: "*",
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    BlocProvider.of<AddVehicleBloc>(context)
                                        .add(PickImageEvent('vehicle_image'));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: IgnorePointer(
                                      child: CustomTextFormField2(
                                        validator: addVehicleCubit
                                            .vehicleImageValidator,
                                        controller:
                                            addVehicleCubit.vehicleImage,
                                        readonly: true,
                                        SuffixIcon: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: SvgPicture.asset(
                                              AppImages.uploadImage),
                                        ),
                                        maxLines: 1,
                                        hintText: "Vehicle Image",
                                        startext: "*",
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    BlocProvider.of<AddVehicleBloc>(context)
                                        .add(PickImageEvent('rc_image'));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: IgnorePointer(
                                      child: CustomTextFormField2(
                                        validator:
                                            addVehicleCubit.rcNoValidator,
                                        controller: addVehicleCubit.rcNo,
                                        readonly: true,
                                        SuffixIcon: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: SvgPicture.asset(
                                              AppImages.uploadImage),
                                        ),
                                        maxLines: 1,
                                        hintText: "RC",
                                        startext: "*",
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      BlocProvider(
                        create: (context) =>
                            VehicleMakeCubit(MyVehicleRepositry())
                              ..fetchVehicleMake(context),
                        child: BlocBuilder<VehicleMakeCubit, VehiclesMakeState>(
                          builder: (context, state) {
                            if (state is VehiclesMakeLoading) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 15, left: 5, right: 5),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height: 56,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(45),
                                    ),
                                  ),
                                ),
                              );
                            } else if (state is VehiclesMakeLoaded) {
                              makeAr = [];
                              for (var element in state.vehicleMakes) {
                                makeAr.add(element.name ?? "");
                              }
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child:
                                    BlocBuilder<VehicleCubitDropdown, String?>(
                                  builder: (context, selectedMake) {
                                    return CustomDropDown(
                                      validator: addVehicleCubit.makeValidator,
                                      text: "Make",
                                      startext: "*",
                                      preSelectedItem: vehicleData?.make,
                                      items: makeAr,
                                      selectedItem: selectedMake,
                                      onItemSelected: (value) {
                                        context
                                            .read<VehicleCubitDropdown>()
                                            .selectMake(value);
                                      },
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Text("");
                            }
                          },
                        ),
                      ),
                      BlocProvider(
                        create: (context) =>
                            EmissionNormsCubit(MyVehicleRepositry())
                              ..fetchEmissionNorms(context),
                        child:
                            BlocBuilder<EmissionNormsCubit, EmissionNormsState>(
                          builder: (context, state) {
                            if (state is EmissionNormsLoading) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 15, left: 5, right: 5),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height: 56,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(45),
                                    ),
                                  ),
                                ),
                              );
                            } else if (state is EmissionNormsLoaded) {
                              emissionNormsAr = [];
                              for (var element in state.emissionNorms) {
                                emissionNormsAr.add(element.name ?? "");
                              }
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child:
                                    BlocBuilder<VehicleCubitDropdown, String?>(
                                  builder: (context, selectedEmission) {
                                    return CustomDropDown(
                                      validator:
                                          addVehicleCubit.emissionValidator,
                                      text: "Emission Norm",
                                      preSelectedItem:
                                          vehicleData?.emissionNorm,
                                      startext: "*",
                                      items: emissionNormsAr,
                                      selectedItem: selectedEmission,
                                      onItemSelected: (value) {
                                        context
                                            .read<VehicleCubitDropdown>()
                                            .selectEmission(value);
                                      },
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Text("");
                            }
                          },
                        ),
                      ),
                      BlocProvider(
                        create: (context) => FuelTypeCubit(MyVehicleRepositry())
                          ..fetchFuelType(context),
                        child: BlocBuilder<FuelTypeCubit, FuelTypeState>(
                          builder: (context, state) {
                            if (state is FuelTypeLoading) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 15, left: 5, right: 5),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height: 56,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(45),
                                    ),
                                  ),
                                ),
                              );
                            } else if (state is FuelTypeLoaded) {
                              fuelTypeAr = [];
                              for (var element in state.FuelType) {
                                fuelTypeAr.add(element.name ?? "");
                              }
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child:
                                    BlocBuilder<VehicleCubitDropdown, String?>(
                                  builder: (context, selectedFuel) {
                                    return CustomDropDown(
                                      validator:
                                          addVehicleCubit.fuelTypeValidator,
                                      text: "Fuel Type",
                                      preSelectedItem: vehicleData?.fuelType,
                                      startext: "*",
                                      items: fuelTypeAr,
                                      selectedItem: selectedFuel,
                                      onItemSelected: (value) {
                                        context
                                            .read<VehicleCubitDropdown>()
                                            .selectFuel(value);
                                      },
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Text("");
                            }
                          },
                        ),
                      ),
                      BlocProvider(
                        create: (context) =>
                            VehicleCategoryCubit(MyVehicleRepositry())
                              ..fetchVehicleCategory(context),
                        child: BlocBuilder<VehicleCategoryCubit,
                            VehicleCategoryState>(
                          builder: (context, state) {
                            if (state is VehicleCategoryLoading) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 15, left: 5, right: 5),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height: 56,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(45),
                                    ),
                                  ),
                                ),
                              );
                            } else if (state is VehicleCategoryLoaded) {
                              vehicleCategoryAr = [];
                              for (var element in state.vehicleCategory) {
                                vehicleCategoryAr.add(element.name ?? "");
                              }
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child:
                                    BlocBuilder<VehicleCubitDropdown, String?>(
                                  builder: (context, selectedCategory) {
                                    return CustomDropDown(
                                      validator:
                                          addVehicleCubit.categoryValidator,
                                      text: "Category",
                                      startext: "*",
                                      items: vehicleCategoryAr,
                                      selectedItem: selectedCategory,
                                      preSelectedItem: vehicleData?.category,
                                      onItemSelected: (value) {
                                        context
                                            .read<VehicleCubitDropdown>()
                                            .selectCategory(value);
                                      },
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Text("");
                            }
                          },
                        ),
                      ),
                      BlocProvider(
                        create: (context) =>
                            VehicleModalCubit(MyVehicleRepositry())
                              ..fetchVehicleModal(context),
                        child:
                            BlocBuilder<VehicleModalCubit, VehicleModalState>(
                          builder: (context, state) {
                            if (state is VehicleModalLoading) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 15, left: 5, right: 5),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height: 56,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(45),
                                    ),
                                  ),
                                ),
                              );
                            } else if (state is VehicleModalLoaded) {
                              vehicleModalAr = [];
                              for (var element in state.vehicleModal) {
                                vehicleModalAr.add(element.name ?? "");
                              }
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child:
                                    BlocBuilder<VehicleCubitDropdown, String?>(
                                  builder: (context, selectedModal) {
                                    return CustomDropDown(
                                      validator: addVehicleCubit.modalValidator,
                                      text: "Modal",
                                      startext: "*",
                                      items: vehicleModalAr,
                                      selectedItem: selectedModal,
                                      preSelectedItem: vehicleData?.model,
                                      onItemSelected: (value) {
                                        context
                                            .read<VehicleCubitDropdown>()
                                            .selectModal(value);
                                      },
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Text("");
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: BlocBuilder<VehicleCubitDropdown, String?>(
                          builder: (context, selectedYear) {
                            return CustomDropDown(
                              validator: addVehicleCubit.yearValidator,
                              text: "Year",
                              preSelectedItem: vehicleData?.year.toString(),
                              startext: "*",
                              items: yearAr,
                              selectedItem: selectedYear,
                              onItemSelected: (value) {
                                context
                                    .read<VehicleCubitDropdown>()
                                    .selectYear(value);
                              },
                            );
                          },
                        ),
                      ),
                      BlocProvider(
                        create: (context) => TyresCubit(MyVehicleRepositry())
                          ..fetchTyres(context),
                        child: BlocBuilder<TyresCubit, TyresState>(
                          builder: (context, state) {
                            if (state is TyresLoading) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 15, left: 5, right: 5),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height: 56,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(45),
                                    ),
                                  ),
                                ),
                              );
                            } else if (state is TyresLoaded) {
                              tyresAr = [];
                              for (var element in state.tyres) {
                                tyresAr.add(element.name ?? "");
                              }
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child:
                                    BlocBuilder<VehicleCubitDropdown, String?>(
                                  builder: (context, selectedTyres) {
                                    return CustomDropDown(
                                      validator: addVehicleCubit.tyresValidator,
                                      text: "Number of Tyres",
                                      preSelectedItem:
                                          vehicleData?.numberOfTyres.toString(),
                                      startext: "*",
                                      items: tyresAr,
                                      selectedItem: selectedTyres,
                                      onItemSelected: (value) {
                                        context
                                            .read<VehicleCubitDropdown>()
                                            .selectTyres(value);
                                      },
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Text("");
                            }
                          },
                        ),
                      ),
                      BlocBuilder<VehicleCubitDropdown, String?>(
                        builder: (context, selectedKM) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: CustomTextFormField2(
                                controller: addVehicleCubit.kmReading,
                                validator: addVehicleCubit.vehicleKMValidator,
                                readonly: false,
                                maxLines: 1,
                                hintText: "KM Reading",
                                startext: "*",
                                keyboardType: TextInputType.number),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<AddVehicleCubit, VehicleAddState>(
                builder: (context, state) {
                  return state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 50),
                          child: CustomElevatedButton(
                            text: (type == "Edit")
                                ? "Edit Vehicle"
                                : "Add Vehicle",
                            onpressed: () {
                              if (type == "Edit") {
                                addVehicleCubit.editVehicle(
                                    context, vehicleData?.id ?? "");
                              } else {
                                addVehicleCubit.addVehicle(context);
                              }
                            },
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
