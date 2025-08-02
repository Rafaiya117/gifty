import 'package:bestwe2_0/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class PreferredPricePointScreen extends StatefulWidget {
  final String label;
  const PreferredPricePointScreen({Key? key, required this.label}) : super(key: key);

  @override
  State<PreferredPricePointScreen> createState() => _PreferredPricePointScreenState();
}

class _PreferredPricePointScreenState extends State<PreferredPricePointScreen> {
  int? selectedIdx;

  final priceOptions = [
    'Under \$25',
    '\$25 - \$50',
    '\$50 - \$100',
    '\$100 - \$250',
    '\$250 - \$500',
    '\$500 - \$1000',
    '\$1000 - \$5000',
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
                      'Preferred Price\nPoint',
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
            SizedBox(height: 24.h),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                itemCount: priceOptions.length,
                separatorBuilder: (_, __) => SizedBox(height: 18.h),
                itemBuilder: (context, index) {
                  final selected = selectedIdx == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedIdx = index),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        color: selected ? const Color(0xFF5B4025) : Colors.white,
                        borderRadius: BorderRadius.circular(32.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        priceOptions[index],
                        style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          color: selected ? Colors.white : const Color(0xFF5B4025),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
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
                  // onPressed: selectedIdx != null
                  //     ? () => context.push('/start-giving')
                  //     : null,
                  onPressed: selectedIdx != null ? () => context.push(
                    '/start-giving',
                    extra: {
                      'label': widget.label,
                      'price': priceOptions[selectedIdx!],
                    },
                  ) : null,
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
