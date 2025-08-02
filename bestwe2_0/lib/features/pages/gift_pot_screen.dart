import 'package:bestwe2_0/app_State/app_State.dart';
import 'package:bestwe2_0/assets.dart';
import 'package:bestwe2_0/model/giftpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GiftPotScreen extends StatelessWidget {
  final String image;
  final String title;
  const GiftPotScreen({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    final giftIdController = TextEditingController();
    final amountController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color(0xFFF5ECE5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 24.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5CFC5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back_ios_new_rounded, color: const Color(0xFFBFA18A), size: 22.sp),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Gift pot',
                  style: GoogleFonts.poppins(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF5B4025),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.h),
                Text(
                  'Create Sharing items with your friends',
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    color: const Color(0xFFBFA18A),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                Center(
                  child: Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Image.asset(
                        image.isNotEmpty ? image : AppAssets.product,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Product Name',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: const Color(0xFF5B4025),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                TextField(
                  enabled: false,
                  controller: TextEditingController(text: title),
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: const Color(0xFF5B4025),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Product Name',
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Gift ID',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: const Color(0xFF5B4025),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                TextField(
                  controller: giftIdController,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: const Color(0xFF5B4025),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Gift ID',
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Amount',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: const Color(0xFF5B4025),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: const Color(0xFF5B4025),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Amount',
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5B4025),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                      elevation: 6,
                      shadowColor: const Color.fromRGBO(100, 100, 111, 0.2),
                    ),
                    onPressed: ()async {
                       final appState = context.read<ApplicationState>();
                        // Find the recommendation or use minimal fallback
                        final recommendation = appState.giftpotState.recommendations.firstWhere(
                            (gift) => gift.name == title,
                            orElse: () => GiftRecommendation(
                              name: title,
                              image: image,
                              description: '',
                              price: amountController.text,
                              url: '',
                            ),
                          );
                          final giftPotId = await appState.giftpotState.createGiftPot(
                            productName: title,
                            productImage: image,
                            productDescription: recommendation.description ?? '',
                            amount: amountController.text,
                            productWebsiteLink: recommendation.url ?? '',
                          );
                      if (giftPotId != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Successfully created gift pot with ID: $giftPotId',
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to create gift pot')),
                        );
                      }
                     
                    },
                    child: Text(
                      'Submit',
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 