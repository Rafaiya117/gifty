import 'package:bestwe2_0/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void showCustomDialog(BuildContext context, {
  required String title,
  required String message,
  required bool isSuccess,
  VoidCallback? onOk,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Center(
        child: Container(
          width: 320.w,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                isSuccess ? AppAssets.tikIcon : AppAssets.tikIcon,
                width: 96.w,
                height: 96.w,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 32.h),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF5B4025),
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                message,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Colors.grey,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B4025),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    elevation: 4,
                    shadowColor: const Color.fromRGBO(100, 100, 111, 0.2),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onOk != null) {
                      onOk();
                    }
                  },
                  child: Text(
                    'OK',
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
      );
    },
  );
}
