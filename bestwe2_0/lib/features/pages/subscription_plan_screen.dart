import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionPlanScreen extends StatelessWidget {
  const SubscriptionPlanScreen({super.key});

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
          'Manage Subscription',
          style: GoogleFonts.poppins(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF5B4025),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        children: [
          // Free Trial Card
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 24.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '1 month free trial',
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF5B4025),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Free',
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF5B4025),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                _FeatureRow('Personalized meal plans', true),
                _FeatureRow('Adaptive fitness recommendations', true),
                _FeatureRow('Offline access', true),
                _FeatureRow('Premium challenges and rewards', true),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5B4025),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      elevation: 8,
                      shadowColor: const Color.fromRGBO(17, 12, 46, 0.15),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Subscribe Free',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Monthly Subscription Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Monthly Subscription',
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF5B4025),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  '\$4.99/month',
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF5B4025),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                _FeatureRow('Personalized meal plans', false),
                _FeatureRow('Adaptive fitness recommendations', false),
                _FeatureRow('Premium challenges and rewards', false),
                _FeatureRow('Daily Energy Expenditure Calculator', false),
                _FeatureRow('Mood Tracking', false),
                _FeatureRow('Emotional Support', false),
                _FeatureRow('Offline access', false),
                _FeatureRow('Ad-free experience', false),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5B4025),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      elevation: 8,
                      shadowColor: const Color.fromRGBO(17, 12, 46, 0.15),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Subscribe Monthly',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String text;
  final bool isFreeTrial;
  const _FeatureRow(this.text, this.isFreeTrial);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: isFreeTrial ? const Color(0xFF5B4025) : Colors.white,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                color: const Color(0xFF5B4025),
              ),
            ),
          ),
        ],
      ),
    );
  }
}