import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final ValueNotifier<String?> errorNotifier = ValueNotifier<String?>(null);
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
                        'Help and Support',
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
            SizedBox(height: 16.h),
            // Text Field
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 180.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: const Color(0xFFD6CFC7), width: 2),
                    ),
                    child: TextField(
                      controller: controller,
                      maxLines: null,
                      expands: true,
                      style: GoogleFonts.poppins(fontSize: 16.sp, color: const Color(0xFF5B4025)),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16.w),
                        border: InputBorder.none,
                        hintText: 'Describe Your Problem',
                        hintStyle: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.grey.shade400),
                      ),
                      onChanged: (_) => errorNotifier.value = null,
                    ),
                  ),
                  ValueListenableBuilder<String?>(
                    valueListenable: errorNotifier,
                    builder: (context, error, child) {
                      if (error == null) return const SizedBox.shrink();
                      return Padding(
                        padding: EdgeInsets.only(top: 8.h, left: 8.w),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            error,
                            style: GoogleFonts.poppins(
                              color: Colors.red,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                width: double.infinity,
                height: 56.h,
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
                    if (controller.text.trim().isEmpty) {
                      errorNotifier.value = 'This field is required';
                      return;
                    }
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const _HelpSupportDialog(),
                    );
                  },
                  child: Text(
                    'Send',
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
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

// Custom dialog widget
class _HelpSupportDialog extends StatelessWidget {
  const _HelpSupportDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFF9F6F3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 36.h),
                Text(
                  'We will contact you via email very soon.',
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    color: const Color(0xFF5B4025),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  width: 180.w,
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
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Done',
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF5B5745),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 22.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 