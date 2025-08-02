import 'package:bestwe2_0/app_State/app_State.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  //added my rafaiya
  List<String> _splitHtmlToBulletPoints(String html) {
    final cleanText = html.replaceAll(RegExp(r'<[^>]*>'), '').split('. ').where((e) => e.trim().isNotEmpty).map((e) => e.trim() + '.').toList();
    return cleanText;
  }


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
                        'Privacy Policy',
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
            SizedBox(height: 12.h),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 8.h, bottom: 16.h),
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Consumer<ApplicationState>(
                    builder: (context, appState, _) {
                      final privacy = appState.staticContentState.privacy;

                      if (privacy == null) {
                        return const Center(child: CircularProgressIndicator()); // loading state
                      }

                      final policyContent = privacy.content;

                      // Optional: split HTML into bullet points (your custom function)
                      final bulletPoints = _splitHtmlToBulletPoints(policyContent);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: bulletPoints.map((text) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: _BulletText(text),
                          );
                        }).toList(),
                      );
                    },
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

class _BulletText extends StatelessWidget {
  final String text;
  const _BulletText(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('• ', style: GoogleFonts.poppins(fontSize: 16.sp, color: const Color(0xFF5B4025))),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(fontSize: 15.sp, color: const Color(0xFF5B4025)),
          ),
        ),
      ],
    );
  }
}