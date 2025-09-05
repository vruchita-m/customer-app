import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_mitra/bloc/cubit/forgot_password_cubit/forgot_cubit.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/components/loading_widget.dart';
import 'package:service_mitra/config/data/repository/auth/forgot_repositry.dart';
import 'package:service_mitra/config/images/app_images.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/utlis/sizes.dart';
import 'package:service_mitra/utlis/space.dart';
import 'package:service_mitra/views/widegts/custom_elevated_button.dart';
import 'package:service_mitra/views/widegts/custom_textformfield.dart';
import 'package:service_mitra/views/widegts/inter_text.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotCubit(ForgotRepository()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImages.splashImageP),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                spaceVertical(width * 0.12),
                Image.asset(
                  AppImages.servicemitraLogoP,
                  height: 110,
                  width: 110,
                ),
                spaceVertical(width * 0.12),
                const Spacer(),
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                        width: width,
                        height: height * 0.696,
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: const BoxDecoration(
                            color: AppColors.whitecol,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: BlocConsumer<ForgotCubit, ForgotState>(
                          listener: (context, state) {
                            if (state.emailError != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (state.emailError != null)
                                        Text(state.emailError!,
                                            style:
                                                const TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                  backgroundColor: AppColors.colred,
                                ),
                              );
                            }

                            if (state.apiError != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.apiError!,
                                      style: const TextStyle(color: Colors.white)),
                                  backgroundColor: AppColors.colred,
                                ),
                              );
                            }

                            if (state.isSuccess) {
                              debugPrint("Forgot success, navigating to next screen");
                              context.read<ForgotCubit>().resetState();

                              Future.delayed(const Duration(milliseconds: 300),
                                  () {
                                    debugPrint("email sent : ${emailController.text}");
                                Navigator.pushNamed(context, RoutesName.forgotpasswordOTP, arguments: {'email' : emailController.text, 'from' : 'forgot'});
                              });
                            }
                          },
                          builder: (context, state) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      spaceVertical(width * 0.2),
                                      const InterText(
                                        text: 'Forgot Password',
                                        fontsize: 35,
                                        fontweight: FontWeight.w700,
                                        color: AppColors.primarycol,
                                      ),
                                      spaceVertical(width * 0.012),
                                      const InterText(
                                        text: "Enter your email to reset your password",
                                        fontsize: 18,
                                        fontweight: FontWeight.w400,
                                        color: AppColors.lightblackcol,
                                      ),
                                      spaceVertical(width * 0.1),
                                      CustomTextFormField(
                                        controller: emailController,
                                        hintText: 'Email',
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        // errorText: state.emailError, // show email error
                                      ),
                                      spaceVertical(width * 0.05),
                                      CustomElevatedButton(
                                        text: 'Forgot Password',
                                        onpressed: () {
                                          final forgotCubit =
                                              context.read<ForgotCubit>();
                                          final email = emailController.text;
                                          forgotCubit.resetState();

                                          forgotCubit.forgotPassword(
                                              context,
                                              email,);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                if (state.isLoading)
                                  // Container(
                                  //   height: 80,
                                  //   width: 80,
                                  //   decoration: BoxDecoration(
                                  //       color: Colors.blue.withOpacity(0.1),
                                  //       borderRadius:
                                  //           BorderRadius.circular(12)),
                                  //   alignment: Alignment.center,
                                  //   child: const LoadingWidget(
                                  //     size: 42,
                                  //   ),
                                  // ),
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
                            );
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: SvgPicture.asset(AppImages.truckImage),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}