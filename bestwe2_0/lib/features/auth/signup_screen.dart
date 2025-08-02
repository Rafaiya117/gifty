import 'package:bestwe2_0/app_State/app_State.dart';
import 'package:bestwe2_0/assets.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final appState = ApplicationState();

  bool obscurePassword = true;
  String selectedCountryCode = '+1';
  String selectedFlag = '🇨🇦';

  void togglePassword() => setState(() => obscurePassword = !obscurePassword);

  void pickCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          selectedCountryCode = '+${country.phoneCode}';
          selectedFlag = country.flagEmoji;
        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDABEB6),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              icon: Icon(Icons.arrow_back_ios_new_rounded, color: const Color(0xFF5B4025), size: 24.sp),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Image.asset(AppAssets.logo, width: 64.w, height: 64.w),
                          SizedBox(height: 12.h),
                          Text(
                            'Sign Up',
                            style: GoogleFonts.poppins(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF5B4025),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // User field
                                labelText('User'),
                                textField(userController, 'Enter your name', 'User is required'),

                                SizedBox(height: 18.h),
                                labelText('Email'),
                                textField(emailController, 'Enter your email', 'Email is required', isEmail: true),

                                SizedBox(height: 18.h),
                                labelText('Mobile'),
                                SizedBox(height: 8.h),
                                GestureDetector(
                                  onTap: pickCountry,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(selectedFlag, style: TextStyle(fontSize: 28.sp)),
                                        SizedBox(width: 8.w),
                                        Text(
                                          selectedCountryCode,
                                          style: GoogleFonts.poppins(fontSize: 16.sp, color: const Color(0xFF5B4025)),
                                        ),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: TextFormField(
                                            controller: phoneController,
                                            keyboardType: TextInputType.phone,
                                            style: GoogleFonts.poppins(fontSize: 16.sp, color: const Color(0xFF5B4025)),
                                            decoration: InputDecoration(
                                              hintText: 'Enter Phone number',
                                              hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 16.sp),
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                                            ),
                                            validator: (value) => (value == null || value.isEmpty) ? 'Mobile is required' : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 18.h),
                                labelText('Password'),
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
                                      icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility,
                                          color: const Color(0xFF5B4025)),
                                      onPressed: togglePassword,
                                    ),
                                  ),
                                  validator: (value) => (value == null || value.isEmpty) ? 'Password is required' : null,
                                ),

                                SizedBox(height: 16.h),
                                SizedBox(
                                  width: double.infinity,
                                  height: 56.h,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF5B4025),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                                      elevation: 0,
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final String username = userController.text;
                                        final String email = emailController.text;
                                        final int phone = int.tryParse(phoneController.text) ?? 0;
                                        final String password = passwordController.text;

                                        setState(() => appState.authState.isLoading == true);

                                        final success = await appState.authState.registration(username, email, phone, password);

                                        setState(() => appState.authState.isLoading == false);

                                        if (success) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Signup Successful')),
                                          );
                                          context.push('/main');
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Signup Failed: User already exists or invalid input')),
                                          );
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Sign Up',
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
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(child: Divider()),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Text(
                                  'Or continued with',
                                  style: GoogleFonts.poppins(fontSize: 14.sp, color: const Color(0xFF5B4025)),
                                ),
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset(AppAssets.googleIcon, width: 70.w, height: 70.w),
                          ),
                          SizedBox(height: 20.h),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(context, '/login'),
                            child: Text(
                              "Already have an account? Login",
                              style: GoogleFonts.poppins(fontSize: 15.sp, color: const Color(0xFF5B4025)),
                            ),
                          ),
                        ],
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

  Widget labelText(String text) => Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Text(
          text,
          style: GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w500, color: const Color(0xFF5B4025)),
        ),
      );

  Widget textField(TextEditingController controller, String hint, String error, {bool isEmail = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      style: GoogleFonts.poppins(fontSize: 16.sp, color: const Color(0xFF5B4025)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 16.sp),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide.none,
        ),
        errorStyle: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.red),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return error;
        if (isEmail && !RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$").hasMatch(value)) return 'Enter a valid email';
        return null;
      },
    );
  }
}
