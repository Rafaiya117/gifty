import 'package:bestwe2_0/app_State/app_State.dart';
import 'package:bestwe2_0/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F3),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 16.h, bottom: 12.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(Icons.arrow_back_ios_new_rounded, color: const Color(0xFF5B4025), size: 22.sp),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Notifications',
                    style: GoogleFonts.poppins(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF5B4025),
                    ),
                  ),
                ],
              ),
            ),
           Expanded(
              child: Consumer<ApplicationState>(
                builder: (context, appState, _) {
                  return FutureBuilder(
                    future: appState.ensureInitialized(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      // After initialization, use Consumer again to listen for notes changes
                      return Consumer<ApplicationState>(
                        builder: (context, appState, _) {
                          final unotification = appState.giftpotState.notification;
                          if (unotification.isEmpty) {
                            return const Center(child: Text("No notes found"));
                          }
                          return ListView.separated(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            itemCount: unotification.length,
                            separatorBuilder: (_, __) => SizedBox(height: 8.h),
                            itemBuilder: (context, index) {
                              final unotifications = unotification[index];
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 48.w,
                                    height: 48.w,
                                    margin: EdgeInsets.only(
                                      right: 12.w,
                                      top: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF5B4025),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        AppAssets.logo,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8.h,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                unotifications.notificationDate,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: const Color(0xFF5B4025),
                                                ),
                                              ),
                                              SizedBox(width: 120.w),
                                              Text(
                                                unotifications.createdAt,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14.sp,
                                                  color: const Color(0xFF7A6A5C),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            unotifications.notes,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12.sp,
                                              color: const Color(0xFF7A6A5C),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
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