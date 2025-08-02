import 'package:bestwe2_0/assets.dart';
import 'package:bestwe2_0/model/giftpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalMatchRecommendMemoryMakerScreen extends StatelessWidget {
  const PersonalMatchRecommendMemoryMakerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recommendation = GoRouterState.of(context).extra as GiftRecommendation?;
    // Show loading spinner if data not ready
    if (recommendation == null) {
      return const Scaffold(
        backgroundColor: Color(0xFFF9F6F3),
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    //...................//
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F3),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(Icons.arrow_back_ios_new_rounded, color: const Color(0xFF5B4025), size: 20.sp),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFDABEB6),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    Image.asset(AppAssets.logo, width: 64.w, height: 64.w),
                    SizedBox(height: 12.h),
                    Text(
                      'We Recommended',
                      style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF7B7B7B),
                      ),
                    ),
                    Text(
                      // 'A custom Family Portrait',
                      recommendation?.name ?? 'Gift Name',
                      style: GoogleFonts.poppins(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF5B4025),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 120.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F3F3),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: recommendation?.image != null
                              ? Image.network(
                                  recommendation!.image!,
                                  fit: BoxFit.contain,
                                )
                              : Image.asset(
                                  AppAssets.family, // static image as fallback
                                  fit: BoxFit.contain,
                                ),
                              ),
                        Positioned(
                          top: 8,
                          right: 12,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              // '\$15',
                              recommendation?.price != null ? '\$${recommendation!.price}' : '\$--',
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF5B4025),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Based on your giving profile, this gift reflects your deep empathy and desire to create lasting, emotionally resonant memories. It offers a personalized, symbolic tribute that honors your friend\'s bond with his other family members—bringing comfort, connecting and meaning',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        color: const Color(0xFF5B4025),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 24.h, top: 8.h),
              child: SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5151),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    elevation: 4,
                    shadowColor: const Color.fromRGBO(100, 100, 111, 0.2),
                  ),
                  onPressed: () =>context.go('/main'), // TODO: Add buy action
                  child: Text(
                    'Buy Now',
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}