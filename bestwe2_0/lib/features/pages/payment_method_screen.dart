import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F3),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom AppBar
            Padding(
              padding: EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w, bottom: 12.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE5CFC5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF5B4025), size: 22.sp),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Payment Method',
                        style: GoogleFonts.poppins(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF5B4025),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 40.w), // To balance the back button
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter your Stripe Email',
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: const Color(0xFF5B4025),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    style: GoogleFonts.poppins(fontSize: 16.sp, color: const Color(0xFF5B4025)),
                    decoration: InputDecoration(
                      hintText: 'Type here',
                      hintStyle: GoogleFonts.poppins(color: const Color(0xFF5B4025).withOpacity(0.4)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide(color: const Color(0xFF5B4025)),
                      ),
                    ),
                  ),
                  SizedBox(height: 36.h),
                  Center(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5B4025),
                        borderRadius: BorderRadius.circular(32.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(17, 12, 46, 0.08),
                            blurRadius: 32,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32.r),
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 18.h),
                            child: Center(
                              child: Text(
                                'Save',
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
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
    );
  }
} 