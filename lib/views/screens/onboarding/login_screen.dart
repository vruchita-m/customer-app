import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:service_mitra/bloc/password_visibility_event.dart';
import 'package:service_mitra/bloc/password_visibility_state.dart';
import 'package:service_mitra/bloc/password_visiblity_bloc.dart';
import 'package:service_mitra/config/colors/colors.dart';
import 'package:service_mitra/config/images/app_images.dart';
import 'package:service_mitra/utlis/sizes.dart';
import 'package:service_mitra/utlis/space.dart';
import 'package:service_mitra/views/widegts/custom_elevated_button.dart';
import 'package:service_mitra/views/widegts/custom_textformfield.dart';
import 'package:service_mitra/views/widegts/custom_textformfield2.dart';
import 'package:service_mitra/views/widegts/inter_text.dart';
import '../../../bloc/cubit/login_cubit/login_cubit.dart';
import '../../../config/components/loading_widget.dart';
import '../../../config/data/repository/auth/login_repository.dart';
import '../../../config/routes/routes_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String firebaseToken = "";

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.instance.getToken().then(
      (value) {
        debugPrint("token : $value");
        firebaseToken = value ?? "";
      },
    );

    return BlocProvider(
      create: (_) => LoginCubit(LoginRepository()),
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
                        child: BlocConsumer<LoginCubit, LoginState>(
                          listener: (context, state) {
                            if (state.emailError != null ||
                                state.passwordError != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (state.emailError != null)
                                        Text(state.emailError!,
                                            style: const TextStyle(
                                                color: Colors.white)),
                                      if (state.passwordError != null)
                                        Text(state.passwordError!,
                                            style: const TextStyle(
                                                color: Colors.white)),
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
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  backgroundColor: AppColors.colred,
                                ),
                              );
                            }

                            if (state.isSuccess) {
                              debugPrint(
                                  "Login success, navigating to next screen");
                              context.read<LoginCubit>().resetState();

                              Future.delayed(const Duration(milliseconds: 300),
                                  () {
                                Navigator.pushReplacementNamed(
                                    context, RoutesName.homescreen);
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
                                        text: 'Login',
                                        fontsize: 35,
                                        fontweight: FontWeight.w700,
                                        color: AppColors.primarycol,
                                      ),
                                      spaceVertical(width * 0.012),
                                      const InterText(
                                        text: "Welcome back to Truk Mitra",
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
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Email is required.";
                                          } else if (!EmailValidator.validate(
                                              value)) {
                                            return "Please enter a valid email.";
                                          }
                                          return null;
                                        },
                                        // errorText: state.emailError, // show email error
                                      ),
                                      spaceVertical(width * 0.05),
                                      BlocBuilder<PasswordVisibilityBloc,
                                          PasswordVisibilityState>(
                                        builder: (context, state) {
                                          return Stack(
                                            alignment: Alignment.centerRight,
                                            children: [
                                              CustomTextFormField(
                                                controller: passwordController,
                                                hintText: 'Password',
                                                maxLines: 1,
                                                obscureText:
                                                    !state.isPasswordVisible,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Password is required';
                                                  }
                                                  if (value.length < 8) {
                                                    return 'Password should contain 8 characters';
                                                  }
                                                  return null;
                                                },
                                                SuffixIcon: GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            PasswordVisibilityBloc>()
                                                        .add(
                                                            TogglePasswordVisibilityEvent());
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 12.0,
                                                        horizontal: 20),
                                                    child: Icon(
                                                      state.isPasswordVisible
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                                      color: AppColors.colblack,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                // errorText: state.passwordError, // show password error
                                              ),
                                              // GestureDetector(
                                              //   onTap: () {
                                              //     context
                                              //         .read<
                                              //             PasswordVisibilityBloc>()
                                              //         .add(
                                              //             TogglePasswordVisibilityEvent());
                                              //   },
                                              //   child: Padding(
                                              //     padding: const EdgeInsets
                                              //         .symmetric(
                                              //         vertical: 12.0,
                                              //         horizontal: 20),
                                              //     child: Icon(
                                              //       state.isPasswordVisible
                                              //           ? Icons.visibility_off
                                              //           : Icons.visibility,
                                              //       color: AppColors.colblack,
                                              //       size: 20,
                                              //     ),
                                              //   ),
                                              // )
                                            ],
                                          );
                                        },
                                      ),
                                      spaceVertical(width * 0.045),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              RoutesName.forgotpassword);
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InterText(
                                              text: 'Forget Password?',
                                              fontsize: 14,
                                              fontweight: FontWeight.w600,
                                              color: AppColors.primarycol2,
                                            ),
                                          ],
                                        ),
                                      ),
                                      spaceVertical(width * 0.06),
                                      CustomElevatedButton(
                                        text: 'Login',
                                        onpressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            final loginCubit =
                                                context.read<LoginCubit>();
                                            final email = emailController.text;
                                            final password =
                                                passwordController.text;

                                            loginCubit.resetState();

                                            loginCubit.login(
                                                context,
                                                email,
                                                password,
                                                password,
                                                firebaseToken);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                // if (state.isLoading)
                                //   Container(
                                //     height: 80,
                                //     width: 80,
                                //     decoration: BoxDecoration(
                                //         color: Colors.blue.withOpacity(0.1),
                                //         borderRadius:
                                //             BorderRadius.circular(12)),
                                //     alignment: Alignment.center,
                                //     child: const LoadingWidget(
                                //       size: 42,
                                //     ),
                                //   ),

                                if (state.isLoading)
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
                                            borderRadius:
                                                BorderRadius.circular(12),
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
