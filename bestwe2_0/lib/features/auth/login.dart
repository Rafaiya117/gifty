import 'package:bestwe2_0/app_State/app_State.dart';
import 'package:bestwe2_0/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final appState = ApplicationState();
  bool _obscureText = true;

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
                // Main Card
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
                              onPressed: () => context.pop(),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Image.asset(AppAssets.logo, width: 64.w, height: 64.w),
                          SizedBox(height: 12.h),
                          Text(
                            'Login',
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
                                Text(
                                  'Email',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF5B4025),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: GoogleFonts.poppins(fontSize: 16.sp, color: const Color(0xFF5B4025)),
                                  decoration: InputDecoration(
                                    hintText: 'Enter your email',
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
                                    if (value == null || value.isEmpty) {
                                      return 'Email is required';
                                    }
                                    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                        .hasMatch(value)) {
                                      return 'Enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 18.h),
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
                                  controller: _passwordController,
                                  obscureText: _obscureText,
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
                                      icon: Icon(
                                        _obscureText ? Icons.visibility_off : Icons.visibility,
                                        color: const Color(0xFF5B4025),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is required';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        context.push('/forgot-password');
                                      },
                                      child: Text(
                                        'Forgot your password?',
                                        style: GoogleFonts.poppins(
                                          fontSize: 13.sp,
                                          color: const Color(0xFF5B4025),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                SizedBox(
                                  width: double.infinity,
                                  height: 56.h,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF5B4025),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.r),
                                      ),
                                      elevation: 0,
                                    ),
                                    onPressed: () async {
                                      context.push('/main');
                                      // if (_formKey.currentState!.validate()) {
                                      //   final String email = _emailController.text;
                                      //   final String password = _passwordController.text;
                                      //
                                      //   setState(() => appState.authState.isLoading == true);
                                      //
                                      //   final success = await appState.authState.login(email, password);
                                      //
                                      //   setState(() => appState.authState.isLoading ==false);
                                      //
                                      //   if (success) {
                                      //     ScaffoldMessenger.of(context).showSnackBar(
                                      //       SnackBar(content: Text('Login Successful')),
                                      //     );
                                      //     context.push('/main');
                                      //   } else {
                                      //     ScaffoldMessenger.of(context).showSnackBar(
                                      //       SnackBar(content: Text('Invalid email or password')),
                                      //     );
                                      //   }
                                      // }
                                    },

                                    child: Text(
                                      'Login',
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
                // Or continued with
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
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    color: const Color(0xFF5B4025),
                                  ),
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
                            onPressed: () => context.push('/signup'),
                            child: Text(
                              "Don't have an account? Sign Up",
                              style: GoogleFonts.poppins(
                                fontSize: 15.sp,
                                color: const Color(0xFF5B4025),
                              ),
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
}
