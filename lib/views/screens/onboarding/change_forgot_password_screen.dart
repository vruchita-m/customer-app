import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_mitra/bloc/cubit/forgot_password_cubit/change_forgot_password_cubit.dart';
import 'package:service_mitra/bloc/cubit/forgot_password_cubit/forgot_cubit.dart';
import 'package:service_mitra/bloc/password_visibility_event.dart';
import 'package:service_mitra/bloc/password_visibility_state.dart';
import 'package:service_mitra/bloc/password_visiblity_bloc.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/components/loading_widget.dart';
import 'package:service_mitra/config/data/repository/auth/change_forgot_password_repositry.dart';
import 'package:service_mitra/config/data/repository/auth/forgot_repositry.dart';
import 'package:service_mitra/config/images/app_images.dart';
import 'package:service_mitra/config/routes/routes_name.dart';
import 'package:service_mitra/utlis/sizes.dart';
import 'package:service_mitra/utlis/space.dart';
import 'package:service_mitra/views/widegts/custom_elevated_button.dart';
import 'package:service_mitra/views/widegts/custom_textformfield.dart';
import 'package:service_mitra/views/widegts/custom_textformfield3.dart';
import 'package:service_mitra/views/widegts/inter_text.dart';

class ChangeForgotPasswordScreen extends StatefulWidget {
  final Map<String, dynamic>? arguments;
  const ChangeForgotPasswordScreen({super.key, required this.arguments});

  @override
  State<ChangeForgotPasswordScreen> createState() => _ChangeForgotPasswordScreenState();
}

class _ChangeForgotPasswordScreenState extends State<ChangeForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String email = widget.arguments?['email'] ?? "N/A";

    return BlocProvider(
      create: (context) => ChangeForgotPasswordCubit(ChangeForgotPasswordRepositry()),
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
                        child: BlocBuilder<ChangeForgotPasswordCubit, ChangeForgotPasswordState>(
                          builder: (context, state) {
                            final cubit = context.read<ChangeForgotPasswordCubit>();
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
                                        text: 'Reset Password',
                                        fontsize: 35,
                                        fontweight: FontWeight.w700,
                                        color: AppColors.primarycol,
                                      ),
                                      spaceVertical(width * 0.012),
                                      const InterText(
                                        text: "Enter your new password",
                                        fontsize: 18,
                                        fontweight: FontWeight.w400,
                                        color: AppColors.lightblackcol,
                                      ),
                                      spaceVertical(width * 0.1),
                                      BlocBuilder<PasswordVisibilityBloc, PasswordVisibilityState>(builder: (context, state) {
                                        return Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            CustomTextFormField(
                                              controller: passwordController,
                                              hintText: 'Password',
                                              maxLines: 1,
                                              obscureText: !state.isPasswordVisible,
                                              keyboardType: TextInputType.visiblePassword,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Password is required';
                                                }
                                                if (value.length < 8) {
                                                  return 'Password must contain at least 8 characters';
                                                }
                                                return null;
                                              },
                                              // errorText: state.passwordError, // show password error
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                context.read<PasswordVisibilityBloc>().add(TogglePasswordVisibilityEvent());
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 18.0, right: 20),
                                                child: Icon(
                                                  state.isPasswordVisible
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: AppColors.colblack,
                                                  size: 20,),
                                              ),
                                            )
                                          ],
                                        );
                                      },),
                                      spaceVertical(width * 0.05),
                                      BlocBuilder<PasswordVisibilityBloc, PasswordVisibilityState>(builder: (context, state) {
                                        return Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            CustomTextFormField(
                                              controller: confirmPasswordController,
                                              hintText: 'Confirm Password',
                                              maxLines: 1,
                                              obscureText: !state.isConfirmPasswordVisible,
                                              keyboardType: TextInputType.visiblePassword,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Password is required';
                                                }
                                                if (value.length < 8) {
                                                  return 'Password must contain at least 8 characters';
                                                }
                                                if (value != passwordController.text) {
                                                  return 'Confirm password and password must match';
                                                }
                                                return null;
                                              },
                                              // errorText: state.passwordError, // show password error
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                context.read<PasswordVisibilityBloc>().add(ToggleConfirmPasswordVisibilityEvent());
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 18.0, right: 20),
                                                child: Icon(
                                                  state.isConfirmPasswordVisible
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: AppColors.colblack,
                                                  size: 20,),
                                              ),
                                            )
                                          ],
                                        );
                                      },),
                                      spaceVertical(width * 0.05),
                                      CustomElevatedButton(
                                        text: 'Reset Password',
                                        onpressed: () {
                                          if(_formKey.currentState!.validate()){
                                            cubit.validate(passwordController.text, confirmPasswordController.text);
                                            if(state.isValid){
                                              cubit.changePassword(context, email, passwordController.text, confirmPasswordController.text);
                                            }
                                          }
                                          // cubit.validate(passwordController.text, confirmPasswordController.text);

                                          // debugPrint("state.isValid : ${state.isValid}");
                                          // debugPrint("state.isValid : ${email}");
                                          // debugPrint("state.isValid : ${passwordController.text}");
                                          // debugPrint("state.isValid : ${confirmPasswordController.text}");

                                          // if (state.isValid) {
                                            
                                          // } else {
                                          //   ScaffoldMessenger.of(context).showSnackBar(
                                          //     const SnackBar(
                                          //       backgroundColor: AppColors.colred,
                                          //       content: Text("Please enter valid password"),
                                          //     ),
                                          //   );
                                          // }
                                        },
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