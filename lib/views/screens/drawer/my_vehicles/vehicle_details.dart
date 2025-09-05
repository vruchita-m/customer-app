import 'package:flutter/material.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/data/model/vehicles/my_vehicles_model.dart';
import 'package:service_mitra/config/data/repository/vehicle/my_vehicle_repositry.dart';
import 'package:service_mitra/config/images/app_images.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/utlis/sizes.dart';
import 'package:service_mitra/views/widegts/custom_appbar.dart';
import 'package:service_mitra/views/widegts/custom_elevated_button.dart';
import 'package:service_mitra/views/widegts/inter_text.dart';

class VehicleDetails extends StatefulWidget {
  final MyVehiclesResults vehicle;
  const VehicleDetails({super.key, required this.vehicle});

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textformfieldcol,
      appBar: const CustomAppBar(title: "Vehicle Details"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              padding: const EdgeInsets.only(bottom: 40),
              margin: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 40),
              decoration: BoxDecoration(
                  color: AppColors.whitecol,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width,
                    height: 250,
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 19),
                    margin: const EdgeInsets.only(
                        top: 18, left: 18, right: 18, bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.containerbgcol.withOpacity(0.3)),
                    child: ((widget.vehicle.vehiclePic ?? "").isNotEmpty) ? Image.network(widget.vehicle.vehiclePic ?? "", fit: BoxFit.scaleDown,) : Image.asset(
                      AppImages.truckImageBP,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 20, right: 20, bottom: 16),
                    child: InterText(
                      text: "Product information",
                      fontsize: 20,
                      fontweight: FontWeight.w600,
                    ),
                  ),
                  Table(
                    border: TableBorder(
                      bottom: BorderSide(
                        color: AppColors.lightblackcol.withOpacity(0.3),
                      ),
                    ),
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(color: AppColors.coltable),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: InterText(
                                text: "Vehicle No.",
                                fontsize: 14,
                                fontweight: FontWeight.w400,
                                color: AppColors.lightblackcol.withOpacity(0.8),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: InterText(
                                text: widget.vehicle.vehicleNumber,
                                fontsize: 14,
                                fontweight: FontWeight.w500,
                                color: AppColors.lightblackcol,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Table(
                    border: TableBorder(
                      bottom: BorderSide(
                        color: AppColors.lightblackcol.withOpacity(0.3),
                      ),
                    ),
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(color: AppColors.whitecol),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: InterText(
                                text: "Chassis No.",
                                fontsize: 14,
                                fontweight: FontWeight.w400,
                                color: AppColors.lightblackcol.withOpacity(0.8),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showImageDialog(context, widget.vehicle.chassisNumber ?? "");
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 14.0,
                                horizontal: 18,
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.remove_red_eye, color: AppColors.lightblackcol, size: 16,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Table(
                    border: TableBorder(
                      bottom: BorderSide(
                        color: AppColors.lightblackcol.withOpacity(0.3),
                      ),
                    ),
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(color: AppColors.coltable),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 8,
                              left: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: InterText(
                                text: "RC",
                                fontsize: 14,
                                fontweight: FontWeight.w400,
                                color: AppColors.lightblackcol.withOpacity(0.8),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showImageDialog(context, widget.vehicle.rcNumber ?? "");
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 8.0,
                                bottom: 8,
                                right: 18,
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.remove_red_eye, color: AppColors.lightblackcol, size: 16,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Table(
                    border: TableBorder(
                      bottom: BorderSide(
                        color: AppColors.lightblackcol.withOpacity(0.3),
                      ),
                    ),
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(color: AppColors.whitecol),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: InterText(
                                text: "Make",
                                fontsize: 14,
                                fontweight: FontWeight.w400,
                                color: AppColors.lightblackcol.withOpacity(0.8),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: InterText(
                                text: widget.vehicle.make,
                                fontsize: 14,
                                fontweight: FontWeight.w500,
                                color: AppColors.lightblackcol,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Table(
                    border: TableBorder(
                      bottom: BorderSide(
                        color: AppColors.lightblackcol.withOpacity(0.3),
                      ),
                    ),
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(color: AppColors.coltable),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: InterText(
                                text: "Emission Norm",
                                fontsize: 14,
                                fontweight: FontWeight.w400,
                                color: AppColors.lightblackcol.withOpacity(0.8),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: InterText(
                                text: widget.vehicle.emissionNorm,
                                fontsize: 14,
                                fontweight: FontWeight.w500,
                                color: AppColors.lightblackcol,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Table(
                    border: TableBorder(
                      bottom: BorderSide(
                        color: AppColors.lightblackcol.withOpacity(0.3),
                      ),
                    ),
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(color: AppColors.whitecol),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 14.0,
                              bottom: 14,
                              left: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: InterText(
                                text: "Fuel Type",
                                fontsize: 14,
                                fontweight: FontWeight.w400,
                                color: AppColors.lightblackcol.withOpacity(0.8),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 14.0,
                              bottom: 14,
                              right: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: InterText(
                                text: widget.vehicle.fuelType,
                                fontsize: 14,
                                fontweight: FontWeight.w500,
                                color: AppColors.lightblackcol,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Table(
                    border: TableBorder(
                      bottom: BorderSide(
                        color: AppColors.lightblackcol.withOpacity(0.3),
                      ),
                    ),
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(color: AppColors.coltable),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: InterText(
                                text: "Category",
                                fontsize: 14,
                                fontweight: FontWeight.w400,
                                color: AppColors.lightblackcol.withOpacity(0.8),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: InterText(
                                text: widget.vehicle.category,
                                fontsize: 14,
                                fontweight: FontWeight.w500,
                                color: AppColors.lightblackcol,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Table(
                    border: TableBorder(
                      bottom: BorderSide(
                        color: AppColors.lightblackcol.withOpacity(0.3),
                      ),
                    ),
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(color: AppColors.whitecol),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: InterText(
                                text: "Modal",
                                fontsize: 14,
                                fontweight: FontWeight.w400,
                                color: AppColors.lightblackcol.withOpacity(0.8),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: InterText(
                                text: widget.vehicle.model,
                                fontsize: 14,
                                fontweight: FontWeight.w500,
                                color: AppColors.lightblackcol,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Table(
                    border: TableBorder(
                      bottom: BorderSide(
                        color: AppColors.lightblackcol.withOpacity(0.3),
                      ),
                    ),
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(color: AppColors.coltable),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 8,
                              left: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: InterText(
                                text: "Year",
                                fontsize: 14,
                                fontweight: FontWeight.w400,
                                color: AppColors.lightblackcol.withOpacity(0.8),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 8,
                              right: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: InterText(
                                text: widget.vehicle.year.toString(),
                                fontsize: 14,
                                fontweight: FontWeight.w500,
                                color: AppColors.lightblackcol,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Table(
                    border: TableBorder(
                      bottom: BorderSide(
                        color: AppColors.lightblackcol.withOpacity(0.3),
                      ),
                    ),
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(color: AppColors.whitecol),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: InterText(
                                text: "Number of Tyres",
                                fontsize: 14,
                                fontweight: FontWeight.w400,
                                color: AppColors.lightblackcol.withOpacity(0.8),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: InterText(
                                text: widget.vehicle.numberOfTyres.toString(),
                                fontsize: 14,
                                fontweight: FontWeight.w500,
                                color: AppColors.lightblackcol,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Table(
                    border: TableBorder(
                      bottom: BorderSide(
                        color: AppColors.lightblackcol.withOpacity(0.3),
                      ),
                    ),
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(color: AppColors.coltable),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: InterText(
                                text: "KM Reading",
                                fontsize: 14,
                                fontweight: FontWeight.w400,
                                color: AppColors.lightblackcol.withOpacity(0.8),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.0,
                              horizontal: 18,
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: InterText(
                                text: widget.vehicle.kmReading,
                                fontsize: 14,
                                fontweight: FontWeight.w500,
                                color: AppColors.lightblackcol,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 45),
                  child: CustomElevatedButton(
                    text: "Request to edit",
                    onpressed: () {
                      Navigator.pushNamed(context, RoutesName.addvehicle, arguments: {"vehicle" : widget.vehicle,"type" : "Edit"});
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 45),
                  child: CustomElevatedButton(
                    text: "Delete Vehicle",
                    onpressed: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Delete Vehicle",
                                    style: TextStyle(color: AppColors.colblack, fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10,),
                                  const Text(
                                    "Are you sure you want to delete this vehicle?",
                                    style: TextStyle(color: AppColors.colblack, fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Expanded(child: CustomElevatedButton(text: "Delete", height: 40, onpressed: () {
                                        Navigator.pop(context);
                                        _deleteVehicle();
                                      },)),
                                      const SizedBox(width: 10,),
                                      Expanded(child: CustomElevatedButton(text: "Cancel", height: 40, onpressed: () {
                                        Navigator.pop(context);
                                      },))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showImageDialog(BuildContext context, String imageUrl) {
    if(imageUrl.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: const Icon(Icons.close, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  void _deleteVehicle() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    MyVehicleRepositry()
        .deleteVehicle(context: context, vehicleId: widget.vehicle.id ?? "")
        .then((value) {
      Navigator.pop(context); // Close loader
      if (value) {
         ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Vehicle Deleted succesfully.")),
          );
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushNamed(context, RoutesName.myvehicles);
      }
    }).catchError((error) {
      Navigator.pop(context); // Close loader if an error occurs
      // Handle error (show a snackbar or dialog)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to delete vehicle")),
      );
    });
  }
}
