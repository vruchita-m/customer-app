import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:service_mitra/bloc/cubit/login_mpin_cubit/login_mpin_cubit.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/images/app_images.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/utlis/space.dart';
import 'package:service_mitra/views/widegts/cabin_text.dart';
import 'package:service_mitra/views/widegts/custom_elevated_button.dart';

import '../../../config/components/loading_widget.dart';
import '../../widegts/inter_text.dart';

class LoginMpinScreen extends StatefulWidget {
  const LoginMpinScreen({super.key});

  @override
  State<LoginMpinScreen> createState() => _LoginMpinScreenState();
}

class _LoginMpinScreenState extends State<LoginMpinScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.primarycol,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.44),
                    child: Image.asset(
                      AppImages.mpinImageP,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.width * 0.13,
                    left: 5,
                    right: 5,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          CabinText(
                            text:
                                "Always with you for maintenance and\nquality in the",
                            height: 0,
                            fontsize: 16,
                            fontweight: FontWeight.w700,
                            textalign: TextAlign.center,
                            color: AppColors.primarycol2,
                          ),
                          spaceVertical(
                              MediaQuery.of(context).size.width * 0.02),
                          CabinText(
                            height: 0,
                            text: "CHANGING TIMES OF THE WORLD",
                            fontsize: 22,
                            fontweight: FontWeight.w700,
                            color: AppColors.whitecol,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // const Spacer(),
                  BlocBuilder<MpinCubit, MpinState>(
                    builder: (context, state) {
                      final cubit = context.read<MpinCubit>();
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.55,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColors.whitecol,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  spaceVertical(
                                      MediaQuery.of(context).size.width * 0.08),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: InterText(
                                      text: "Login Using MPIN",
                                      fontsize: 35,
                                      fontweight: FontWeight.w700,
                                      color: AppColors.primarycol,
                                    ),
                                  ),
                                  spaceVertical(
                                      MediaQuery.of(context).size.width * 0.02),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: InterText(
                                      text: "Enter MPIN",
                                      fontsize: 18,
                                      fontweight: FontWeight.w400,
                                      color: AppColors.lightblackcol
                                          .withOpacity(0.8),
                                    ),
                                  ),
                                  spaceVertical(
                                      MediaQuery.of(context).size.width * 0.08),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Pinput(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      controller: state.controller,
                                      onChanged: (value) {
                                        cubit.onMpinChanged(value);
                                      },
                                      onCompleted: (value) => cubit.validate(),
                                      separatorBuilder: (_) =>
                                          const SizedBox(width: 20),
                                      focusedPinTheme: PinTheme(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'poppins',
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.lightblackcol
                                              .withOpacity(0.8),
                                        ),
                                        height: 66,
                                        width: 66,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color:
                                                  AppColors.textformfieldcol),
                                          color: AppColors.whitecol,
                                        ),
                                      ),
                                      defaultPinTheme: PinTheme(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'poppins',
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.lightblackcol
                                              .withOpacity(0.8),
                                        ),
                                        height: 66,
                                        width: 66,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: AppColors.whitecol),
                                          color: AppColors.textformfieldcol,
                                        ),
                                      ),
                                    ),
                                  ),
                                  spaceVertical(
                                      MediaQuery.of(context).size.width * 0.02),
                                  if (!state.isValid &&
                                      state.controller.text.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        "MPIN must be 4 digits",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  spaceVertical(
                                      MediaQuery.of(context).size.width * 0.08),
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.pushNamed(context, RoutesName.forgotMpin);
                                      cubit.requestMpinOTP(context);
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                                          child: InterText(
                                            text: 'Forgot MPIN?',
                                            fontsize: 14,
                                            fontweight: FontWeight.w600,
                                            color: AppColors.primarycol2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  spaceVertical(
                                      MediaQuery.of(context).size.width * 0.08),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: CustomElevatedButton(
                                      text: "Submit",
                                      onpressed: () {
                                        cubit.validate();

                                        if (state.isValid &&
                                            state.mpin.isNotEmpty) {
                                          cubit.submitMpin(context);
                                          
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor: AppColors.colred,
                                              content: Text(
                                                  "MPIN must be 4 digit."),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (state.isloading)
                              Positioned.fill(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ModalBarrier(
                                          color: Colors.black.withOpacity(0),
                                          dismissible: false,
                                        ),
                                        Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          alignment: Alignment.center,
                                          child: const LoadingWidget(
                                            size: 42,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
