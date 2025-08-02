import 'package:bestwe2_0/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F3),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 32.h, bottom: 24.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDABEB6),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 8.h),
                        Image.asset(AppAssets.logo, width: 64.w, height: 64.w),
                        SizedBox(height: 12.h),
                        Text(
                          'What is the Occasion?',
                          style: GoogleFonts.poppins(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF5B4025),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 16.w,
                    top: 16.h,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.notifications, color: const Color(0xFF5B4025)),
                          onPressed: () => context.push('/notifications'),
                        ),
                        SizedBox(width: 16.w),
                        CircleAvatar(
                          radius: 18.r,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: const Color(0xFF5B4025)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: 700.h,
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12.h,
                      crossAxisSpacing: 8.w,
                      padding: EdgeInsets.zero,
                      childAspectRatio: 2.5,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        for (final label in [
                          'Memorial Day', 'Father\'s Day', 'Father\'s Day',
                          'Graduation', 'Birthday', 'Mother\'s Day',
                          'Housewarming', 'Anniversary', 'Wedding',
                          'Wedding', 'Bachelorette Party', 'New Job',
                          'Diwali', 'Halloween', 'Work Anniversary',
                          'Ramadan', 'Holiday', 'Christmas',
                          'Eid', 'Secret Santa', 'Valentine\'s Day',
                          'New Year\'s', 'Retirement', 'Engagement',
                          'New Year\'s', 'Retirement', 'Engagement',
                          'New Year\'s', 'Retirement', 'Engagement',
                          'New Year\'s', 'Retirement', 'Engagement',
                        ])
                          GestureDetector(
                            // onTap: () => context.push('/preferred-price-point'),
                            onTap: () => context.push('/preferred-price-point?label=${Uri.encodeComponent(label)}'),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24.r),
                                border: Border.all(color: const Color(0xFFEAEAEA)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                label,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF5B4025),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
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