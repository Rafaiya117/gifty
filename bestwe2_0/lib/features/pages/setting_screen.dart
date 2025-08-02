import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                        'Settings',
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
            // Menu Items
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: [
                  _SettingsMenuItem(
                    icon: Icons.privacy_tip_outlined,
                    label: 'Privacy Policy',
                    onTap: () => context.push('/privacy-policy'),
                  ),
                  SizedBox(height: 16.h),
                  _SettingsMenuItem(
                    icon: Icons.error_outline,
                    label: 'Terms of service',
                    onTap: () => context.push('/terms-of-service'),
                  ),
                  SizedBox(height: 16.h),
                  _SettingsMenuItem(
                    icon: Icons.support_agent_outlined,
                    label: 'Help and Support',
                    onTap: () => context.push('/help-and-support'),
                  ),
                  SizedBox(height: 16.h),
                  _SettingsMenuItem(
                    icon: Icons.info_outline,
                    label: 'About Us',
                    onTap: () => context.push('/about-us'),
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

class _SettingsMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const _SettingsMenuItem({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32.r),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFFF9F6F3),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(icon, color: const Color(0xFF5B4025), size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                color: const Color(0xFF5B4025),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}