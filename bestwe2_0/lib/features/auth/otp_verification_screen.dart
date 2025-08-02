import 'package:bestwe2_0/app_State/app_State.dart';
import 'package:bestwe2_0/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String email;
  const OtpVerificationScreen({super.key, required this.email});
  
  @override
  Widget build(BuildContext context) {
    final appState = ApplicationState();
    final otpControllers = List.generate(4, (_) => TextEditingController());
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
                            'OTP',
                            style: GoogleFonts.poppins(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF5B4025),
                            ),
                          ),
                          Text(
                            'Verification code',
                            style: GoogleFonts.poppins(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w500,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Almost there',
                            style: GoogleFonts.poppins(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF5B4025),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Enter the 4 digit code that send to your email address',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(4, (i) {
                              return Container(
                                width: 48.w,
                                height: 56.h,
                                margin: EdgeInsets.symmetric(horizontal: 8.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: TextField(
                                    controller: otpControllers[i],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    maxLength: 1,
                                    style: GoogleFonts.poppins(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF5B4025),
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      counterText: '',
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            'Resend Code',
                            style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF5B4025),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Request new code in 00:30s',
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              color: Colors.grey,
                            ),
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
                              onPressed: ()async {
                                final otp = otpControllers.map((c) => c.text.trim()).join();
                                final success = await appState.authState.verifyOtp(email: email, otp: otp);
                                if (success) {
                                  context.push('/reset-password/$email/$otp');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Invalid OTP, please try again')),
                                  );
                                }
                              },
                              child: Text(
                                'Verify',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}