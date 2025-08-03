// Removed enums and Cubit classes

import 'package:bestwe2_0/app_State/app_State.dart';
import 'package:bestwe2_0/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = ApplicationState();
    return Scaffold(
      backgroundColor: const Color(0xFFDABEB6),
      body: SafeArea(
        child: Column(
          children: [
            // Top card
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDABEB6),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24.r),
                      bottomRight: Radius.circular(24.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(17, 12, 46, 0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 60.h,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      FutureBuilder<void>(
                        future: Provider.of<ApplicationState>(context, listen: false).ensureInitialized(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState != ConnectionState.done) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          return Consumer<ApplicationState>(
                            builder: (context, appState, _) {
                              if (appState.authState.isLoading) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              final user = appState.userState.userList.isNotEmpty ? appState.userState.userList.first : null;
                              final imageUrl = fixImageUrl(user?.image ?? 'https://randomuser.me/api/portraits/men/1.jpg');
                              return Column(
                                children: [
                                  CircleAvatar(
                                    radius: 56.r,
                                    backgroundImage: NetworkImage(imageUrl),
                                    backgroundColor: Colors.white,
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    user?.full_name ?? 'Guest User',
                                    style: GoogleFonts.poppins(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF5B4025),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),

                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 100.h),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F6F3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r),
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  children: [
                    _ProfileMenuItem(
                      icon: Icons.person,
                      label: 'Profile Information',
                      onTap: () => context.push('/profile-information'),
                      showArrow: true,
                    ),
                    _ProfileDivider(),
                    _ProfileMenuItem(
                      icon: Icons.card_giftcard,
                      label: 'Subscription',
                      onTap: () => context.push('/manage-subscription'),
                      showArrow: true,
                    ),
                    _ProfileDivider(),
                    _ProfileMenuItem(
                      icon: Icons.share,
                      label: 'By Share',
                      onTap: () => context.push('/by-share'),
                      showArrow: true,
                    ),
                    _ProfileDivider(),
                    _ProfileMenuItem(
                      icon: Icons.credit_card,
                      label: 'Payment Method',
                      onTap: () => context.push('/payment-method'),
                      showArrow: true,
                    ),
                    _ProfileDivider(),
                    _ProfileMenuItem(
                      icon: Icons.lock,
                      label: 'Password',
                      onTap: () => context.push('/change-password'),
                      showArrow: true,
                    ),
                    _ProfileDivider(),
                    _ProfileMenuItem(
                      icon: Icons.calendar_today,
                      label: 'Reminder',
                      onTap: () => context.push('/reminder'),
                      showArrow: true,
                    ),
                    _ProfileDivider(),
                    _ProfileMenuItem(
                      icon: Icons.settings,
                      label: 'Settings',
                      onTap: () => context.push('/settings'),
                      showArrow: true,
                    ),
                    _ProfileDivider(),
                    _ProfileMenuItem(
                      icon: Icons.logout,
                      label: 'Logout',
                      isLogout: true,
                      showArrow: true,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Log Out',
                                    style: GoogleFonts.poppins(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF5B4025),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    'Are you sure you want to log out',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      color: const Color(0xFF5B4025),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 32.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(color: Color(0xFF5B4025)),
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(32.r),
                                            ),
                                            padding: EdgeInsets.symmetric(vertical: 16.h),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: GoogleFonts.poppins(
                                              fontSize: 18.sp,
                                              color: const Color(0xFF5B4025),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 16.w),
                                      Expanded(
                                        child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(color: Color(0xFF5B4025)),
                                            backgroundColor: const Color(0xFF5B4025),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(32.r),
                                            ),
                                            padding: EdgeInsets.symmetric(vertical: 16.h),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            context.go('/welcome');
                                          },
                                          child: Text(
                                            'Logout',
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
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    _ProfileDivider(),
                    SizedBox(height: 8.h),
                    Center(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(32.r),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => Dialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Delete Account',
                                      style: GoogleFonts.poppins(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF5B4025),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 16.h),
                                    Text(
                                      'Are you sure you want to delete your account',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18.sp,
                                        color: const Color(0xFF5B4025),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 32.h),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(color: Color(0xFF5B4025)),
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(32.r),
                                              ),
                                              padding: EdgeInsets.symmetric(vertical: 16.h),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Cancel',
                                              style: GoogleFonts.poppins(
                                                fontSize: 18.sp,
                                                color: const Color(0xFF5B4025),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 16.w),
                                        Expanded(
                                          child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(color: Color(0xFF5B4025)),
                                              backgroundColor: const Color(0xFF5B4025),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(32.r),
                                              ),
                                              padding: EdgeInsets.symmetric(vertical: 16.h),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              context.go('/welcome');
                                            },
                                            child: Text(
                                              'Delete',
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
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32.r),
                            border: Border.all(color: Colors.red.withOpacity(0.3), width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.08),
                                blurRadius: 16,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 18.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.delete_outline, color: Colors.red, size: 24.sp),
                                SizedBox(width: 12.w),
                                Text(
                                  'Delete Account',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18.sp,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Divider(
        color: const Color(0xFFEAEAEA),
        height: 0,
        thickness: 1,
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final bool showArrow;
  final bool isLogout;
  final VoidCallback? onTap;
  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    this.isLogout = false,
    this.onTap, this.color, required this.showArrow,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : const Color(0xFF5B4025)),
      title: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 16.sp,
          color: isLogout ? Colors.red : (color ?? const Color(0xFF5B4025)),
          fontWeight: isLogout ? FontWeight.w500 : FontWeight.normal,
        ),
        textAlign: TextAlign.start,
      ),
      trailing: showArrow ? Icon(Icons.arrow_forward_ios, color: isLogout ? Colors.red : const Color(0xFF5B4025), size: 18.sp) : null,
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      horizontalTitleGap: 16.w,
    );
  }
}
