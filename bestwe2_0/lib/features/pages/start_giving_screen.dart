import 'package:bestwe2_0/app_State/app_State.dart';
import 'package:bestwe2_0/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StartGivingScreen extends StatelessWidget {
  final String label;
  final String price;

  const StartGivingScreen({
    Key? key,
    required this.label,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _handleOptionTap(BuildContext context, int i, String label, String price) async {
      final appState = context.read<ApplicationState>();
      appState.giftpotState.setOccasionAndPrice(occasion: label, priceRange: price);
    try{
      switch (i) {
    case 0:
      // await appState.giftpotState.fetchGiftRecommendationsData(
      //   occasion: label,
      //   priceRange: price,
      // );
      context.push('/curated-picks', extra: {'occasion': label, 'priceRange': price});
      break;
    case 1:
      context.push('/personal-match-question');
      break;
    case 2:
      context.push('/shared-giving-suggestions', extra: {'occasion': label, 'priceRange': price});
      break;
  }
    }catch(e){
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
}
    final options = [
      {
        'title': 'Curated Picks',
        'subtitle': 'On-trend Gift list, ready to send',
      },
      {
        'title': 'Personal Match',
        'subtitle': 'Thoughtful ideas based on your giving style',
      },
      {
        'title': 'Shared Giving',
        'subtitle': 'Join others to gift big or give back',
      },
    ];
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
              padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                      'Start Giving\nYour Way',
                      style: GoogleFonts.poppins(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF5B4025),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32.h),
            for (int i = 0; i < options.length; i++)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: GestureDetector(
                  onTap:()=> _handleOptionTap(context, i, label, price),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          options[i]['title']!,
                          style: GoogleFonts.poppins(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF5B4025),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          options[i]['subtitle']!,
                          style: GoogleFonts.poppins(
                            fontSize: 15.sp,
                            color: const Color(0xFF5B4025),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
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