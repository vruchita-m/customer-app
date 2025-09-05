import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_mitra/bloc/cubit/my_vehicle_cubit/my_vehicle_cubit.dart';
import 'package:service_mitra/bloc/cubit/my_vehicle_cubit/my_vehicle_state.dart';
import 'package:service_mitra/config/data/repository/vehicle/my_vehicle_repositry.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/views/widegts/custom_appbar.dart';
import 'package:service_mitra/views/widegts/custom_elevated_button.dart';
import 'package:service_mitra/views/widegts/custom_my_vehicles_card.dart';
import 'package:service_mitra/views/widegts/inter_text.dart';

class MyVehicles extends StatefulWidget {
  const MyVehicles({super.key});

  @override
  State<MyVehicles> createState() => _MyVehiclesState();
}

class _MyVehiclesState extends State<MyVehicles> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _filteredVehicles = [];
  List<dynamic> _allVehicles = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MyVehiclesCubit(MyVehicleRepositry())..fetchVehicles(context),
      child: Scaffold(
        backgroundColor: AppColors.textformfieldcol,
        appBar: const CustomAppBar(
            title: "My Vehicles", automaticallyImplyLeading: true),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              TextFormField(
                controller: _searchController,
                onChanged: (query) {
                  _filterVehicles(query);
                },
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Search vehicle',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: AppColors.lightblackcol),
                  ),
                  fillColor: AppColors.whitecol,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlocBuilder<MyVehiclesCubit, MyVehiclesState>(
                  builder: (context, state) {
                    if (state is MyVehiclesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is MyVehiclesLoaded) {
                      if (_allVehicles.isEmpty) {
                        _allVehicles = state.vehicles; // Store original list
                        _filteredVehicles = _allVehicles; // Initially show all
                      }

                      if (_filteredVehicles.isEmpty) {
                        return const Center(
                          child: InterText(
                              text: "No Vehicles Found",
                              fontsize: 16,
                              color: AppColors.colblack),
                        );
                      }

                      return ListView.builder(
                        itemCount: _filteredVehicles.length,
                        itemBuilder: (context, index) {
                          final vehicle = _filteredVehicles[index];
                          return CustomMyVehiclesContainer(
                            image: vehicle.vehiclePic ?? "",
                            make: vehicle.make ?? "N/A",
                            vehiclename: vehicle.model ?? "N/A",
                            vehicleno: vehicle.vehicleNumber ?? "N/A",
                            rc: vehicle.rcNumber ?? "N/A",
                            fuelType: vehicle.fuelType ?? "N/A",
                            onClickTicket: () => Navigator.pushNamed(
                              context,
                              RoutesName.ticketstatus,
                              arguments: {"vehicle_id": vehicle.id},
                            ),
                            onViewTicket: () => Navigator.pushNamed(
                              context,
                              RoutesName.vehicledetails,
                              arguments: {"vehicle": vehicle},
                            ),
                          );
                        },
                      );
                    } else if (state is MyVehiclesError) {
                      return Center(child: Text(state.message));
                    }
                    return Container();
                  },
                ),
              ),
              CustomElevatedButton(
                onpressed: () {
                  Navigator.pushNamed(context, RoutesName.addvehicle,
                      arguments: {"type": "Add"});
                },
                text: "Add Vehicle",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _filterVehicles(String query) {
    setState(() {
      _filteredVehicles = _allVehicles.where((vehicle) {
        final q = query.toLowerCase();
        return (vehicle.model ?? "").toLowerCase().contains(q) ||
            (vehicle.vehicleNumber ?? "").toLowerCase().contains(q) ||
            (vehicle.make ?? "").toLowerCase().contains(q);
      }).toList();
    });
  }
}
