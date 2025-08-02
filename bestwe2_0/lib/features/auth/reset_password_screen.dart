import 'package:bestwe2_0/app_State/app_State.dart';
import 'package:bestwe2_0/assets.dart';
import 'package:bestwe2_0/widgets/custom_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';


class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;
  final TextEditingController passwordController = TextEditingController();

  ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  //const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
    final appState = ApplicationState();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  bool isStrongPassword(String password) {
    // At least 6 chars, 1 uppercase, 1 lowercase, 1 digit, 1 special char
    return password.length >= 6 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[a-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password) &&
        RegExp(r'[!@#\$&*~_\-]').hasMatch(password);
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDABEB6),
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(17, 12, 46, 0.15),
                          blurRadius: 100,
                          spreadRadius: 0,
                          offset: const Offset(0, 48),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              icon: Icon(Icons.arrow_back_ios_new_rounded, color: const Color(0xFF5B4025), size: 24.sp),
                              onPressed: () => context.pop(),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Image.asset(AppAssets.logo, width: 80.w, height: 80.w),
                          SizedBox(height: 16.h),
                          Text(
                            'Reset Password',
                            style: GoogleFonts.poppins(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF5B4025),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(17, 12, 46, 0.15),
                          blurRadius: 100,
                          spreadRadius: 0,
                          offset: const Offset(0, 48),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Generated New Password',
                                    style: GoogleFonts.poppins(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF5B4025),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Enter your new password here and\nmake it different from previous',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Text(
                              'Password',
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF5B4025),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            TextFormField(
                              controller: passwordController,
                              obscureText: obscurePassword,
                              style: GoogleFonts.poppins(fontSize: 16.sp, color: const Color(0xFF5B4025)),
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 16.sp),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                  borderSide: BorderSide.none,
                                ),
                                errorStyle: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.red),
                                suffixIcon: IconButton(
                                  icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF5B4025)),
                                  onPressed: () => setState(() => obscurePassword = !obscurePassword),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                if (!isStrongPassword(value)) {
                                  return 'Password must contain upper, lower, digit, special char';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 18.h),
                            Text(
                              'Confirm Password',
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF5B4025),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            TextFormField(
                              controller: confirmPasswordController,
                              obscureText: obscureConfirmPassword,
                              style: GoogleFonts.poppins(fontSize: 16.sp, color: const Color(0xFF5B4025)),
                              decoration: InputDecoration(
                                hintText: 'Confirm your password',
                                hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 16.sp),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                  borderSide: BorderSide.none,
                                ),
                                errorStyle: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.red),
                                suffixIcon: IconButton(
                                  icon: Icon(obscureConfirmPassword ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF5B4025)),
                                  onPressed: () => setState(() => obscureConfirmPassword = !obscureConfirmPassword),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Confirm password is required';
                                }
                                if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 24.h),
                            SizedBox(
                              width: double.infinity,
                              height: 56.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF5B4025),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  elevation: 4,
                                  shadowColor: const Color.fromRGBO(100, 100, 111, 0.2),
                                ),
                                onPressed: () async {
                                  final newPassword = passwordController.text.trim();
                                  if (newPassword.isEmpty) {
                                    showCustomDialog(
                                      context,
                                      title: 'Error',
                                      message: 'Please enter a new password',
                                      isSuccess: false,
                                    );
                                    return;
                                  }

                                  final success = await appState.authState.resetPassword(
                                    email: widget.email,
                                    otp: widget.otp,
                                    newPassword: newPassword,
                                  );

                                  if (success) {
                                    showCustomDialog(
                                      context,
                                      title: 'Password Changed!',
                                      message: 'Your password has been\nchanged successfully.',
                                      isSuccess: true,
                                      onOk: () {
                                        context.go('/login');
                                      },
                                    );
                                  } else {
                                    showCustomDialog(
                                      context,
                                      title: 'Failed',
                                      message: 'Failed to reset password. Please try again.',
                                      isSuccess: false,
                                    );
                                  }
                                },
                                child: Text(
                                  'Reset',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
