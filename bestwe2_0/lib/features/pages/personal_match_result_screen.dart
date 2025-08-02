import 'package:bestwe2_0/app_State/app_State.dart';
import 'package:bestwe2_0/assets.dart';
import 'package:bestwe2_0/model/giftpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PersonalMatchResultScreen extends StatefulWidget {
  const PersonalMatchResultScreen({super.key});

  @override
  State<PersonalMatchResultScreen> createState() => _PersonalMatchResultScreenState();
}

class _PersonalMatchResultScreenState extends State<PersonalMatchResultScreen> {
  int? selectedIdx;

  final options = [
    'A. Warmth and connection',
    'B. Joy and delight',
    'C. Gratitude and appreciation',
    'D. Inspiration and thoughtfulness',
  ];

  @override
  Widget build(BuildContext context) {
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        'Ideally, what emotional reaction do you hope your gift sparks?',
                        style: GoogleFonts.poppins(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF5B4025),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Column(
              children: List.generate(options.length, (i) {
                final isSelected = selectedIdx == i;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIdx = i;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF5B4025) : Colors.white,
                        borderRadius: BorderRadius.circular(32.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        options[i],
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          color: isSelected ? Colors.white : const Color(0xFF5B4025),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                );
              }),
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
                  // onPressed: selectedIdx != null ? () => context.push('/personal-match-final') : null,
                  onPressed: selectedIdx != null ? () {
                    final appState = context.read<ApplicationState>();
                    appState.giftpotState.addResponseFormAnswer(
                      ResponseFormItem(
                        question: 'Ideally, what emotional reaction do you hope your gift sparks?',
                        responseText: options[selectedIdx!],
                     ),
                  );
                  context.push('/personal-match-final'); 
                }: null,
                  child: Text(
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
