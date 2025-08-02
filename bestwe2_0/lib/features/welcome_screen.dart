import 'package:bestwe2_0/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

enum AuthTab { login, signup }

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  AuthTab selectedTab = AuthTab.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F3), // Light beige background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 32.h),
                      Container(
                        width: 350.w,
                        padding: EdgeInsets.symmetric(vertical: 32.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDABEB6),
                          borderRadius: BorderRadius.circular(24.r),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromRGBO(100, 100, 111, 0.2),
                              blurRadius: 29,
                              offset: const Offset(0, 7),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Welcome Back!',
                              style: GoogleFonts.poppins(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF5B4025),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'It is so nice to see you again',
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF5B4025),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 48.h),
                      Container(
                        width: 350.w,
                        padding: EdgeInsets.only(top: 32.h, bottom: 24.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24.r),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromRGBO(100, 100, 111, 0.2),
                              blurRadius: 29,
                              offset: const Offset(0, 7),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'EFFORTLESS GIFTING FOR THE EVERYDAY MOMENTS',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF5B4025),
                                letterSpacing: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 36.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32.w),
                              child: SizedBox(
                                width: double.infinity,
                                height: 56.h,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: selectedTab == AuthTab.login
                                        ? const Color(0xFF5B4025)
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                                    elevation: 0,
                                    side: selectedTab == AuthTab.login
                                        ? null
                                        : const BorderSide(color: Color(0xFFEAEAEA), width: 1),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedTab = AuthTab.login;
                                    });
                                    context.push('/login');
                                  },
                                  child: Text(
                                    'Login',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      color: selectedTab == AuthTab.login
                                          ? Colors.white
                                          : const Color(0xFF5B4025),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32.w),
                              child: SizedBox(
                                width: double.infinity,
                                height: 56.h,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: selectedTab == AuthTab.signup
                                        ? const Color(0xFF5B4025)
                                        : Colors.white,
                                    side: selectedTab == AuthTab.signup
                                        ? null
                                        : const BorderSide(color: Color(0xFFEAEAEA), width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedTab = AuthTab.signup;
                                    });
                                    context.push('/signup');
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      color: selectedTab == AuthTab.signup
                                          ? Colors.white
                                          : const Color(0xFF5B4025),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32.h),
                    ],
                  ),
                  Positioned(
                    top: 150.h,
                    child: Container(
                      width: 96.w,
                      height: 96.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      child: Image.asset(AppAssets.logo, fit: BoxFit.contain),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
