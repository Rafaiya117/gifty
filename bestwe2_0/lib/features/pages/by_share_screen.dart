import 'package:bestwe2_0/app_State/app_State.dart';
import 'package:bestwe2_0/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class ByShareScreen extends StatelessWidget {
  const ByShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F3),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w),
          child: Row(
            children: [
              // Custom circular back button
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5CFC5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_back_ios_new_rounded, color: const Color(0xFF5B4025), size: 22.sp),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'By Share',
                    style: GoogleFonts.poppins(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF5B4025),
                    ),
                  ),
                ),
              ),
              // Pill-shaped button with icon
              Container(
                height: 36.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF5B4025),
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.tune, color: Colors.white, size: 18.sp),
                    SizedBox(width: 6.w),
                    Text(
                      'See your giftpot',
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        children: [
          // Search bar
          Container(
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter your giftpot ID',
                hintStyle: GoogleFonts.poppins(fontSize: 15.sp, color: const Color(0xFF5B4025).withOpacity(0.5)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 12.w, right: 8.w),
                  child: Icon(Icons.search, color: const Color(0xFF5B4025)),
                ),
              ),
            ),
          ),
          
          // Card 1: Empty progress (0$/600$)
          Consumer<ApplicationState>(
            builder: (context, appState, _) {
              final giftList = appState.giftpotState.giftList;

              if (giftList.isEmpty) {
                return const Center(child: Text('No gifts available'));
              }

              return Expanded(  // Keep this as you have it
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Column(
                    children: giftList.asMap().entries.map((entry) {
                      final index = entry.key;
                      final gift = entry.value;

                      return Padding(
                        padding: EdgeInsets.only(bottom: index == giftList.length - 1 ? 0 : 12.h),
                        child: _GiftpotCard(
                          image: gift.productImage.isNotEmpty ? gift.productImage : 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fgadgetstudiobd.com%2Fproduct%2Fbeats-powerbeats-pro-2%2F%3Fsrsltid%3DAfmBOoqda8sCpOPYNMzUj1E97K-IuiqRaPrf32azezyQs9yeGhfvTA2h&psig=AOvVaw1lOZPGqzq-U-vU6coRYjNC&ust=1753782745023000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCIj-7fuj344DFQAAAAAdAAAAABAE',
                          title: gift.productName,
                          id: '#${gift.giftPotId}',
                          amount:
                          '\$${gift.contributedAmount.toStringAsFixed(0)}/\$${gift.totalAmount.toStringAsFixed(0)}',
                          actionLabel: gift.isCreator ? 'View Contributions' : 'Contribute Now',
                          actionColor: gift.progressPercent == 1.0
                              ? const Color(0xFF6D4C41)
                              : const Color(0xFF00C853),
                          isOwner: gift.isCreator,
                          progress: gift.progressPercent,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 16.h),
          
          // Card 2: Created by you (200$/300$)
          // _GiftpotCard(
          //   image: AppAssets.product,
          //   title: 'Airbud Pro',
          //   id: '#113687',
          //   amount: '200\$/300\$',
          //   actionLabel: 'This giftpot is created by you',
          //   actionColor: Colors.green,
          //   isOwner: true,
          //   progress: 2/3,
          // ),
          
          SizedBox(height: 16.h),
          
          // Card 3: Completed (300$/300$)
          // _GiftpotCard(
          //   image: AppAssets.product,
          //   title: 'Airbud Pro',
          //   id: '#113687',
          //   amount: '300\$/300\$',
          //   actionLabel: 'Buy Now',
          //   actionColor: const Color(0xFFFF5252),
          //   isOwner: false,
          //   progress: 1.0,
          //   isBuyNow: true,
          //   showContributorList: true,
          // ),
        ],
      ),
    );
  }
}

class _GiftpotCard extends StatelessWidget {
  final String image;
  final String title;
  final String id;
  final String amount;
  final String actionLabel;
  final Color actionColor;
  final bool isOwner;
  final bool isBuyNow;
  final double progress;
  final bool showContributorList;

  const _GiftpotCard({
    required this.image,
    required this.title,
    required this.id,
    required this.amount,
    required this.actionLabel,
    required this.actionColor,
    this.isOwner = false,
    this.isBuyNow = false,
    this.progress = 0.0,
    this.showContributorList = false,
  });

  @override
  Widget build(BuildContext context) {
    // Determine progress bar color based on completion
    Color progressColor = progress == 1.0 ? const Color(0xFF6D4C41) : const Color(0xFF00C853);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Image.network(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            SizedBox(width: 16.w),
            
            // Info section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First row: Title and ID
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF5B4025),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      
                      Expanded(
                        flex: 2,
                        child: Text(
                          id,
                          style: GoogleFonts.poppins(
                            fontSize: 13.sp,
                            color: const Color(0xFF5B4025).withOpacity(0.6),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  
                  // Second row: Amount or contributor list
                  Row(
                    children: [
                      if (showContributorList)
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => const ContributorListDialog(),
                            );
                          },
                          child: Text(
                            'Contributor List',
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: const Color(0xFF5B4025).withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      if (showContributorList) Spacer(),
                      Text(
                        amount,
                        style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          color: const Color(0xFF5B4025),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 12.h),
                  
                  // Progress bar
                  Container(
                    height: 8.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: progress,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: progressColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 12.h),
                  
                  // Action button or label
                  if (isOwner)
                    Text(
                      actionLabel,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: const Color(0xFF00C853),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  else
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 36.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: actionColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            elevation: 0,
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                          ),
                          onPressed: () {
                            if (actionLabel == 'Contribute Now') {
                              context.push('/contribute-now');
                            }
                          },
                          child: Text(
                            actionLabel,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
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
          ],
        ),
      ),
    );
  }
}

class ContributorListDialog extends StatelessWidget {
  const ContributorListDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final contributors = [
      {'name': 'Mir Md Mosarof Hossan', 'amount': '10\$', 'avatar': 'https://randomuser.me/api/portraits/men/1.jpg'},
      {'name': 'Mir Md Mosarof Hossan', 'amount': '150\$', 'avatar': 'https://randomuser.me/api/portraits/men/2.jpg'},
      {'name': 'Mir Md Mosarof Hossan', 'amount': '20\$', 'avatar': 'https://randomuser.me/api/portraits/men/3.jpg'},
      {'name': 'Mir Md Mosarof Hossan', 'amount': '50\$', 'avatar': 'https://randomuser.me/api/portraits/men/4.jpg'},
      {'name': 'Mir Md Mosarof Hossan', 'amount': '10\$', 'avatar': 'https://randomuser.me/api/portraits/men/5.jpg'},
    ];
    return Dialog(
      backgroundColor: const Color(0xFFF9F6F3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Contributor Name',
                      style: GoogleFonts.poppins(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF5B4025),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE5CFC5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, color: Color(0xFF5B4025), size: 22.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: contributors.length,
                separatorBuilder: (context, index) => Divider(
                  color: const Color(0xFFEAEAEA),
                  thickness: 1,
                ),
                itemBuilder: (context, index) {
                  final c = contributors[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24.r,
                          backgroundImage: NetworkImage(c['avatar']!),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Text(
                            c['name']!,
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              color: const Color(0xFF5B4025),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          c['amount']!,
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            color: const Color(0xFF5B4025),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}