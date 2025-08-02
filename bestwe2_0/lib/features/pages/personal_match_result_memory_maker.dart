import 'package:bestwe2_0/app_State/app_State.dart';
import 'package:bestwe2_0/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PersonalMatchResultMemoryMakerScreen extends StatefulWidget {
  const PersonalMatchResultMemoryMakerScreen({super.key});

  @override
  _PersonalMatchResultMemoryMakerScreenState createState() => _PersonalMatchResultMemoryMakerScreenState();
}

class _PersonalMatchResultMemoryMakerScreenState
    extends State<PersonalMatchResultMemoryMakerScreen> {
  bool _isLoading = false; // The loading state

  @override
  Widget build(BuildContext context) {
    final appState = context.read<ApplicationState>();

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
                      'You are a',
                      style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF7B7B7B),
                      ),
                    ),
                    Text(
                      'Memory Maker',
                      style: GoogleFonts.poppins(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF5B4025),
                      ),
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
                padding: EdgeInsets.all(24.w),
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
                child: Text(
                  'Highly Empathetic, personalized, symbolic, deeply meaningful, focused on emotional reasons and lasting memories',
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: const Color(0xFF5B4025),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
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
                    backgroundColor: const Color(0xFF5B4025),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    elevation: 4,
                    shadowColor: const Color.fromRGBO(100, 100, 111, 0.2),
                  ),
                  onPressed: _isLoading
                      ? null // Disable the button while loading
                      : () async {
                    setState(() {
                      _isLoading = true; // Show loading indicator
                    });

                    try {
                      final recommendation = await appState.giftpotState.fetchGiftRecommendation(
                        userName: 'Rahim',
                        occasion: appState.giftpotState.selectedOccasion!,
                        priceRange: appState.giftpotState.selectedPriceRange!,
                        responseFormData: appState.giftpotState.responseFormAnswers,
                      );
                      setState(() {
                        _isLoading = false; // Hide loading indicator after fetching
                      });
                      context.go('/personal-match-recommend-memory-maker', extra: recommendation);
                    } catch (e) {
                      setState(() {
                        _isLoading = false; // Hide loading indicator on error
                      });
                      print("Error fetching recommendation: $e");
                    }
                  },
                  child: _isLoading
                      ? SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  ) // Show progress indicator if loading
                      : Text(
                    'Next',
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