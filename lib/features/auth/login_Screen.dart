import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gold_caurd_app/core/styling/app_colors.dart';
import 'package:gold_caurd_app/core/widgets/custom_text_field.dart';
import 'package:gold_caurd_app/core/widgets/spacing_widgets.dart';
import 'package:gold_caurd_app/firebase/firebase_function.dart';

import '../../core/routing/app_routes.dart';
import '../../core/widgets/primay_button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HeightSpace(80),

                  Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 3,
                      ),
                    ),
                    child: Icon(
                      Icons.security,
                      size: 50.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  HeightSpace(30),

                  Text(
                    "GOLD GUARD",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 38.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  HeightSpace(10),
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  HeightSpace(50),

                  CustomTextField(
                    controller: emailController,
                    hintText: "Email or Phone Number",
                    width: double.infinity,
                    height: 74.h,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email or phone';
                      }
                      return null;
                    },
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(15.w),
                      child: Icon(
                        Icons.person_outline,
                        size: 24.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  HeightSpace(20),

                  CustomTextField(
                    controller: passwordController,
                    hintText: "Password",
                    width: double.infinity,
                    height: 74.h,
                    isPassword: !isPasswordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(15.w),
                      child: Icon(
                        Icons.lock_outline,
                        size: 24.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.primaryColor,
                        size: 24.sp,
                      ),
                    ),
                  ),
                  HeightSpace(15),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  HeightSpace(30),
                  // Login Button
                  PrimayButtonWidget(
                    buttonText: "Login",
                    onPress: () {
                      if (formKey.currentState!.validate()) {
                        FirebaseFunction.login(
                          email: emailController.text,
                          password: passwordController.text,
                          onSuccess: () {
                            context.go(AppRoutes.mainScreen);
                          },
                          onError: (error) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text(error),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                  HeightSpace(40),

                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.secondaryColor.withOpacity(0.3),
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColors.secondaryColor.withOpacity(0.3),
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  HeightSpace(30),

                  InkWell(
                    onTap: () {
                      GoRouter.of(context).pushNamed(AppRoutes.registerScreen);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: "Register Now",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  HeightSpace(30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
