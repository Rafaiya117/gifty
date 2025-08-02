import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

enum SubscriptionAction { cancel, renew }

class ManageSubscriptionScreen extends StatefulWidget {
  const ManageSubscriptionScreen({super.key});

  @override
  State<ManageSubscriptionScreen> createState() => _ManageSubscriptionScreenState();
}

class _ManageSubscriptionScreenState extends State<ManageSubscriptionScreen> {
  SubscriptionAction _selectedAction = SubscriptionAction.renew;

  void _selectAction(SubscriptionAction action) {
    setState(() {
      _selectedAction = action;
    });
  }

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 24.h),
            Container(
              width: double.infinity,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Manage all your subscriptions effortlessly in one place—upgrade, downgrade, or cancel your plan anytime with just a few clicks.',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: const Color(0xFF5B4025),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Month', style: GoogleFonts.poppins(fontSize: 15.sp, color: const Color(0xFF5B4025))),
                      Text('March', style: GoogleFonts.poppins(fontSize: 15.sp, color: const Color(0xFF5B4025))),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Amount', style: GoogleFonts.poppins(fontSize: 15.sp, color: const Color(0xFF5B4025))),
                      Text('Amount - \$4.99', style: GoogleFonts.poppins(fontSize: 15.sp, color: const Color(0xFF5B4025))),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Begins', style: GoogleFonts.poppins(fontSize: 15.sp, color: const Color(0xFF5B4025))),
                      Text('06 April, 2023', style: GoogleFonts.poppins(fontSize: 15.sp, color: const Color(0xFF5B4025))),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ends', style: GoogleFonts.poppins(fontSize: 15.sp, color: const Color(0xFF5B4025))),
                      Text('06 May, 2023', style: GoogleFonts.poppins(fontSize: 15.sp, color: const Color(0xFF5B4025))),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Type', style: GoogleFonts.poppins(fontSize: 15.sp, color: const Color(0xFF5B4025))),
                      Text('Monthly', style: GoogleFonts.poppins(fontSize: 15.sp, color: Colors.green, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: _selectedAction == SubscriptionAction.cancel ? const Color(0xFF5B4025) : Colors.white,
                            side: BorderSide(color: const Color(0xFF5B4025)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          onPressed: () => _selectAction(SubscriptionAction.cancel),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              color: _selectedAction == SubscriptionAction.cancel ? Colors.white : const Color(0xFF5B4025),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: _selectedAction == SubscriptionAction.renew ? const Color(0xFF5B4025) : Colors.white,
                            side: BorderSide(color: const Color(0xFF5B4025)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          onPressed: () => context.push('/subscription-plan'),
                          child: Text(
                            'Renew',
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              color: _selectedAction == SubscriptionAction.renew ? Colors.white : const Color(0xFF5B4025),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
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
