import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_mitra/bloc/cubit/profile_cubit/profile_cubit.dart';
import 'package:service_mitra/bloc/cubit/profile_cubit/profile_state.dart';
import 'package:service_mitra/bloc/cubit/profile_image_bloc/profile_bloc.dart';
import 'package:service_mitra/bloc/cubit/profile_image_bloc/profile_event.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/utlis/sizes.dart';
import 'package:service_mitra/views/widegts/custom_appbar.dart';
import 'package:service_mitra/views/widegts/custom_elevated_button.dart';
import 'package:service_mitra/views/widegts/custom_textformfield3.dart';
import 'package:service_mitra/views/widegts/inter_text.dart';

import '../../../../bloc/cubit/profile_image_bloc/profile_state.dart';
import '../../../../config/images/app_images.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().fetchProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    final profileCubit = BlocProvider.of<ProfileCubit>(context);
    String imageUrl = "";
    return Scaffold(
      backgroundColor: AppColors.textformfieldcol,
      appBar: const CustomAppBar(title: "Profile"),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            profileCubit.name.text = state.profileData["name"] ?? "";
            profileCubit.mobileNo.text =
                state.profileData["mobile_number"] ?? "";
            profileCubit.gstNo.text = state.profileData["gst_number"] ?? "";
            profileCubit.emailId.text = state.profileData["email"] ?? "";
            profileCubit.pinCode.text = state.profileData["pin_code"] ?? "";
            profileCubit.address.text = state.profileData["address"] ?? "";
            String stateName = state.profileData["state"] ?? "";
            String cityName = state.profileData["city"] ?? "";
            String tahsilName = state.profileData["tahsil"] ?? "";

            imageUrl = state.profileData["profile_pic"] ?? "";
            profileCubit.customerId.text =
                state.profileData["registration_no"] ?? "";

            profileCubit.stateName.text = stateName;
            profileCubit.cityName.text = cityName;
            profileCubit.tahsilName.text = tahsilName;
            if (profileCubit.gstNo.text == " ") {
              profileCubit.gstNo.clear();
            }

            // context.read<ProfileCubitDropdown>().selectState(stateName);
            // context.read<ProfileCubitDropdown>().selectCity(cityName);
            // context.read<ProfileCubitDropdown>().selectTahsil(tahsilName);
          } else if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile Updated Successfully")),
            );
            Navigator.pop(context);
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ProfileDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile Deleted Succesfully.")),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.login,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
              child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 50),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 32),
                  width: width,
                  decoration: BoxDecoration(
                      color: AppColors.whitecol,
                      borderRadius: BorderRadius.circular(22)),
                  child: Form(
                    key: profileCubit.formkey,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                BlocBuilder<ProfilePickBloc, ProfilePickState>(
                                    builder: (context, pickState) {
                                  // final String profilePic =
                                  //     imageUrl ?? AppImages.profileImage;
                                  return Container(
                                    decoration: const BoxDecoration(
                                        color: AppColors.colorange,
                                        shape: BoxShape.circle),
                                    child: Container(
                                      padding: const EdgeInsets.all(1),
                                      height: 102,
                                      width: 102,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: AppColors.whitecol,
                                              width: 2)),
                                      child: (pickState
                                              is ProfileImageUpdatedState)
                                          ? ClipOval(
                                              child: Image.file(
                                                pickState.profileImage,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : (imageUrl != null)
                                              ? ClipOval(
                                                  child: Image.network(
                                                    imageUrl ??
                                                        AppImages.profileImage,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Image.asset(AppImages
                                                            .profileImage),
                                                  ),
                                                )
                                              : Image.asset(
                                                  AppImages.profileImage),

                                      //  (imageUrl.isEmpty)
                                      //     ? Image.asset(
                                      //         AppImages.profileImage,
                                      //         fit: BoxFit.cover,
                                      //       )
                                      //     : ClipOval(
                                      //         child: Image.network(
                                      //           imageUrl,
                                      //           fit: BoxFit.cover,
                                      //         ),
                                      //       ),
                                    ),
                                  );
                                }),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () async {
                                      _showImageSourceDialog(context);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: const BoxDecoration(
                                        color: AppColors.colorange,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.edit,
                                        color: AppColors.whitecol,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InterText(
                              height: 0,
                              text: profileCubit.name.text,
                              fontsize: 20,
                              fontweight: FontWeight.w600,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            // const InterText(
                            //   height: 0,
                            //   text: "Edit Profile",
                            //   fontsize: 16,
                            //   fontweight: FontWeight.w600,
                            //   color: AppColors.colorange,
                            // )
                          ],
                        ),
                        const SizedBox(
                          height: 23,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("  Customer ID",
                                style: TextStyle(
                                    color: AppColors.lightblackcol,
                                    fontFamily: 'inter',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 15, top: 5),
                              child: CustomTextFormField3(
                                  controller: profileCubit.customerId,
                                  // validator: profileCubit.nameValidator,
                                  readonly: true,
                                  hintText: "",
                                  fillColor: Colors.grey.shade200,
                                  keyboardType: TextInputType.text),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: CustomTextFormField3(
                                  controller: profileCubit.name,
                                  validator: profileCubit.nameValidator,
                                  readonly: false,
                                  hintText: "Name",
                                  keyboardType: TextInputType.text),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: CustomTextFormField3(
                                  controller: profileCubit.mobileNo,
                                  validator: profileCubit.mobileNoValidator,
                                  countertext: "",
                                  maxLength: 10,
                                  readonly: false,
                                  hintText: "Mobile No.",
                                  keyboardType: TextInputType.number),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: CustomTextFormField3(
                                  controller: profileCubit.gstNo,
                                  // validator: profileCubit.gstNoValidator,
                                  countertext: "",
                                  maxLength: 15,
                                  readonly: false,
                                  hintText: "GST No.",
                                  keyboardType: TextInputType.text),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: CustomTextFormField3(
                                  validator: profileCubit.emailValidator,
                                  controller: profileCubit.emailId,
                                  countertext: "",
                                  readonly: false,
                                  hintText: "Email Id.",
                                  keyboardType: TextInputType.emailAddress),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: CustomTextFormField3(
                                  controller: profileCubit.stateName,
                                  validator: profileCubit.stateNameValidator,
                                  countertext: "",
                                  readonly: false,
                                  hintText: "State",
                                  keyboardType: TextInputType.text),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(bottom: 15),
                            //   child: BlocBuilder<ProfileCubitDropdown, ProfileDropdownState>(
                            //     builder: (context, selectedState) {

                            //       return CustomDropDown(
                            //         validator: profileCubit.stateValidator,
                            //         text: "State",
                            //         items: ["Rajasthan", "Karnataka", "Gujarat"],
                            //         selectedItem: selectedState.state,
                            //         onItemSelected: (value) {
                            //           profileCubit.stateName = value;
                            //           context
                            //               .read<ProfileCubitDropdown>()
                            //               .selectState(value);
                            //         },
                            //       );
                            //     },
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: CustomTextFormField3(
                                  controller: profileCubit.pinCode,
                                  validator: profileCubit.pincodeValidator,
                                  maxLength: 6,
                                  countertext: "",
                                  readonly: false,
                                  hintText: "Pincode",
                                  keyboardType: TextInputType.number),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(bottom: 15),
                            //   child: BlocBuilder<ProfileCubitDropdown, ProfileDropdownState>(
                            //     builder: (context, selectedCity) {
                            //       debugPrint("City Name in builder : ${selectedCity}");
                            //       debugPrint("City Name in builder : ${selectedCity.city}");
                            //       return CustomDropDown(
                            //         validator: profileCubit.cityValidator,
                            //         text: "City",
                            //         items: ["Jaipur", "Kota", "Churu"],
                            //         selectedItem: selectedCity.city,
                            //         onItemSelected: (value) {
                            //           profileCubit.cityName = value;
                            //           context
                            //               .read<ProfileCubitDropdown>()
                            //               .selectCity(value);
                            //         },
                            //       );
                            //     },
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: CustomTextFormField3(
                                  controller: profileCubit.cityName,
                                  validator: profileCubit.cityNameValidator,
                                  countertext: "",
                                  readonly: false,
                                  hintText: "City",
                                  keyboardType: TextInputType.text),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: CustomTextFormField3(
                                  controller: profileCubit.tahsilName,
                                  validator: profileCubit.tehsilNameValidator,
                                  countertext: "",
                                  readonly: false,
                                  hintText: "Tahsil",
                                  keyboardType: TextInputType.text),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(bottom: 15),
                            //   child: BlocBuilder<ProfileCubitDropdown, ProfileDropdownState>(
                            //     builder: (context, selectedTahsil) {
                            //       return CustomDropDown(
                            //         validator: profileCubit.tahsilValidator,
                            //         text: "Tahsil",
                            //         items: ["Nagal", "Khora", "Benar"],
                            //         selectedItem: selectedTahsil.tahsil,
                            //         onItemSelected: (value) {
                            //           profileCubit.tahsilName = value;
                            //           context
                            //               .read<ProfileCubitDropdown>()
                            //               .selectTahsil(value);
                            //         },
                            //       );
                            //     },
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: CustomTextFormField3(
                                  controller: profileCubit.address,
                                  maxLines: 4,
                                  readonly: false,
                                  hintText: "Address",
                                  keyboardType: TextInputType.text),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: CustomElevatedButton(
                      onpressed: () {
                        final profilePic = (context
                                .read<ProfilePickBloc>()
                                .state is ProfileImageUpdatedState)
                            ? (context.read<ProfilePickBloc>().state
                                    as ProfileImageUpdatedState)
                                .profileImage
                                .path
                            : null;
                        if (profileCubit.formkey.currentState!.validate()) {
                          context.read<ProfileCubit>().updateProfile(context, {
                            "name": profileCubit.name.text,
                            "mobile_number": profileCubit.mobileNo.text,
                            // "email": profileCubit.emailId.text,
                            "gst_number": (profileCubit.gstNo.text.isEmpty)
                                ? " "
                                : profileCubit.gstNo.text,
                            "pin_code": profileCubit.pinCode.text,
                            "address": profileCubit.address.text,
                            "state": profileCubit.stateName.text,
                            "city": profileCubit.cityName.text,
                            "tahsil": profileCubit.tahsilName.text,
                            "profile_pic": profilePic ?? "",
                          });
                        }
                      },
                      text: "Update Profile"),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Delete Account",
                                  style: TextStyle(
                                      color: AppColors.colblack,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Are you sure you want to delete account?",
                                  style: TextStyle(
                                      color: AppColors.colblack, fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: CustomElevatedButton(
                                      text: "Delete",
                                      height: 40,
                                      onpressed: () {
                                        Navigator.pop(context);
                                        context
                                            .read<ProfileCubit>()
                                            .deleteAccount(context);
                                      },
                                    )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: CustomElevatedButton(
                                      text: "Cancel",
                                      height: 40,
                                      onpressed: () {
                                        Navigator.pop(context);
                                      },
                                    ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: InterText(
                      text: "Delete Account",
                      color: AppColors.colred,
                      fontsize: 16,
                      fontweight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ));
        },
      ),
    );
  }
}

void _showImageSourceDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                context
                    .read<ProfilePickBloc>()
                    .add(PickImageEvent(fromCamera: true));
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                context
                    .read<ProfilePickBloc>()
                    .add(PickImageEvent(fromCamera: false));
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      );
    },
  );
}
