import 'package:bestwe2_0/app_State/app_State.dart';
import 'package:bestwe2_0/widgets/custom_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final appState =ApplicationState();
  bool obscureOld = true;
  bool obscureNew = true;
  bool obscureConfirm = true;

  bool isStrongPassword(String password) {
    return password.length >= 6 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[a-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password) &&
        RegExp(r'[!@#\$&*~_\-]').hasMatch(password);
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: const Color(0xFFDABEB6), size: 24.sp),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Change Password',
          style: GoogleFonts.poppins(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF5B4025),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.h),
              _buildLabel('Old Password'),
              _buildPasswordField(
                controller: oldPasswordController,
                hint: 'Enter your old password',
                obscure: obscureOld,
                toggle: () => setState(() => obscureOld = !obscureOld),
                validator: (value) =>
                value == null || value.isEmpty ? 'Old password is required' : null,
              ),
              SizedBox(height: 18.h),
              _buildLabel('New Password'),
              _buildPasswordField(
                controller: newPasswordController,
                hint: 'Enter your new password',
                obscure: obscureNew,
                toggle: () => setState(() => obscureNew = !obscureNew),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'New password is required';
                  if (!isStrongPassword(value)) {
                    return 'Password must be at least 6 chars, upper, lower, digit, special char';
                  }
                  return null;
                },
              ),
              SizedBox(height: 18.h),
              _buildLabel('Confirm Password'),
              _buildPasswordField(
                controller: confirmPasswordController,
                hint: 'Confirm your new password',
                obscure: obscureConfirm,
                toggle: () => setState(() => obscureConfirm = !obscureConfirm),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Confirm password is required';
                  if (value != newPasswordController.text) return 'Passwords do not match';
                  return null;
                },
              ),
              SizedBox(height: 32.h),
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
                    if (formKey.currentState!.validate()) {
                      final oldPassword = oldPasswordController.text.trim();
                      final newPassword = newPasswordController.text.trim();
                      final confirmPassword = confirmPasswordController.text.trim();

                      if (newPassword != confirmPassword) {
                        showCustomDialog(
                          context,
                          title: 'Error',
                          message: 'New passwords do not match.',
                          isSuccess: false,
                        );
                        return;
                      }

                      final success = await appState.authState.changeOldPassword(
                        oldPassword: oldPassword,
                        new_password1: newPassword,
                        new_password2: confirmPassword,
                      );

                      if (success) {
                        showCustomDialog(
                          context,
                          title: 'Password Changed!',
                          message: 'Your password has been updated successfully.',
                          isSuccess: true,
                          onOk: () {
                            context.go('/login');
                          },
                        );
                      } else {
                        showCustomDialog(
                          context,
                          title: 'Failed',
                          message: 'Password update failed. Please try again.',
                          isSuccess: false,
                        );
                      }
                    }
                  },
                  child: Text(
                    'Save',
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
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF5B4025),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool obscure,
    required VoidCallback toggle,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: GoogleFonts.poppins(fontSize: 16.sp, color: const Color(0xFF5B4025)),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF5B4025)),
          onPressed: toggle,
        ),
      ),
      validator: validator,
    );
  }
}